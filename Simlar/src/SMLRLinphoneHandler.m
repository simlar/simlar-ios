/**
 * Copyright (C) 2014 The Simlar Authors.
 *
 * This file is part of Simlar. (https://www.simlar.org)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

#import "SMLRLinphoneHandler.h"

#import "SMLRCallStatus.h"
#import "SMLRCredentials.h"
#import "SMLRLog.h"
#import "SMLRPhoneManagerDelegate.h"

#include <linphone/linphonecore.h>

@interface SMLRLinphoneHandler ()

@property UIBackgroundTaskIdentifier backgroundTaskIdentifier;
@property LinphoneCore *linphoneCore;
@property LinphoneCall *currentCall;
@property NSTimer *iterateTimer;
@property NSTimer *disconnectChecker;
@property NSTimer *disconnectTimeout;
@property SMLRLinphoneHandlerStatus linphoneHandlerStatus;
@property SMLRCallStatus callStatus;

@end

@implementation SMLRLinphoneHandler

static NSString *const kSipDomain  = @"sip.simlar.org";
static NSString *const kStunServer = @"stun.simlar.org";

static const NSTimeInterval kLinphoneIterateInterval   =  0.02;
static const NSTimeInterval kDisconnectCheckerInterval = 20.0;
static const NSTimeInterval kDisconnectTimeout         =  4.0;


- (void)dealloc
{
    SMLRLogFunc;

    if (self.linphoneCore != NULL) {
        SMLRLogE(@"ERROR: dealloc called with linphoneCore != NULL");
        [self destroyLibLinphone];
    }
}

- (NSString *)bundleFile:(NSString *const)file
{
    return [[NSBundle mainBundle] pathForResource:[file stringByDeletingPathExtension] ofType:[file pathExtension]];
}

- (NSString *)documentFile:(NSString *const)file
{
    NSArray *const paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *const documentsPath = paths[0];
    return [documentsPath stringByAppendingPathComponent:file];
}

- (void)initLibLinphone
{
    [self updateStatus:SMLRLinphoneHandlerStatusInitializing];
    [self updateCallStatus:SMLRCallStatusConnectingToServer];

    self.backgroundTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        SMLRLogE(@"ERROR: background task expired");
    }];

    //linphone_core_enable_logs(NULL);
    linphone_core_disable_logs();

    self.linphoneCore = linphone_core_new(&mLinphoneVTable, NULL, NULL, (__bridge void *)(self));

    NSString *const version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    linphone_core_set_user_agent(self.linphoneCore, "simlar-ios", version.UTF8String);

    /// make sure we use random source ports
    const LCSipTransports transportValue = { -1, -1, -1, -1 };
    linphone_core_set_sip_transports(self.linphoneCore, &transportValue);

    /// set audio port range
    linphone_core_set_audio_port_range(self.linphoneCore, 6000, 8000);

    /// set nat traversal
    linphone_core_set_stun_server(self.linphoneCore, kStunServer.UTF8String);
    linphone_core_set_firewall_policy(self.linphoneCore, LinphonePolicyUseIce);

    /// set root ca
    linphone_core_set_root_ca(self.linphoneCore, [self bundleFile:@"simlarca.der"].UTF8String);

    /// enable zrtp
    linphone_core_set_media_encryption(self.linphoneCore, LinphoneMediaEncryptionZRTP);
    linphone_core_set_zrtp_secrets_file(self.linphoneCore, [self documentFile:@"zrtp_secrets"].UTF8String);

    /// remote ringing tone
    linphone_core_set_ringback(self.linphoneCore, [self bundleFile:@"ringback.wav"].UTF8String);

    /// disable video
    linphone_core_enable_video(self.linphoneCore, FALSE, FALSE);
    LinphoneVideoPolicy policy;
    policy.automatically_accept = FALSE;
    policy.automatically_initiate = FALSE;
    linphone_core_set_video_policy(self.linphoneCore, &policy);

    /// We do not want a call response with "486 busy here" if you are not on the phone. So we take a high value of 1 hour.
    /// The Simlar sip server is responsible for terminating a call. Right now it does that after 2 minutes.
    linphone_core_set_inc_timeout(self.linphoneCore, 3600);

    /// make sure we only handle one call
    linphone_core_set_max_calls(self.linphoneCore, 1);

    /// create proxy config
    LinphoneProxyConfig *const proxy_cfg = linphone_proxy_config_new();

    const LinphoneAuthInfo *const info = linphone_auth_info_new([SMLRCredentials getSimlarId].UTF8String, NULL, [SMLRCredentials getPassword].UTF8String, NULL, NULL, NULL);
    linphone_core_add_auth_info(self.linphoneCore, info);

    /// configure proxy entries
    linphone_proxy_config_set_identity(proxy_cfg, [NSString stringWithFormat:@"sip:%@@%@", [SMLRCredentials getSimlarId], kSipDomain].UTF8String);
    linphone_proxy_config_set_server_addr(proxy_cfg, [NSString stringWithFormat:@"sips:%@", kSipDomain].UTF8String);
    linphone_proxy_config_enable_register(proxy_cfg, TRUE);
    linphone_proxy_config_set_expires(proxy_cfg, 60);

    linphone_core_add_proxy_config(self.linphoneCore, proxy_cfg);
    linphone_core_set_default_proxy(self.linphoneCore, proxy_cfg);

    /// call iterate once immediately in order to initiate background connections with sip server, if any
    linphone_core_iterate(self.linphoneCore);
    self.iterateTimer = [NSTimer scheduledTimerWithTimeInterval:kLinphoneIterateInterval
                                                         target:self
                                                       selector:@selector(iterate)
                                                       userInfo:nil
                                                        repeats:YES];

    /// check if we are connected
    /// this is needed e.g. if started in airplane mode
    if (!linphone_core_is_network_reachable(self.linphoneCore)) {
        [self registrationStateChanged:proxy_cfg state:LinphoneRegistrationFailed message:"network unreachable"];
    }

    [self startDisconnectChecker];
}

- (void)iterate
{
    if (self.linphoneCore == NULL) {
        return;
    }

    linphone_core_iterate(self.linphoneCore);
}

- (void)startDisconnectChecker
{
    if (self.disconnectChecker) {
        SMLRLogI(@"ERROR: disconnect timer already running");
        return;
    }

    self.disconnectChecker = [NSTimer scheduledTimerWithTimeInterval:kDisconnectCheckerInterval
                                                              target:self
                                                            selector:@selector(disconnectCheck)
                                                            userInfo:nil
                                                             repeats:YES];
}

- (void)stopDisconnectChecker
{
    if (!self.disconnectChecker) {
        SMLRLogI(@"ERROR: disconnect timer not running");
        return;
    }

    [self.disconnectChecker invalidate];
    self.disconnectChecker = nil;
}

- (void)disconnectCheck
{
    switch (self.linphoneHandlerStatus) {
        case SMLRLinphoneHandlerStatusNone:
        case SMLRLinphoneHandlerStatusDestroyed:
        case SMLRLinphoneHandlerStatusFailedToConnectToSipServer:
        case SMLRLinphoneHandlerStatusGoingDown:
            [self stopDisconnectChecker];
            break;
        case SMLRLinphoneHandlerStatusInitializing:
            break;
        case SMLRLinphoneHandlerStatusConnectedToSipServer:
            if (linphone_core_get_calls_nb(self.linphoneCore) == 0) {
                SMLRLogI(@"Disconnect Checker triggering disconnect");
                [self stopDisconnectChecker];
                [self disconnect];
            }
            break;
    }
}

- (void)disconnect
{
    SMLRLogFunc;

    if (self.disconnectTimeout) {
        SMLRLogI(@"already disconnecting");
        return;
    }

    [self updateStatus:SMLRLinphoneHandlerStatusGoingDown];

    LinphoneProxyConfig *proxy_cfg = linphone_proxy_config_new();
    linphone_core_get_default_proxy(self.linphoneCore, &proxy_cfg);
    linphone_proxy_config_edit(proxy_cfg);
    linphone_proxy_config_enable_register(proxy_cfg, FALSE);
    linphone_proxy_config_done(proxy_cfg);

    self.disconnectTimeout = [NSTimer scheduledTimerWithTimeInterval:kDisconnectTimeout
                                                              target:self
                                                            selector:@selector(disconnectTimeOut)
                                                            userInfo:nil
                                                             repeats:NO];
}

- (void)disconnectTimeOut
{
    SMLRLogI(@"disconnecting timed out => triggering destroy");
    [self destroyLibLinphone];
}

- (void)cancelDisconnectTimeout
{
    if (self.disconnectTimeout) {
        SMLRLogI(@"cancelling disconnect timeout");
        [self.disconnectTimeout invalidate];
        self.disconnectTimeout = nil;
    }
}

- (void)destroyLibLinphone
{
    SMLRLogI(@"destroying LibLinphone started");

    [self cancelDisconnectTimeout];

    if (self.linphoneCore == NULL) {
        SMLRLogI(@"already destroyed");
        return;
    }

    [self.iterateTimer invalidate];

    LinphoneCore *const tmp = self.linphoneCore;
    self.linphoneCore = NULL;
    linphone_core_destroy(tmp);

    if (self.delegate) {
        [self updateStatus:SMLRLinphoneHandlerStatusDestroyed];
        self.delegate = nil;
    }

    [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskIdentifier];
    SMLRLogI(@"destroying LibLinphone finished");
}

- (void)call:(NSString *const)callee
{
    if (self.linphoneCore == NULL) {
        SMLRLogI(@"ERROR call requested but no linphone core");
        return;
    }

    if ([callee length] == 0) {
        SMLRLogI(@"ERROR call requested but no callee");
        return;
    }

    if (self.linphoneHandlerStatus != SMLRLinphoneHandlerStatusConnectedToSipServer) {
        SMLRLogI(@"ERROR call requested but wrong LinphoneHanlderStatus=%i", self.linphoneHandlerStatus);
        return;
    }

    if (linphone_core_get_calls_nb(self.linphoneCore) != 0) {
        SMLRLogI(@"ERROR call requested but already one ongoing");
        return;
    }

    SMLRLogI(@"registration ok => triggering call to %@", callee);
    LinphoneCall *const call = linphone_core_invite(self.linphoneCore, callee.UTF8String);
    if (call == NULL) {
        SMLRLogI(@"Could not place call to %@\n", callee);
    } else {
        SMLRLogI(@"Call to %@ is in progress...", callee);
        linphone_call_ref(call);
    }
}

- (void)terminateAllCalls
{
    SMLRLogFunc;

    if (self.linphoneCore == NULL) {
        SMLRLogI(@"terminateAllCalls no linphone core");
        return;
    }

    linphone_core_terminate_all_calls(self.linphoneCore);
}

- (void)acceptCall
{
    SMLRLogFunc;

    if (self.linphoneCore == NULL) {
        SMLRLogI(@"acceptCall no linphone core");
        return;
    }

    if (self.currentCall == NULL) {
        SMLRLogI(@"acceptCall no current call");
        return;
    }

    linphone_core_accept_call(self.linphoneCore, self.currentCall);
}

- (void)saveSasVerified
{
    if (self.currentCall == NULL) {
        SMLRLogI(@"verifySas but no current call");
        return;
    }

    linphone_call_set_authentication_token_verified(self.currentCall, true);
}

- (void)updateStatus:(const SMLRLinphoneHandlerStatus)status
{
    if (self.linphoneHandlerStatus == status) {
        return;
    }

    SMLRLogI(@"linphone handler status = %@", nameForSMLRLinphoneHandlerStatus(status));
    self.linphoneHandlerStatus = status;
    [self.delegate onLinphoneHandlerStatusChanged:status];
}

- (SMLRLinphoneHandlerStatus)getLinphoneHandlerStatus
{
    return self.linphoneHandlerStatus;
}

- (void)updateCallStatus:(const SMLRCallStatus)status
{
    if (self.callStatus == status) {
        return;
    }

    SMLRLogI(@"callStatus = %@", nameForSMLRCallStatus(status));
    self.callStatus = status;
    if ([self checkOptionalDelegate:@selector(onCallStatusChanged:)]) {
        [self.phoneManagerDelegate onCallStatusChanged:status];
    }
}

- (SMLRCallStatus)getCallStatus
{
    return self.callStatus;
}

- (LinphoneCall *)getCurrentCall
{
    if (self.linphoneCore == NULL) {
        return NULL;
    }

    if (linphone_core_get_calls_nb(self.linphoneCore) == 0) {
        return NULL;
    }

    // get first call
    return linphone_core_get_calls(self.linphoneCore)->data;
}

- (BOOL)hasIncomingCall
{
    const LinphoneCall *const call = [self getCurrentCall];
    if (call == NULL) {
        return NO;
    }
    return linphone_call_get_state(call) == LinphoneCallIncoming;
}

+ (NSString *)getRemoteUserFromCall:(const LinphoneCall *const)call
{
    if (call == NULL) {
        return nil;
    }

    return [NSString stringWithUTF8String:linphone_address_get_username(linphone_call_get_remote_address(call))];
}

- (NSString *)getCurrentCallRemoteUser
{
    const LinphoneCall *const call = [self getCurrentCall];
    if (call == NULL) {
        return nil;
    }

    return [SMLRLinphoneHandler getRemoteUserFromCall:call];
}

- (BOOL)checkOptionalDelegate:(SEL)aSelector
{
    return self.phoneManagerDelegate && [self.phoneManagerDelegate respondsToSelector:aSelector];
}

static inline SMLRLinphoneHandler *getLinphoneHandler(LinphoneCore *const lc)
{
    SMLRLinphoneHandler *const handler = (__bridge SMLRLinphoneHandler *)linphone_core_get_user_data(lc);
    if (handler.linphoneCore == NULL) {
        SMLRLogI(@"no linphone core");
        return nil;
    }
    assert(handler.linphoneCore == lc);
    return handler;
}


///
/// Linphone callbacks
///

static void registration_state_changed(LinphoneCore *const lc, LinphoneProxyConfig *const cfg, const LinphoneRegistrationState state, const char *const message)
{
    [getLinphoneHandler(lc) registrationStateChanged:cfg state:state message:message];
}

- (void)registrationStateChanged:(const LinphoneProxyConfig *const)cfg state:(const LinphoneRegistrationState)state message:(const char *const)message
{
    SMLRLogI(@"registration state changed: %s", linphone_registration_state_to_string(state));

    switch (state) {
        case LinphoneRegistrationNone:
            // Initial state => ignore
            break;
        case LinphoneRegistrationProgress:
            // registration progress => ignore
            break;
        case LinphoneRegistrationOk:
            // if going down => ignore updates
            if (self.linphoneHandlerStatus != SMLRLinphoneHandlerStatusGoingDown) {
                [self updateStatus:SMLRLinphoneHandlerStatusConnectedToSipServer];
            }
            break;
        case LinphoneRegistrationCleared:
        {
            SMLRLogI(@"Unregistration succeeded => triggering destroy");
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [self destroyLibLinphone];
            });
            break;
        }
        case LinphoneRegistrationFailed:
            [self updateStatus:SMLRLinphoneHandlerStatusFailedToConnectToSipServer];
            [self updateCallStatus:SMLRCallStatusEnded];
            SMLRLogI(@"connecting to server failed => triggering destroy");
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [self destroyLibLinphone];
            });

            break;
    }
}

- (BOOL)callEnded:(const LinphoneCallState)state
{
    if (state == LinphoneCallEnd) {
        return YES;
    }

    if (state == LinphoneCallError || state == LinphoneCallReleased) {
        if (self.linphoneCore == NULL || linphone_core_get_calls_nb(self.linphoneCore) == 0) {
            return YES;
        }
    }

    return NO;
}

static void call_state_changed(LinphoneCore *const lc, LinphoneCall *const call, const LinphoneCallState state, const char *const message)
{
    [getLinphoneHandler(lc) callStateChanged:call state:state message:message];
}

- (void)callStateChanged:(LinphoneCall *const)call state:(const LinphoneCallState)state message:(const char *const)message
{
    SMLRLogI(@"call state changed: %s message=%s", linphone_call_state_to_string(state), message);

    if (self.delegate) {
        if (state == LinphoneCallIncoming) {
            [self.delegate onIncomingCall];
        }
    }

    if (self.currentCall == NULL) {
        self.currentCall = call;
    } else {
        if (self.currentCall != call) {
            SMLRLogI(@"WARNING call has changed");
            self.currentCall = call;
        }
    }

    if (state == LinphoneCallOutgoingInit || state == LinphoneCallOutgoingProgress) {
        [self updateCallStatus:SMLRCallStatusWaitingForContact];
    } else if (state == LinphoneCallOutgoingRinging) {
        [self updateCallStatus:SMLRCallStatusRinging];
    } else if (state == LinphoneCallConnected) {
        [self updateCallStatus:SMLRCallStatusEncrypting];
    }

    if ([self callEnded:state]) {
        [self.delegate onCallEnded];
        [self updateCallStatus:SMLRCallStatusEnded];
        if (self.phoneManagerDelegate) {
            [self.phoneManagerDelegate onCallEnded];
            self.phoneManagerDelegate = nil;

            /// restart disconnect checker to make sure we disconnect but not at once
            [self stopDisconnectChecker];
            [self startDisconnectChecker];
        }

        self.currentCall = NULL;
    }
}

static void call_encryption_changed(LinphoneCore *const lc, LinphoneCall *const call, const bool_t on, const char *const authentication_token)
{
    [getLinphoneHandler(lc) callEncryptionChanged:call encrypted:on sas:@(authentication_token)];
}

- (void)callEncryptionChanged:(LinphoneCall *)call encrypted:(BOOL)encrypted sas:(NSString *)sas
{
    SMLRLogI(@"call encryption changed: encrypted=%hhd sas=%@", encrypted, sas);

    if (encrypted && [sas length] == 0) {
        SMLRLogI(@"call claims to be encrypted but has no sas => treating it as unencrypted");
        encrypted = NO;
    }

    [self updateCallStatus:SMLRCallStatusTalking];

    if (!encrypted) {
        if ([self checkOptionalDelegate:@selector(onCallNotEncrypted)]) {
            [self.phoneManagerDelegate onCallNotEncrypted];
        }
        return;
    }

    if (linphone_call_get_authentication_token_verified(call)) {
        sas = nil;
    }

    if ([self checkOptionalDelegate:@selector(onCallEncrypted:)]) {
        [self.phoneManagerDelegate onCallEncrypted:sas];
    }
}

static void linphone_log(LinphoneCore *lc, const char *const message)
{
    SMLRLogI(@"linphone message: %s", message);
}

static void linphone_log_warning(LinphoneCore *lc, const char *const message)
{
    SMLRLogW(@"linphone warning: %s", message);
}

static const LinphoneCoreVTable mLinphoneVTable = {
    .show = NULL,
    .call_state_changed = call_state_changed,
    .registration_state_changed = registration_state_changed,
    .notify_presence_received = NULL,
    .new_subscription_requested = NULL,
    .auth_info_requested = NULL,
    .display_status = linphone_log,
    .display_message = linphone_log,
    .display_warning = linphone_log_warning,
    .display_url = NULL,
    .text_received = NULL,
    .message_received = NULL,
    .dtmf_received = NULL,
    .transfer_state_changed = NULL,
    .is_composing_received = NULL,
    .configuring_status = NULL,
    .call_encryption_changed = call_encryption_changed,
    .global_state_changed = NULL
};

@end

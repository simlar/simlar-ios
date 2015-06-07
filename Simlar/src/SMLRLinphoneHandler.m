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
#import "SMLRMicrophoneStatus.h"
#import "SMLRNetworkQuality.h"
#import "SMLRPushNotifications.h"
#import "SMLRPhoneManagerDelegate.h"
#import "SMLRServerSettings.h"

#include <linphone/linphonecore.h>

#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>

#undef SMLR_LIB_LINPHONE_LOGGING_ENABLED

@interface SMLRLinphoneHandler ()

@property (nonatomic) UIBackgroundTaskIdentifier backgroundTaskIdentifier;
@property (nonatomic) LinphoneCore *linphoneCore;
@property (nonatomic) NSTimer *iterateTimer;
@property (nonatomic) NSTimer *disconnectChecker;
@property (nonatomic) NSTimer *disconnectTimeout;
@property (nonatomic) NSTimer *callEncryptionChecker;
@property (nonatomic) SMLRLinphoneHandlerStatus linphoneHandlerStatus;
@property (nonatomic) SMLRCallStatus *callStatus;
@property (nonatomic) SMLRNetworkQuality callNetworkQuality;
@property (nonatomic) NSDate *callStatusChangedDate;

@end

@implementation SMLRLinphoneHandler

static NSString *const kStunServer = @"stun.simlar.org";

static const NSTimeInterval kLinphoneIterateInterval   =  0.02;
static const NSTimeInterval kDisconnectCheckerInterval = 20.0;
static const NSTimeInterval kDisconnectTimeout         =  4.0;

- (void)dealloc
{
    SMLRLogFunc;

    if (_linphoneCore != NULL) {
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

#ifdef SMLR_LIB_LINPHONE_LOGGING_ENABLED
static void linphoneLogHandler(const int logLevel, const char *message, va_list messageArguements)
{
    /// TODO: make it work with SMLRLog
    NSLogv([NSString stringWithFormat:@"SMLRLibLinphone: %s", message], messageArguements);
}
#endif

- (void)initLibLinphone
{
    self.backgroundTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        const NSTimeInterval backgroundTimeRemaining = [[UIApplication sharedApplication] backgroundTimeRemaining];
        SMLRLogE(@"background task expired with backgroundTimeRemaining: %f", backgroundTimeRemaining);

        if (backgroundTimeRemaining < 1) {
            [self destroyLibLinphone];
        } else if (backgroundTimeRemaining < 5) {
            [self terminatePossibleIncomingCall];
        }
    }];

    [self updateStatus:SMLRLinphoneHandlerStatusInitializing];
    [self updateCallStatus:[[SMLRCallStatus alloc] initWithStatus:SMLRCallStatusConnectingToServer]];

#ifdef SMLR_LIB_LINPHONE_LOGGING_ENABLED
    linphone_core_enable_logs_with_cb((OrtpLogFunc)linphoneLogHandler);
#else
    linphone_core_disable_logs();
#endif

    self.linphoneCore = linphone_core_new(&mLinphoneVTable, NULL, NULL, (__bridge void *)(self));

    NSString *const version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    linphone_core_set_user_agent(_linphoneCore, "simlar-ios", version.UTF8String);

    /// mtu
    linphone_core_set_mtu(_linphoneCore, 1300);

    /// make sure we use random source ports
    const LCSipTransports transportValue = { -1, -1, -1, -1 };
    linphone_core_set_sip_transports(_linphoneCore, &transportValue);

    /// set audio port range
    linphone_core_set_audio_port_range(_linphoneCore, 6000, 8000);

    /// set nat traversal
    linphone_core_set_stun_server(_linphoneCore, kStunServer.UTF8String);
    linphone_core_set_firewall_policy(_linphoneCore, LinphonePolicyUseIce);

    /// set root ca
    linphone_core_set_root_ca(_linphoneCore, [self bundleFile:@"simlarca.der"].UTF8String);

    /// enable zrtp
    linphone_core_set_media_encryption(_linphoneCore, LinphoneMediaEncryptionZRTP);
    linphone_core_set_zrtp_secrets_file(_linphoneCore, [self documentFile:@"zrtp_secrets"].UTF8String);
    linphone_core_set_media_encryption_mandatory(_linphoneCore, TRUE);
    linphone_core_set_nortp_timeout(_linphoneCore, 20); /// timeout in seconds

    /// remote ringing tone
    linphone_core_set_ringback(_linphoneCore, [self bundleFile:@"ringback.wav"].UTF8String);

    /// pause sound file
    linphone_core_set_play_file(_linphoneCore, [self bundleFile:@"pause.wav"].UTF8String);

    /// Audio device
    NSString const* audioDevice = @"AU: Audio Unit Receiver";
    linphone_core_set_capture_device(_linphoneCore,  [audioDevice UTF8String]);
    linphone_core_set_playback_device(_linphoneCore, [audioDevice UTF8String]);

    /// disable video
    linphone_core_enable_video_capture(_linphoneCore, FALSE);
    linphone_core_enable_video_display(_linphoneCore, FALSE);
    LinphoneVideoPolicy policy;
    policy.automatically_accept = FALSE;
    policy.automatically_initiate = FALSE;
    linphone_core_set_video_policy(_linphoneCore, &policy);

    /// We do not want a call response with "486 busy here" if you are not on the phone. So we take a high value of 1 hour.
    /// The Simlar sip server is responsible for terminating a call. Right now it does that after 2 minutes.
    linphone_core_set_inc_timeout(_linphoneCore, 3600);

    /// make sure we only handle one call
    linphone_core_set_max_calls(_linphoneCore, 1);

    /// create proxy config
    LinphoneProxyConfig *const proxy_cfg = linphone_proxy_config_new();

    const LinphoneAuthInfo *const info = linphone_auth_info_new([SMLRCredentials getSimlarId].UTF8String, NULL, [SMLRCredentials getPassword].UTF8String, NULL, NULL, NULL);
    linphone_core_add_auth_info(_linphoneCore, info);

    /// configure proxy entries
    linphone_proxy_config_set_identity(proxy_cfg, [NSString stringWithFormat:@"sip:%@@" SIMLAR_DOMAIN, [SMLRCredentials getSimlarId]].UTF8String);
    linphone_proxy_config_set_server_addr(proxy_cfg, (@"sips:" SIMLAR_DOMAIN).UTF8String);
    linphone_proxy_config_enable_register(proxy_cfg, TRUE);
    linphone_proxy_config_set_expires(proxy_cfg, 60);

    linphone_core_add_proxy_config(_linphoneCore, proxy_cfg);
    linphone_core_set_default_proxy(_linphoneCore, proxy_cfg);

    /// call iterate once immediately in order to initiate background connections with sip server, if any
    linphone_core_iterate(_linphoneCore);
    self.iterateTimer = [NSTimer scheduledTimerWithTimeInterval:kLinphoneIterateInterval
                                                         target:self
                                                       selector:@selector(iterate)
                                                       userInfo:nil
                                                        repeats:YES];

    /// check if we are connected
    /// this is needed e.g. if started in airplane mode
    if (!linphone_core_is_network_reachable(_linphoneCore)) {
        [self registrationStateChanged:proxy_cfg state:LinphoneRegistrationFailed message:"network unreachable"];
    }

    [self startDisconnectChecker];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(audioSessionInterrupted:)
                                                 name:AVAudioSessionInterruptionNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(audioSessionRouteChanged:)
                                                 name:AVAudioSessionRouteChangeNotification
                                               object:nil];

    [SMLRLinphoneHandler enableExternalSpeaker:NO];
}

- (void)terminatePossibleIncomingCall
{
    LinphoneCall *const call = [self getCurrentCall];
    if (![SMLRLinphoneHandler isIncomingCall:call]) {
        SMLRLogI(@"terminatePossibleIncomingCall no incoming call");
        return;
    }

    SMLRLogI(@"terminatePossibleIncomingCall declining call with reason not answered");
    linphone_core_decline_call(_linphoneCore, call, LinphoneReasonNotAnswered);
}

- (void)iterate
{
    if (_linphoneCore == NULL) {
        return;
    }

    linphone_core_iterate(_linphoneCore);
}

- (void)startDisconnectChecker
{
    if (_disconnectChecker) {
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
    if (!_disconnectChecker) {
        SMLRLogI(@"ERROR: disconnect timer not running");
        return;
    }

    [_disconnectChecker invalidate];
    self.disconnectChecker = nil;
}

- (void)disconnectCheck
{
    switch (_linphoneHandlerStatus) {
        case SMLRLinphoneHandlerStatusNone:
        case SMLRLinphoneHandlerStatusDestroyed:
        case SMLRLinphoneHandlerStatusFailedToConnectToSipServer:
        case SMLRLinphoneHandlerStatusGoingDown:
            [self stopDisconnectChecker];
            break;
        case SMLRLinphoneHandlerStatusInitializing:
            break;
        case SMLRLinphoneHandlerStatusConnectedToSipServer:
            if (linphone_core_get_calls_nb(_linphoneCore) == 0) {
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

    if (_disconnectTimeout) {
        SMLRLogI(@"already disconnecting");
        return;
    }

    [self updateStatus:SMLRLinphoneHandlerStatusGoingDown];

    LinphoneProxyConfig *proxy_cfg = linphone_core_get_default_proxy_config(_linphoneCore);
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
    if (_disconnectTimeout) {
        SMLRLogI(@"cancelling disconnect timeout");
        [_disconnectTimeout invalidate];
        self.disconnectTimeout = nil;
    }
}

- (void)destroyLibLinphone
{
    SMLRLogI(@"destroying LibLinphone started");

    [self cancelDisconnectTimeout];

    if (_linphoneCore == NULL) {
        SMLRLogI(@"already destroyed");
        return;
    }

    [_iterateTimer invalidate];

    LinphoneCore *const tmp = _linphoneCore;
    self.linphoneCore = NULL;
    linphone_core_destroy(tmp);

    if (_delegate) {
        [self updateStatus:SMLRLinphoneHandlerStatusDestroyed];
        self.delegate = nil;
    }

    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionInterruptionNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionRouteChangeNotification object:nil];

    [self updateAudioSession];

    [[UIApplication sharedApplication] endBackgroundTask:_backgroundTaskIdentifier];
    SMLRLogI(@"destroying LibLinphone finished");
}

- (void)audioSessionRouteChanged:(NSNotification *const)notification
{
    SMLRLogFunc;

    if (_phoneManagerDelegate) {
        NSString *const oldOutput = [SMLRLinphoneHandler getRouteOutput:notification.userInfo[AVAudioSessionRouteChangePreviousRouteKey]];
        NSString *const newOutput = [SMLRLinphoneHandler getRouteOutput:[[AVAudioSession sharedInstance] currentRoute]];

        if (![oldOutput isEqualToString:newOutput]) {
            SMLRLogI(@"audio session output route changed: %@ -> %@", oldOutput, newOutput);
            const BOOL oldRouteEnabledSpeaker = [AVAudioSessionPortBuiltInSpeaker isEqualToString:oldOutput];
            const BOOL newRouteEnabledSpeaker = [AVAudioSessionPortBuiltInSpeaker isEqualToString:newOutput];
            if (oldRouteEnabledSpeaker != newRouteEnabledSpeaker) {
                SMLRLogI(@"audioSessionRouteChanged: external speaker now: %@", newRouteEnabledSpeaker ? @"enabled" : @"disabled");
                [_phoneManagerDelegate onExternalSpeakerChanged:newRouteEnabledSpeaker];
            }
        }
    }
}

+ (NSString *)getRouteOutput:(AVAudioSessionRouteDescription *const)route
{
    const NSUInteger count = [[route outputs] count];

    if (count == 0) {
        SMLRLogE(@"no output found in audio session: %@", route);
        return nil;
    }

    if (count != 1) {
        SMLRLogW(@"unexpected output count: %lu", (unsigned long) count);
    }

    return ((AVAudioSessionPortDescription*)[[route outputs] firstObject]).portType;
}

- (void)audioSessionInterrupted:(NSNotification *const)notification
{
    SMLRLogFunc;

    LinphoneCall *const call = [self getCurrentCall];
    if (call == NULL) {
        return;
    }

    const AVAudioSessionInterruptionType type = [notification.userInfo[AVAudioSessionInterruptionTypeKey] intValue];
    switch (type) {
        case AVAudioSessionInterruptionTypeBegan:
            if (linphone_call_get_state(call) == LinphoneCallStreamsRunning) {
                SMLRLogI(@"pausing current call");
                linphone_core_pause_all_calls(_linphoneCore);
            }
            break;
        case AVAudioSessionInterruptionTypeEnded:
            if (linphone_call_get_state(call) == LinphoneCallPaused) {
                SMLRLogI(@"resuming current call");
                [self updateAudioSession];
                linphone_core_resume_call(_linphoneCore, call);
            } else {
                SMLRLogE(@"Error not resuming current call with status %s", linphone_call_state_to_string(linphone_call_get_state(call)));
            }
            break;
    }
}

- (void)updateAudioSession
{
    SMLRLogI(@"setting audio status according to call state: %@", _callStatus);

    AVAudioSession *const sharedAudioSession = [AVAudioSession sharedInstance];

    if (sharedAudioSession == nil) {
        SMLRLogE(@"no shared audio session")
        return;
    }

    NSError *error = nil;

    switch (_callStatus.enumValue) {
        case SMLRCallStatusNone:
        case SMLRCallStatusEnded:
            [sharedAudioSession setCategory:AVAudioSessionCategorySoloAmbient
                                      error:&error];
            break;
        case SMLRCallStatusIncomingCall:
            [sharedAudioSession setCategory:AVAudioSessionCategoryMultiRoute
                                withOptions:AVAudioSessionCategoryOptionDuckOthers
                                      error:&error];
            break;
        case SMLRCallStatusConnectingToServer:
        case SMLRCallStatusWaitingForContact:
        case SMLRCallStatusRemoteRinging:
        case SMLRCallStatusEncrypting:
        case SMLRCallStatusTalking:
            [sharedAudioSession setCategory:AVAudioSessionCategoryPlayAndRecord
                                withOptions:AVAudioSessionCategoryOptionDuckOthers|AVAudioSessionCategoryOptionAllowBluetooth
                                      error:&error];
            break;
    }

    if (error != nil) {
        SMLRLogE(@"Error while setting category of audio session: %@", error);
        return;
    }

    switch (_callStatus.enumValue) {
        case SMLRCallStatusNone:
        case SMLRCallStatusEnded:
        case SMLRCallStatusIncomingCall:
            [sharedAudioSession setMode:AVAudioSessionModeDefault error:&error];
            break;
        case SMLRCallStatusConnectingToServer:
        case SMLRCallStatusWaitingForContact:
        case SMLRCallStatusRemoteRinging:
        case SMLRCallStatusEncrypting:
        case SMLRCallStatusTalking:
            [sharedAudioSession setMode:AVAudioSessionModeVoiceChat error:&error];
            break;
    }

    if (error != nil) {
        SMLRLogE(@"Error while setting mode of audio session: %@", error);
        return;
    }
}

- (void)call:(NSString *const)callee
{
    if (_linphoneCore == NULL) {
        SMLRLogI(@"ERROR call requested but no linphone core");
        return;
    }

    if ([callee length] == 0) {
        SMLRLogI(@"ERROR call requested but no callee");
        return;
    }

    if (_linphoneHandlerStatus != SMLRLinphoneHandlerStatusConnectedToSipServer) {
        SMLRLogI(@"ERROR call requested but wrong LinphoneHandlerStatus=%@", nameForSMLRLinphoneHandlerStatus(_linphoneHandlerStatus));
        return;
    }

    if (linphone_core_get_calls_nb(_linphoneCore) != 0) {
        SMLRLogI(@"ERROR call requested but already one ongoing");
        return;
    }

    SMLRLogI(@"registration ok => triggering call to %@", callee);
    LinphoneCall *const call = linphone_core_invite(_linphoneCore, callee.UTF8String);
    if (call == NULL) {
        SMLRLogI(@"Could not place call to %@", callee);
    } else {
        SMLRLogI(@"Call to %@ is in progress...", callee);
        linphone_call_ref(call);
    }
}

- (void)terminateAllCalls
{
    SMLRLogFunc;

    if (_linphoneCore == NULL) {
        SMLRLogI(@"terminateAllCalls no linphone core");
        return;
    }

    linphone_core_terminate_all_calls(_linphoneCore);
}

- (void)acceptCall
{
    SMLRLogFunc;

    LinphoneCall *const call = [self getCurrentCall];
    if (call == NULL) {
        SMLRLogI(@"acceptCall no current call");
        return;
    }

    linphone_core_accept_call(_linphoneCore, call);
}

- (void)saveSasVerified
{
    LinphoneCall *const call = [self getCurrentCall];
    if (call == NULL) {
        SMLRLogI(@"verifySas but no current call");
        return;
    }

    linphone_call_set_authentication_token_verified(call, true);
}

- (void)toggleMicrophoneMuted
{
    if (_linphoneCore == NULL) {
        SMLRLogW(@"toggleMicrophoneMuted no linphone core");
        return;
    }

    if (_callStatus.enumValue == SMLRCallStatusEncrypting) {
        SMLRLogW(@"not toggling microphone as we are encrypting");
        return;
    }

    [self setMicrophoneStatus:linphone_core_mic_enabled(_linphoneCore) ? SMLRMicrophoneStatusMuted : SMLRMicrophoneStatusNormal];
}

- (void)setMicrophoneStatus:(const SMLRMicrophoneStatus)status
{
    if (_linphoneCore == NULL) {
        SMLRLogW(@"setMicrophoneMuted no linphone core");
        return;
    }

    linphone_core_enable_mic(_linphoneCore, status == SMLRMicrophoneStatusNormal);
    [_phoneManagerDelegate onMicrophoneStatusChanged:status];
}

+ (void)toggleExternalSpeaker
{
    const BOOL enabled = [AVAudioSessionPortBuiltInSpeaker isEqualToString:[SMLRLinphoneHandler getRouteOutput:[[AVAudioSession sharedInstance] currentRoute]]];
    [SMLRLinphoneHandler enableExternalSpeaker:!enabled];
}

+ (void)enableExternalSpeaker:(const BOOL)enable
{
    NSError *error = nil;
    const AVAudioSessionPortOverride portOverride = enable ? AVAudioSessionPortOverrideSpeaker : AVAudioSessionPortOverrideNone;
    [[AVAudioSession sharedInstance] overrideOutputAudioPort:portOverride error:&error];
    if (error != nil) {
        SMLRLogE(@"Error while setting external speaker enable='%d': %@", enable, error);
        return;
    }
}

- (void)updateStatus:(const SMLRLinphoneHandlerStatus)status
{
    if (_linphoneHandlerStatus == status) {
        return;
    }

    SMLRLogI(@"linphone handler status = %@", nameForSMLRLinphoneHandlerStatus(status));
    self.linphoneHandlerStatus = status;
    [_delegate onLinphoneHandlerStatusChanged:status];
}

- (SMLRLinphoneHandlerStatus)getLinphoneHandlerStatus
{
    return _linphoneHandlerStatus;
}

- (BOOL)updateCallStatus:(SMLRCallStatus *const)status
{
    if ([_callStatus isEqualToCallStatus:status]) {
        return NO;
    }

    SMLRLogI(@"callStatus = %@", status);
    self.callStatus = status;

    switch (status.enumValue) {
        case SMLRCallStatusNone:
        case SMLRCallStatusIncomingCall:
            self.callStatusChangedDate = nil;
            break;
        case SMLRCallStatusConnectingToServer:
        case SMLRCallStatusWaitingForContact:
        case SMLRCallStatusRemoteRinging:
        case SMLRCallStatusEncrypting:
        case SMLRCallStatusTalking:
            self.callStatusChangedDate = [[NSDate alloc] init];
            break;
        case SMLRCallStatusEnded:
            break;
    }

    [_phoneManagerDelegate onCallStatusChanged:status];

    return YES;
}

- (SMLRCallStatus *)getCallStatus
{
    return _callStatus;
}

- (NSDate *)getCallStatusChangedDate
{
    return _callStatusChangedDate;
}

- (SMLRNetworkQuality)getCallNetworkQuality
{
    return _callNetworkQuality;
}

- (LinphoneCall *)getCurrentCall
{
    if (_linphoneCore == NULL) {
        return NULL;
    }

    if (linphone_core_get_calls_nb(_linphoneCore) == 0) {
        return NULL;
    }

    // get first call
    return linphone_core_get_calls(_linphoneCore)->data;
}

+ (BOOL)isIncomingCall:(const LinphoneCall *const)call
{
    if (call == NULL) {
        return NO;
    }

    const LinphoneCallState state = linphone_call_get_state(call);
    return state == LinphoneCallIncomingReceived || state == LinphoneCallIncomingEarlyMedia;
}

- (BOOL)hasIncomingCall
{
    return [SMLRLinphoneHandler isIncomingCall:[self getCurrentCall]];
}

+ (NSString *)getRemoteUserFromCall:(const LinphoneCall *const)call
{
    if (call == NULL) {
        return nil;
    }

    return @(linphone_address_get_username(linphone_call_get_remote_address(call)));
}

- (NSString *)getCurrentCallRemoteUser
{
    const LinphoneCall *const call = [self getCurrentCall];
    if (call == NULL) {
        return nil;
    }

    return [SMLRLinphoneHandler getRemoteUserFromCall:call];
}

+ (NSString *)getCallEndReasonFromCall:(LinphoneCall *const) call
{
    const LinphoneReason reason = linphone_call_get_reason(call);
    switch (reason) {
        case LinphoneReasonNone:
            return @"Call ended";
        case LinphoneReasonDeclined:
            return @"Call declined";
        case LinphoneReasonBusy:
            return @"Busy";
        case LinphoneReasonNotFound:
        case LinphoneReasonTemporarilyUnavailable:
            return @"Contact is offline";
        case LinphoneReasonNotAnswered:
            return @"Contact did not answer";
        /// unexpected reasons
        case LinphoneReasonNoResponse:
        case LinphoneReasonForbidden:
        case LinphoneReasonUnsupportedContent:
        case LinphoneReasonIOError:
        case LinphoneReasonDoNotDisturb:
        case LinphoneReasonUnauthorized:
        case LinphoneReasonNotAcceptable:
        case LinphoneReasonNoMatch:
        case LinphoneReasonMovedPermanently:
        case LinphoneReasonGone:
        case LinphoneReasonAddressIncomplete:
        case LinphoneReasonNotImplemented:
        case LinphoneReasonBadGateway:
        case LinphoneReasonServerTimeout:
        case LinphoneReasonUnknown:
            return [NSString stringWithFormat:@"Error: %s", linphone_reason_to_string(reason)];
    }
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
            if (_linphoneHandlerStatus != SMLRLinphoneHandlerStatusGoingDown) {
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
            [self updateCallStatus:[[SMLRCallStatus alloc] initWithEndReason:@"You are offline" wantsDismiss:NO]];
            SMLRLogI(@"connecting to server failed => triggering destroy");
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [self destroyLibLinphone];
            });

            break;
    }
}

- (LinphoneCallState)fixLinphoneCallState:(const LinphoneCallState)state
{
    if (state == LinphoneCallError || state == LinphoneCallReleased) {
        if (_linphoneCore == NULL || linphone_core_get_calls_nb(_linphoneCore) == 0) {
            SMLRLogI(@"fixed LinphoneCallState: %s -> LinphoneCallEnd", linphone_call_state_to_string(state));
            return LinphoneCallEnd;
        }
    }

    return state;
}

static void call_state_changed(LinphoneCore *const lc, LinphoneCall *const call, const LinphoneCallState state, const char *const message)
{
    [getLinphoneHandler(lc) callStateChanged:call state:state message:message];
}

- (void)callStateChanged:(LinphoneCall *const)call state:(const LinphoneCallState)state message:(const char *const)message
{
    const LinphoneCallState fixedState = [self fixLinphoneCallState:state];

    SMLRLogI(@"call state changed: %s message=%s", linphone_call_state_to_string(fixedState), message);

    switch (fixedState) {
        case LinphoneCallOutgoingInit:
        case LinphoneCallOutgoingProgress:
            [self updateAudioSession];
            [self updateCallStatus:[[SMLRCallStatus alloc] initWithStatus:SMLRCallStatusWaitingForContact]];
            break;
        case LinphoneCallOutgoingRinging:
            [self updateCallStatus:[[SMLRCallStatus alloc] initWithStatus:SMLRCallStatusRemoteRinging]];
            break;
        case LinphoneCallIncomingReceived:
            if ([self updateCallStatus:[[SMLRCallStatus alloc] initWithStatus:SMLRCallStatusIncomingCall]]) {
                [self updateAudioSession];
                [_delegate onIncomingCall];
            }
            break;
        case LinphoneCallConnected:
            if ([self updateCallStatus:[[SMLRCallStatus alloc] initWithStatus:SMLRCallStatusEncrypting]]) {
                [self setMicrophoneStatus:SMLRMicrophoneStatusDisabled];
                [self updateAudioSession];
            }
            break;
        case LinphoneCallEnd:
        {
            const BOOL wasIncomingCall = _callStatus.enumValue == SMLRCallStatusIncomingCall;
            NSString *const callEndReason = [SMLRLinphoneHandler getCallEndReasonFromCall:call];
            if ([self updateCallStatus:[[SMLRCallStatus alloc] initWithEndReason:callEndReason wantsDismiss:wasIncomingCall]]) {
                self.callNetworkQuality = SMLRNetworkQualityUnknown;

                [_delegate onCallEnded:wasIncomingCall ? [SMLRLinphoneHandler getRemoteUserFromCall:call] : nil];

                self.phoneManagerDelegate = nil;

                if ([SMLRPushNotifications isVoipSupported]) {
                    [self stopDisconnectChecker];
                    [self disconnect];
                } else {
                    /// restart disconnect checker to make sure we disconnect but not at once
                    [self stopDisconnectChecker];
                    [self startDisconnectChecker];
                }
            }
        }
        case LinphoneCallIdle:
        case LinphoneCallOutgoingEarlyMedia:
        case LinphoneCallStreamsRunning:
        case LinphoneCallPausing:
        case LinphoneCallPaused:
        case LinphoneCallResuming:
        case LinphoneCallRefered:
        case LinphoneCallError:
        case LinphoneCallPausedByRemote:
        case LinphoneCallUpdatedByRemote:
        case LinphoneCallIncomingEarlyMedia:
        case LinphoneCallUpdating:
        case LinphoneCallReleased:
        case LinphoneCallEarlyUpdatedByRemote:
        case LinphoneCallEarlyUpdating:
            SMLRLogI(@"call state changed but unhandled: %s message=%s", linphone_call_state_to_string(fixedState), message);
            break;
    }
}

static void call_encryption_changed(LinphoneCore *const lc, LinphoneCall *const call, const bool_t on, const char *const authentication_token)
{
    [getLinphoneHandler(lc) callEncryptionChanged:call encrypted:on sas:@(authentication_token)];
}

- (void)callEncryptionChanged:(LinphoneCall *)call encrypted:(BOOL)encrypted sas:(NSString *)sas
{
    SMLRLogI(@"call encryption changed: encrypted=%d sas=%@", encrypted, sas);

    if (encrypted && [sas length] == 0) {
        SMLRLogI(@"call claims to be encrypted but has no sas => treating it as unencrypted");
        encrypted = NO;
    }

    [self updateCallStatus:[[SMLRCallStatus alloc] initWithStatus:SMLRCallStatusTalking]];
    [self setMicrophoneStatus:SMLRMicrophoneStatusNormal];

    if (encrypted) {
        [_phoneManagerDelegate onCallEncrypted:sas
                                   sasVerified:linphone_call_get_authentication_token_verified(call)];
    }
}

static void call_stats_updated(LinphoneCore *const lc, LinphoneCall *const call, const LinphoneCallStats *const stats)
{
    [getLinphoneHandler(lc) callStatsUpdated:call stats:stats];
}

- (void)callStatsUpdated:(LinphoneCall *const)call stats:(const LinphoneCallStats *const)stats
{
    const SMLRNetworkQuality quality = createNetworkQualityWithFloat(linphone_call_get_current_quality(call));
    if (_callNetworkQuality != quality) {
        self.callNetworkQuality = quality;
        SMLRLogI(@"call quality updated: %@", nameForSMLRNetworkQuality(quality));

        [_phoneManagerDelegate onCallNetworkQualityChanged:quality];
    }
}

static const LinphoneCoreVTable mLinphoneVTable = {
    .call_encryption_changed    = call_encryption_changed,
    .call_state_changed         = call_state_changed,
    .call_stats_updated         = call_stats_updated,
    .registration_state_changed = registration_state_changed,
};

@end

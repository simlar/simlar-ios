/**
 * Copyright (C) 2019 The Simlar Authors.
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

#import "SMLRProviderDelegate.h"

#import "SMLRCallStatus.h"
#import "SMLRLog.h"
#import "SMLRPhoneManager.h"
#import "SMLRPhoneManagerDelegate.h"
#import "SMLRRingtone.h"

#import <AVFoundation/AVFoundation.h>
#import <CallKit/CallKit.h>

@interface SMLRProviderDelegate () <CXProviderDelegate, SMLRPhoneManagerCallStatusDelegate>

@property (nonatomic) CXProvider *provider;
@property (weak, nonatomic) SMLRPhoneManager *phoneManager;

@end

@implementation SMLRProviderDelegate

- (instancetype)initWithPhoneManager:(SMLRPhoneManager *const)phoneManager
{
    self = [super init];
    if (self == nil) {
        SMLRLogE(@"unable to create SMLRProviderDelegate");
        return nil;
    }

    _phoneManager = phoneManager;

    [self providerConfiguration];

    return self;
}

- (void)providerConfiguration
{
    CXProviderConfiguration *const config = [[CXProviderConfiguration alloc]
        initWithLocalizedName:[NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleDisplayName"]];
    config.ringtoneSound = SIMLAR_RINGTONE;
    config.supportsVideo = NO;
    config.iconTemplateImageData = UIImagePNGRepresentation([UIImage imageNamed:@"CallkitLogo"]);
    config.maximumCallGroups = 1;
    config.maximumCallsPerCallGroup = 1;
    config.supportedHandleTypes = [NSSet setWithObjects:[NSNumber numberWithInteger:CXHandleTypeGeneric], [NSNumber numberWithInteger:CXHandleTypePhoneNumber], nil];

    self.provider = [[CXProvider alloc] initWithConfiguration:config];
    [_provider setDelegate:self queue:dispatch_get_main_queue()];
}

- (void)reportIncomingCallWithHandle:(NSString *const)handle
{
    SMLRLogFunc;

    CXCallUpdate *const update = [[CXCallUpdate alloc] init];
    update.remoteHandle = [[CXHandle alloc] initWithType:CXHandleTypePhoneNumber value:handle];
    update.supportsDTMF = NO;
    update.supportsHolding = NO;

    NSUUID *const uuid = [_phoneManager newCallUuid];

    SMLRLogI(@"reportNewIncomingCall with uuid=%@ and handle=%@", uuid, handle);
    [_provider reportNewIncomingCallWithUUID:uuid
                                      update:update
                                  completion:^(NSError *const error) {
        SMLRLogI(@"update: %@", update);

        if (error) {
            SMLRLogE(@"error: %@", error);
        }
    }];
}

#pragma mark - SMLRPhoneManagerCallStatusDelegate Protocol
- (void)onCallStatusChanged:(SMLRCallStatus *const)callStatus
{
    switch (callStatus.enumValue) {
        case SMLRCallStatusNone:
        case SMLRCallStatusConnectingToServer:
        case SMLRCallStatusWaitingForContact:
        case SMLRCallStatusRemoteRinging:
        case SMLRCallStatusIncomingCall:
        case SMLRCallStatusEncrypting:
            break;
        case SMLRCallStatusTalking:
            [_provider reportOutgoingCallWithUUID:[_phoneManager getCallUuid] connectedAtDate:[NSDate date]];
            break;
        case SMLRCallStatusEnded:
            [_phoneManager endCallkitCall];
            break;
    }
}

#pragma mark - CXProviderDelegate Protocol
- (void)providerDidReset:(nonnull CXProvider *const)provider
{
    SMLRLogFunc;
}

- (void)provider:(CXProvider *)provider performStartCallAction:(CXStartCallAction *)action {
    NSUUID *const uuid = action.callUUID;
    SMLRLogI(@"start call with uuid=%@", uuid);

    [self configureAudioSession];

    [_provider reportOutgoingCallWithUUID:uuid startedConnectingAtDate:[NSDate date]];
    [_provider reportOutgoingCallWithUUID:uuid connectedAtDate:nil];

    [_phoneManager callWithSimlarId:[action contactIdentifier]];

    [action fulfill];
}

- (void)provider:(CXProvider *)provider performAnswerCallAction:(CXAnswerCallAction *const)action
{
    SMLRLogFunc;
    NSUUID *const uuid = action.callUUID;
    SMLRLogI(@"answer call with uuid=%@", uuid);

    [self configureAudioSession];

    [action fulfill];
}

- (void)configureAudioSession
{
    AVAudioSession *const audioSession = [AVAudioSession sharedInstance];

    NSError *error = nil;
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord
                         mode:AVAudioSessionModeVoiceChat
                      options:AVAudioSessionCategoryOptionAllowBluetooth | AVAudioSessionCategoryOptionAllowBluetoothA2DP
                        error:&error];
    if (error) {
        SMLRLogE(@"Error while setting audioSessionCategory: %@", error);
        error = nil;
    }

    [audioSession setMode:AVAudioSessionModeVoiceChat error:&error];
    if (error) {
        SMLRLogE(@"Error while setting audioSessionMode: %@", error);
        error = nil;
    }

    const double sampleRate = 48000.0;
    [audioSession setPreferredSampleRate:sampleRate error:&error];
    if (error) {
        SMLRLogE(@"Error while setting audioSessionSampleRate: %@", error);
        error = nil;
    }

    [audioSession setActive:YES error:nil];
    if (error) {
        SMLRLogE(@"Error while activating audioSession: %@", error);
        error = nil;
    }
}

- (void)provider:(CXProvider *)provider performEndCallAction:(CXEndCallAction *const)action
{
    SMLRLogFunc;
    NSUUID *const uuid = action.callUUID;
    SMLRLogI(@"answer call with uuid=%@", uuid);

    [_phoneManager terminateAllCalls];

    [action fulfill];
}

- (void)provider:(CXProvider *)provider didActivateAudioSession:(AVAudioSession *)audioSession
{
    SMLRLogFunc;

    [_phoneManager acceptCall];
}

- (void)provider:(CXProvider *)provider performSetMutedCallAction:(nonnull CXSetMutedCallAction *)action
{
    SMLRLogFunc;

    [_phoneManager toggleMicrophoneMuted];
    [action fulfill];
}

@end

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

#import "SMLRCallViewController.h"

#import "SMLRAudioOutputType.h"
#import "SMLRCallSoundManager.h"
#import "SMLRCallStatus.h"
#import "SMLRContact.h"
#import "SMLRLog.h"
#import "SMLRMicrophoneStatus.h"
#import "SMLRNetworkQuality.h"
#import "SMLRPhoneManager.h"
#import "SMLRPhoneManagerDelegate.h"

#import <MediaPlayer/MediaPlayer.h>

@interface SMLRCallViewController () <SMLRPhoneManagerDelegate>

@property (nonatomic, readonly) SMLRCallSoundManager *soundManager;
@property (nonatomic) NSTimer *callStatusTimeIterator;

@property (weak, nonatomic) IBOutlet UILabel *contactName;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *statusChangedTime;

@property (weak, nonatomic) IBOutlet UIView *networkQualityView;
@property (weak, nonatomic) IBOutlet UILabel *networkQuality;

@property (weak, nonatomic) IBOutlet UIView *verifiedSasView;
@property (weak, nonatomic) IBOutlet UILabel *verifiedSas;

@property (weak, nonatomic) IBOutlet UIView *encryptionView;
@property (weak, nonatomic) IBOutlet UILabel *sas;

@property (weak, nonatomic) IBOutlet UIView *endReasonView;
@property (weak, nonatomic) IBOutlet UILabel *endReason;

@property (weak, nonatomic) IBOutlet UIView *controlButtonsView;
@property (weak, nonatomic) IBOutlet UIButton *microMuteButton;
@property (weak, nonatomic) IBOutlet UIButton *speakerButton;
@property (weak, nonatomic) IBOutlet UIView *speakerBluetoothButton;

@property (weak, nonatomic) IBOutlet UIButton *hangUpButton;

- (IBAction)sasVerifiedButtonPressed:(id)sender;
- (IBAction)sasDoNotCareButtonPressed:(id)sender;

- (IBAction)microMuteButtonPressed:(id)sender;
- (IBAction)speakerButtonPressed:(id)sender;

- (IBAction)hangUpButtonPressed:(id)sender;

@end

@implementation SMLRCallViewController

- (instancetype)initWithCoder:(NSCoder *const)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self == nil) {
        SMLRLogE(@"unable to create SMLRCallViewController");
        return nil;
    }

    _soundManager = [[SMLRCallSoundManager alloc] init];

    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    SMLRLogFunc;

    MPVolumeView *const volumeView = [[MPVolumeView alloc] initWithFrame:_speakerBluetoothButton.bounds];
    volumeView.showsVolumeSlider = NO;
    volumeView.showsRouteButton = YES;
    [volumeView setRouteButtonImage:[UIImage imageNamed:@"SpeakerBluetoothAvailable"] forState:UIControlStateNormal];
    [volumeView setRouteButtonImage:[UIImage imageNamed:@"SpeakerBluetoothAvailableHighlighted"] forState:UIControlStateHighlighted];
    [_speakerBluetoothButton addSubview:volumeView];

    [self update];
}

- (void)update
{
    SMLRLogI(@"update with callStatus=%@", [_phoneManager getCallStatus]);
    [_phoneManager setDelegate:self];
    _contactName.text = _contact.name;

    [self onCallStatusChanged:[_phoneManager getCallStatus]];
    [self onCallNetworkQualityChanged:[_phoneManager getCallNetworkQuality]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    SMLRLogFunc;

    [UIDevice currentDevice].proximityMonitoringEnabled = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appplicationDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

- (void)appplicationDidBecomeActive
{
    SMLRLogFunc;
}

- (void)viewWillDisappear:(BOOL)animated
{
    SMLRLogFunc;
    [UIDevice currentDevice].proximityMonitoringEnabled = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];

    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)sasVerifiedButtonPressed:(id)sender
{
    [self onCallEncrypted:_sas.text sasVerified:YES];
    [_phoneManager saveSasVerified];
}

- (IBAction)sasDoNotCareButtonPressed:(id)sender
{
    _encryptionView.hidden = YES;
}

- (IBAction)hangUpButtonPressed:(id)sender
{
    [_phoneManager endCallkitCall];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)microMuteButtonPressed:(id)sender
{
    SMLRLogFunc;

    [_phoneManager toggleMicrophoneMuted];
}

- (IBAction)speakerButtonPressed:(id)sender
{
    SMLRLogFunc;

    [SMLRPhoneManager toggleExternalSpeaker];
}

- (BOOL)isVisible
{
    return [UIApplication sharedApplication].applicationState == UIApplicationStateActive && self.isViewLoaded && self.view.window;
}

- (void)startCallStatusTimeIterator
{
    SMLRLogFunc;

    [self callStatusIterator];

    if (_callStatusTimeIterator != nil) {
        SMLRLogI(@"call status time iterator already running");
        return;
    }

    self.callStatusTimeIterator = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                                   target:self
                                                                 selector:@selector(callStatusIterator)
                                                                 userInfo:nil
                                                                  repeats:YES];
}

- (void)stopCallStatusTimeIterator
{
    SMLRLogFunc;

    if (!_callStatusTimeIterator) {
        SMLRLogI(@"call status time iterator not running");
        return;
    }

    [_callStatusTimeIterator invalidate];
    self.callStatusTimeIterator = nil;
}

- (void)callStatusIterator
{
    NSDate *const date = [_phoneManager getCallStatusChangedDate];

    if (date == nil) {
        return;
    }

    const long seconds = [[[NSDate alloc] init] timeIntervalSinceDate:date];
    NSString *const text =
        seconds < 3600 ?
            [NSString stringWithFormat:@"%02ld:%02ld", seconds/60, seconds % 60]
        :
            [NSString stringWithFormat:@"%02ld:%02ld:%02ld", seconds/3600, (seconds/60) % 60, seconds % 60];

    _statusChangedTime.hidden = NO;
    _statusChangedTime.text   = text;
}

+ (BOOL)isScreenNotBigEnough
{
    return (int)[[UIScreen mainScreen] bounds].size.height <= 480;
}


- (void)onCallStatusChanged:(SMLRCallStatus *const)callStatus
{
    SMLRLogI(@"onCallStatusChanged status=%@", callStatus);

    _status.text = [callStatus guiText];
    [_soundManager onCallStatusChanged:callStatus];

    _hangUpButton.hidden       = NO;
    _controlButtonsView.hidden = [SMLRCallViewController isScreenNotBigEnough];

    if (callStatus.enumValue != SMLRCallStatusIncomingCall) {
        [self startCallStatusTimeIterator];
    }

    if (callStatus.enumValue == SMLRCallStatusEnded) {
        _encryptionView.hidden      = YES;
        _verifiedSasView.hidden     = YES;

        if ([callStatus.endReason length] > 0) {
            _endReason.text       = callStatus.endReason;
            _endReasonView.hidden = NO;
        }

        [self stopCallStatusTimeIterator];
    } else {
        _endReasonView.hidden = YES;
    }

    if (callStatus.wantsDismiss) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)onCallEncrypted:(NSString *const)sas sasVerified:(const BOOL)sasVerified
{
    SMLRLogFunc;

    if (sasVerified) {
        _encryptionView.hidden  = YES;
        _verifiedSasView.hidden = NO;
        _verifiedSas.text       = sas;
    } else {
        _encryptionView.hidden = NO;
        _sas.text              = sas;
    }
}

- (void)onCallNetworkQualityChanged:(const enum SMLRNetworkQuality)quality
{
    SMLRLogFunc;
    if (quality == SMLRNetworkQualityUnknown) {
        _networkQualityView.hidden = YES;
    } else {
        _networkQualityView.hidden = NO;
        _networkQuality.text       = guiTextForSMLRNetworkQuality(quality);
    }
}

- (void)onMicrophoneStatusChanged:(const enum SMLRMicrophoneStatus)status
{
    SMLRLogFunc;

    switch (status) {
        case SMLRMicrophoneStatusNormal:
            [_microMuteButton setImage:[UIImage imageNamed:@"MicrophoneOn"] forState:UIControlStateNormal];
            [_microMuteButton setImage:[UIImage imageNamed:@"MicrophoneOnHighlighted"] forState:UIControlStateHighlighted];
            _microMuteButton.enabled = YES;
            break;
        case SMLRMicrophoneStatusMuted:
            [_microMuteButton setImage:[UIImage imageNamed:@"MicrophoneOff"] forState:UIControlStateNormal];
            [_microMuteButton setImage:[UIImage imageNamed:@"MicrophoneOffHighlighted"] forState:UIControlStateHighlighted];
            _microMuteButton.enabled = YES;
            break;
        case SMLRMicrophoneStatusDisabled:
            _microMuteButton.enabled = NO;
            break;
    }
}

- (void)onAudioOutputTypeChanged:(const enum SMLRAudioOutputType)type
{
    SMLRLogFunc;

    switch (type) {
        case SMLRAudioOutputTypeNormal:
            _speakerBluetoothButton.hidden = YES;
            _speakerButton.hidden = NO;
            [_speakerButton setImage:[UIImage imageNamed:@"SpeakerOff"] forState:UIControlStateNormal];
            [_speakerButton setImage:[UIImage imageNamed:@"SpeakerOffHighlighted"] forState:UIControlStateHighlighted];
            break;
        case SMLRAudioOutputTypeExternalSpeaker:
            _speakerBluetoothButton.hidden = YES;
            _speakerButton.hidden = NO;
            [_speakerButton setImage:[UIImage imageNamed:@"SpeakerOn"] forState:UIControlStateNormal];
            [_speakerButton setImage:[UIImage imageNamed:@"SpeakerOnHighlighted"] forState:UIControlStateHighlighted];
            break;
        case SMLRAudioOutputTypeBlueToothAvailable:
            _speakerBluetoothButton.hidden = NO;
            _speakerButton.hidden = YES;
            break;
    }
}

@end

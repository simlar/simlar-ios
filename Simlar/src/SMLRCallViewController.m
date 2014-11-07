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

#import "SMLRCallSoundManager.h"
#import "SMLRCallStatus.h"
#import "SMLRContact.h"
#import "SMLRLog.h"
#import "SMLRNetworkQuality.h"
#import "SMLRPhoneManager.h"
#import "SMLRPhoneManagerDelegate.h"

@interface SMLRCallViewController () <SMLRPhoneManagerDelegate>

@property (nonatomic, readonly) SMLRCallSoundManager *soundManager;

@property (weak, nonatomic) IBOutlet UILabel *contactName;
@property (weak, nonatomic) IBOutlet UILabel *status;

@property (weak, nonatomic) IBOutlet UIView *networkQualityView;
@property (weak, nonatomic) IBOutlet UILabel *networkQuality;

@property (weak, nonatomic) IBOutlet UIView *encryptionView;
@property (weak, nonatomic) IBOutlet UILabel *sas;

@property (weak, nonatomic) IBOutlet UIView *endReasonView;
@property (weak, nonatomic) IBOutlet UILabel *endReason;

@property (weak, nonatomic) IBOutlet UIButton *hangUpButton;
@property (weak, nonatomic) IBOutlet UIButton *declineButton;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;

@property (weak, nonatomic) IBOutlet UIView *logo;

- (IBAction)sasVerifiedButtonPressed:(id)sender;
- (IBAction)sasDoNotCareButtonPressed:(id)sender;

- (IBAction)hangUpButtonPressed:(id)sender;
- (IBAction)declineButtonPressed:(id)sender;
- (IBAction)acceptButtonPressed:(id)sender;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    SMLRLogFunc;

    [self update];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
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
}

- (void)viewWillDisappear:(BOOL)animated
{
    SMLRLogFunc;
    [UIDevice currentDevice].proximityMonitoringEnabled = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)sasVerifiedButtonPressed:(id)sender
{
    [_encryptionView setHidden:YES];
    [_phoneManager saveSasVerified];
}

- (IBAction)sasDoNotCareButtonPressed:(id)sender
{
    [_encryptionView setHidden:YES];
}

- (IBAction)hangUpButtonPressed:(id)sender
{
    [_phoneManager terminateAllCalls];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)declineButtonPressed:(id)sender
{
    [self hangUpButtonPressed:sender];
}

- (IBAction)acceptButtonPressed:(id)sender
{
    [_phoneManager acceptCall];
}

- (void)animateIncomingCall:(const BOOL)incomingCall
{
    if (!incomingCall) {
        SMLRLogI(@"stopping ringing animation");
        [_logo.layer removeAllAnimations];
        return;
    }

    SMLRLogI(@"starting ringing animation");
    const NSTimeInterval duration = 0.5;
    [UIView animateWithDuration:duration
                     animations:^{
                         _logo.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4);
                     }

                     completion:^(const BOOL finished){
                         [UIView animateWithDuration:2 * duration
                                               delay:0.0
                                             options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse
                                          animations:^{
                                              _logo.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -M_PI_4);
                                          }
                                          completion:^(const BOOL finished){
                                              SMLRLogI(@"ringing animation finished => moving simlar logo back");
                                              _logo.transform = CGAffineTransformRotate(CGAffineTransformIdentity, 0);
                                          }
                          ];
                     }
     ];
}

- (void)onCallStatusChanged:(SMLRCallStatus *const)callStatus
{
    SMLRLogI(@"onCallStatusChanged status=%@", callStatus);

    _status.text = [callStatus guiText];
    [_soundManager onCallStatusChanged:callStatus];

    const BOOL incomingCall = callStatus.enumValue == SMLRCallStatusIncomingCall;
    _hangUpButton.hidden  = incomingCall;
    _acceptButton.hidden  = !incomingCall;
    _declineButton.hidden = !incomingCall;
    [self animateIncomingCall:incomingCall];

    if (callStatus.enumValue == SMLRCallStatusEnded) {
        _encryptionView.hidden = YES;

        if ([callStatus.endReason length] > 0) {
            _endReason.text       = callStatus.endReason;
            _endReasonView.hidden = NO;
        }
    } else {
        _endReasonView.hidden = YES;
    }

    if (callStatus.wantsDismiss) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)onCallEncrypted:(NSString *const)sas
{
    SMLRLogFunc;
    if ([sas length] > 0) {
        [_encryptionView setHidden:NO];
        _sas.text = sas;
    }
}

- (void)onCallNotEncrypted
{
    SMLRLogFunc;
    /// TODO
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

@end

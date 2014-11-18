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
@property (nonatomic) BOOL isIncomingCallAnimationRunning;

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
    _isIncomingCallAnimationRunning = NO;

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
    [self checkIncomingCallAnimation];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appplicationDidBecomeActive)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
}

- (void)appplicationDidBecomeActive
{
    SMLRLogFunc;

    [self checkIncomingCallAnimation];
}

- (void)checkIncomingCallAnimation
{
    if (_phoneManager.getCallStatus.enumValue == SMLRCallStatusIncomingCall) {
        [self startIncomingCallAnimation];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    SMLRLogFunc;
    [UIDevice currentDevice].proximityMonitoringEnabled = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];

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

- (void)stopIncomingCallAnimation
{
    if (!_isIncomingCallAnimationRunning) {
        return;
    }

    SMLRLogI(@"stopping ringing animation");
    [_logo.layer removeAllAnimations];
}

- (BOOL)isVisible
{
    return [UIApplication sharedApplication].applicationState == UIApplicationStateActive && self.isViewLoaded && self.view.window;
}

- (void)startIncomingCallAnimation
{
    if (_isIncomingCallAnimationRunning) {
        return;
    }

    if (![self isVisible]) {
        SMLRLogI(@"delaying incoming call animation since view is not visible");
        return;
    }

    SMLRLogI(@"starting ringing animation");
    self.isIncomingCallAnimationRunning = YES;
    const NSTimeInterval duration = 0.5;
    const NSUInteger numberOfCircles = 4;
    const CGFloat scale  = 3.5;
    const CGFloat radius = 40.0;
    const NSTimeInterval circleDuration = duration * 3.0;
    const NSTimeInterval delayStep      = circleDuration / numberOfCircles * 0.5;

    NSMutableArray *const circles = [NSMutableArray array];
    for (int i = 0; i < numberOfCircles; ++i) {
        const CGFloat diameter = 2 * radius;
        UIView *const circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, diameter, diameter)];
        circle.layer.cornerRadius = radius;
        circle.layer.borderWidth  = 1.0;
        circle.layer.position     = _logo.center;
        circle.alpha              = 0.0;

        [circles addObject:circle];
        [self.view addSubview:circle];
    }

    for (int i = 0; i < numberOfCircles; ++i) {
        UIView *const circle = circles[i];
        [UIView animateWithDuration:circleDuration
                              delay:delayStep * i
                            options:UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear
                         animations:^{
                             circle.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
                         }
                         completion:nil
         ];

        [UIView animateWithDuration:circleDuration / 2.0
                              delay:delayStep * i
                            options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             circle.alpha = 0.75;
                         }
                         completion:nil
         ];
    }


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
                                              SMLRLogI(@"ringing animation finished => moving simlar logo back and removing circles");
                                              _logo.transform = CGAffineTransformRotate(CGAffineTransformIdentity, 0);
                                              self.isIncomingCallAnimationRunning = NO;
                                              for (UIView *const circle in circles) {
                                                  [circle removeFromSuperview];
                                              }
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
    if (incomingCall) {
        [self startIncomingCallAnimation];
    } else {
        [self stopIncomingCallAnimation];
    }

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

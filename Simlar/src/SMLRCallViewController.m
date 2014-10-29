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

@property (weak, nonatomic) IBOutlet UILabel *networkQualityLabel;
@property (weak, nonatomic) IBOutlet UILabel *networkQuality;

@property (weak, nonatomic) IBOutlet UIView *encryptionView;
@property (weak, nonatomic) IBOutlet UILabel *sas;

@property (weak, nonatomic) IBOutlet UIButton *hangUpButton;
@property (weak, nonatomic) IBOutlet UIButton *declineButton;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;

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
    if (self) {
        _soundManager = [[SMLRCallSoundManager alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    SMLRLogI(@"viewDidLoad with callStatus=%@", nameForSMLRCallStatus([self.phoneManager getCallStatus]));
    [self.phoneManager setDelegate:self];
    self.contactName.text = self.contact.name;

    [self onCallStatusChanged:[self.phoneManager getCallStatus]];
    [self onCallNetworkQualityChanged:[self.phoneManager getCallNetworkQuality]];
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
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)sasVerifiedButtonPressed:(id)sender
{
    [self.encryptionView setHidden:YES];
    [self.phoneManager saveSasVerified];
}

- (IBAction)sasDoNotCareButtonPressed:(id)sender
{
    [self.encryptionView setHidden:YES];
}

- (IBAction)hangUpButtonPressed:(id)sender
{
    [self.phoneManager terminateAllCalls];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)declineButtonPressed:(id)sender
{
    [self hangUpButtonPressed:sender];
}

- (IBAction)acceptButtonPressed:(id)sender
{
    [self.phoneManager acceptCall];
}

- (void)onCallStatusChanged:(const enum SMLRCallStatus)callStatus
{
    SMLRLogI(@"onCallStatusChanged status=%@", nameForSMLRCallStatus(callStatus));

    self.status.text = guiTextForSMLRCallStatus(callStatus);
    [self.soundManager onCallStatusChanged:callStatus];

    const BOOL incomingCall = callStatus == SMLRCallStatusIncomingCall;
    self.hangUpButton.hidden  = incomingCall;
    self.acceptButton.hidden  = !incomingCall;
    self.declineButton.hidden = !incomingCall;
}

- (void)onCallEnded
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onCallEncrypted:(NSString *const)sas
{
    SMLRLogFunc;
    if ([sas length] > 0) {
        [self.encryptionView setHidden:NO];
        self.sas.text = sas;
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
        self.networkQualityLabel.hidden = YES;
        self.networkQuality.hidden      = YES;
    } else {
        self.networkQualityLabel.hidden = NO;
        self.networkQuality.hidden      = NO;
        self.networkQuality.text        = guiTextForSMLRNetworkQuality(quality);
    }
}

@end

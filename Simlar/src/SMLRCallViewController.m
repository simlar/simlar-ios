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

#import "SMLRLog.h"
#import "SMLRPhoneManager.h"
#import "SMLRPhoneManagerDelegate.h"

@interface SMLRCallViewController () <SMLRPhoneManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *contactName;
@property (weak, nonatomic) IBOutlet UILabel *status;

@property (weak, nonatomic) IBOutlet UIView *encryptionView;
@property (weak, nonatomic) IBOutlet UILabel *sas;

- (IBAction)sasVerifiedButtonPressed:(id)sender;
- (IBAction)sasDoNotCareButtonPressed:(id)sender;

- (IBAction)hangUpButtonPressed:(id)sender;

@end

@implementation SMLRCallViewController

- (instancetype)initWithCoder:(NSCoder *const)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    SMLRLogI(@"viewDidLoad with callStatus=%@", nameForSMLRCallStatus([self.phoneManager getCallStatus]));
    [self.phoneManager setDelegate:self];
    self.status.text      = guiTextForSMLRCallStatus([self.phoneManager getCallStatus]);
    self.contactName.text = self.guiContactName;
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

- (void)onCallStatusChanged:(const SMLRCallStatus)callStatus
{
    SMLRLogI(@"onCallStatusChanged status=%@", nameForSMLRCallStatus(callStatus));
    self.status.text = guiTextForSMLRCallStatus(callStatus);
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

@end

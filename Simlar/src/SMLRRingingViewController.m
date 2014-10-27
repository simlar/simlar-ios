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

#import "SMLRRingingViewController.h"

#import "SMLRCallViewController.h"
#import "SMLRContact.h"
#import "SMLRLog.h"
#import "SMLRPhoneManager.h"
#import "SMLRPhoneManagerDelegate.h"

@interface SMLRRingingViewController () <SMLRPhoneManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *contactName;

- (IBAction)declineButtonPressed:(id)sender;
- (IBAction)acceptButtonPressed:(id)sender;

@end

@implementation SMLRRingingViewController

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

    [self.phoneManager setDelegate:self];
    NSString *const simlarId = [self.phoneManager getCurrentCallSimlarId];
    SMLRLogI(@"viewDidLoad with simlarId=%@", simlarId);

    self.contactName.text = self.contact.name;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    SMLRLogFunc;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    SMLRLogFunc;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)declineButtonPressed:(id)sender
{
    if (self.phoneManager == nil) {
        SMLRLogI(@"ERROR: declineButtonPressed but no linphone handler");
    } else {
        [self.phoneManager terminateAllCalls];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)acceptButtonPressed:(id)sender
{
    if (self.phoneManager == nil) {
        SMLRLogI(@"ERROR: acceptButtonPressed but no linphone handler");
    } else {
        [self.phoneManager acceptCall];
    }

    SMLRCallViewController *const viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"SMLRCallViewController"];
    viewController.phoneManager = self.phoneManager;
    viewController.contact      = self.contact;

    UIViewController *const rootViewController = self.view.window.rootViewController;
    [self dismissViewControllerAnimated:NO completion:^() {
        [rootViewController presentViewController:viewController animated:NO completion:nil];
    }];
}

- (void)onCallEnded
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

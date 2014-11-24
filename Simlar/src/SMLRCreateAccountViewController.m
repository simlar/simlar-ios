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

#import "SMLRCreateAccountViewController.h"

#import "SMLRAppDelegate.h"
#import "SMLRCreateAccount.h"
#import "SMLRCredentials.h"
#import "SMLRLog.h"
#import "SMLRSettings.h"

@interface SMLRCreateAccountViewController ()

@property (weak, nonatomic) IBOutlet UITextField *confirmationCode;
@property (weak, nonatomic) IBOutlet UITextField *telephoneNumber;

- (IBAction)confirmButtonPressed:(id)sender;
- (IBAction)reenterNumberButtonPressed:(id)sender;

@end

@implementation SMLRCreateAccountViewController

- (instancetype)initWithCoder:(NSCoder *const)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self == nil) {
        SMLRLogE(@"unable to create SMLRCreateAccountViewController");
        return nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _telephoneNumber.text = [SMLRCredentials getTelephoneNumber];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/// hide keyboard if background is touched
- (void)touchesBegan:(NSSet *const)touches withEvent:(UIEvent *const)event
{
    [self.view endEditing:YES];
}

+ (void)showErrorAlertMessage:(NSString *const)message
{
    [[[UIAlertView alloc] initWithTitle:@"Confirm Account Error" message:message delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] show];
}

- (IBAction)confirmButtonPressed:(id)sender
{
    if ([_confirmationCode.text length] == 0) {
        [SMLRCreateAccountViewController showErrorAlertMessage:@"Please enter the registration code sent to you by sms"];
        return;
    }

    SMLRLogI(@"Code=%@", _confirmationCode.text);
    [SMLRCreateAccount confirmWithSimlarId:[SMLRCredentials getSimlarId] registrationCode:_confirmationCode.text
                         completionHandler:^(NSString *simlarId, NSString *registrationCode, NSError *error)
    {
        if (error != nil) {
            SMLRLogI(@"failed account creation confirmation: error=%@ description=%@ local=%@", error, error.description, error.localizedDescription);
            [SMLRCreateAccountViewController showErrorAlertMessage:error.localizedDescription];
            return;
        }

        SMLRLogI(@"successful account creation confirm: simlarId=%@ registrationCode=%@", simlarId, registrationCode);
        [SMLRSettings saveCreateAccountStatus:SMLRCreateAccountStatusSuccess];

        [(SMLRAppDelegate *)[[UIApplication sharedApplication] delegate] registerPushNotifications];

        UIViewController *const viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"SMLRAddressBookViewController"];
        [self presentViewController:viewController animated:YES completion:nil];
    }];
}

- (IBAction)reenterNumberButtonPressed:(id)sender
{
    UIViewController *const viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"SMLRVerifyNumberViewController"];
    [self presentViewController:viewController animated:YES completion:nil];
}

@end

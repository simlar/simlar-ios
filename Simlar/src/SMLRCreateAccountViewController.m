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
#import "SMLRHttpsPostError.h"
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

+ (void)showErrorAlertWithTitle:(NSString *const)title message:(NSString *const)message
{
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] show];
}

- (IBAction)confirmButtonPressed:(id)sender
{
    if ([_confirmationCode.text length] == 0) {
        [SMLRCreateAccountViewController showErrorAlertWithTitle:@"No Registration Code" message:@"Please enter the registration code sent to you by SMS"];
        return;
    }

    SMLRLogI(@"Code=%@", _confirmationCode.text);
    [SMLRCreateAccount confirmWithSimlarId:[SMLRCredentials getSimlarId] registrationCode:_confirmationCode.text
                         completionHandler:^(NSString *simlarId, NSString *registrationCode, NSError *error)
    {
        if (error != nil) {
            SMLRLogI(@"failed account creation confirmation: error=%@", error);

            if (isSMLRHttpsPostOfflineError(error)) {
                [SMLRCreateAccountViewController showErrorAlertWithTitle:@"You Are Offline" message:@"Check your internet connection and try again"];
                return;
            }

            if ([error.domain isEqualToString:SMLRCreateAccountErrorDomain]) {
                switch (error.code) {
                    case 25:
                        [SMLRCreateAccountViewController showErrorAlertWithTitle:@"Confirmation Retries Exceeded"
                                                                         message:@"Account confirmation is not possible anymore. Start again."];
                        return;
                    case 26:
                    case 28:
                        [SMLRCreateAccountViewController showErrorAlertWithTitle:@"Invalid Registration Code"
                                                                         message:@"Try entering the code again."];
                        return;
                    default:
                        [SMLRCreateAccountViewController showErrorAlertWithTitle:@"Server Error"
                                                                         message:[NSString stringWithFormat:@"Internal Error with number: %li", (long)error.code]];
                        return;
                }
            }

            [SMLRCreateAccountViewController showErrorAlertWithTitle:@"Unknown Error" message:error.localizedDescription];
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

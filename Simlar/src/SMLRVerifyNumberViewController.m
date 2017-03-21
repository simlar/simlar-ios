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

#import "SMLRVerifyNumberViewController.h"

#import "SMLRAlert.h"
#import "SMLRCreateAccount.h"
#import "SMLRCredentials.h"
#import "SMLRHttpsPostError.h"
#import "SMLRLog.h"
#import "SMLRPhoneNumber.h"
#import "SMLRSettings.h"

@interface SMLRVerifyNumberViewController ()

@property (weak, nonatomic) IBOutlet UITextField *countryNumber;
@property (weak, nonatomic) IBOutlet UITextField *telephoneNumber;

- (IBAction)continueButtonPressed:(id)sender;

@end

@implementation SMLRVerifyNumberViewController

- (instancetype)initWithCoder:(NSCoder *const)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self == nil) {
        SMLRLogE(@"unable to create SMLRVerifyNumberViewController");
        return nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _countryNumber.text = [SMLRPhoneNumber getCountryNumberBasedOnCurrentLocale];

    [SMLRSettings saveCreateAccountStatus:SMLRCreateAccountStatusAgreed];
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

- (IBAction)continueButtonPressed:(id)sender
{
    if ([_countryNumber.text length] == 0) {
        [SMLRAlert showWithViewController:self title:@"No Country Code" message:@"Please enter your country code"];
        return;
    }

    if ([_telephoneNumber.text length] == 0) {
        [SMLRAlert showWithViewController:self title:@"No Telephone Number" message:@"Please enter your telephone number"];
        return;
    }

    /// Verify and store region
    NSString *const region = [SMLRPhoneNumber getRegionWithNumber:_countryNumber.text];
    if ([region length] == 0) {
        SMLRLogI(@"Could not parse country code: number=%@", _countryNumber.text);
        [SMLRAlert showWithViewController:self title:@"Invalid Country Code" message:@"Check the country code you have entered and try again"];
        return;
    }
    SMLRLogI(@"default region: %@", region);
    [SMLRSettings saveDefaultRegion:region];

    /// Verify telephone number
    NSString *const number = [NSString stringWithFormat:@"+%@%@", _countryNumber.text, _telephoneNumber.text];
    SMLRPhoneNumber *const phoneNumber = [[SMLRPhoneNumber alloc] initWithNumber:number];
    if (![phoneNumber isValid]) {
        SMLRLogI(@"invalid telephone number: %@", number);
        [SMLRAlert showWithViewController:self
                                    title:@"Invalid Telephone Number"
                                  message:[NSString stringWithFormat:@"Check the number you have entered:\n%@\nCorrect it and try again.", number]];

        return;
    }


    [SMLRCreateAccount requestWithTelephoneNumber:[phoneNumber getRegistrationNumber] completionHandler:^(NSString *const simlarId, NSString *const password, NSError *const error)
     {
         if (error != nil) {
             SMLRLogI(@"failed account creation request: error=%@", error);

             if (isSMLRHttpsPostOfflineError(error)) {
                 [SMLRAlert showWithViewController:self title:@"You Are Offline" message:@"Check your internet connection and try again"];
                 return;
             }

             if ([error.domain isEqualToString:SMLRCreateAccountErrorDomain]) {
                 switch (error.code) {
                     case 22:
                         [SMLRAlert showWithViewController:self
                                                     title:@"Invalid Telephone Number"
                                                   message:@"Correct the telephone number you have entered and try again."];
                         return;
                     case 23:
                         [SMLRAlert showWithViewController:self
                                                     title:@"Temporarily Not Available"
                                                   message:@"Account creation is not possible at the moment. Try again later."];
                         return;
                     case 24:
                         [SMLRAlert showWithViewController:self
                                                     title:@"Sending SMS failed"
                                                   message:@"Simlar is not able to send an SMS to the number you have provided. Check your number or try again later."];
                         return;
                     default:
                         [SMLRAlert showWithViewController:self
                                                     title:@"Server Error"
                                                   message:[NSString stringWithFormat:@"Internal Error with number: %li", (long)error.code]];
                         return;
                 }
             }

             [SMLRAlert showWithViewController:self title:@"Unknown Error" message:error.localizedDescription];
             return;
         }

         SMLRLogI(@"successful account creation request with new simlarId=%@ => saving credentials and opening create account view controller", simlarId);
         if (![SMLRCredentials saveWithTelephoneNumber:[phoneNumber getGuiNumber] simlarId:simlarId password:password]) {
             SMLRLogI(@"Failed to save credentials");
             [SMLRAlert showWithViewController:self title:@"Unknown Error" message:@"Failed to save credentials"];
             return;
         }
         [SMLRSettings saveCreateAccountStatus:SMLRCreateAccountStatusWaitingForSms];

         UIViewController *viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"SMLRCreateAccountViewController"];
         [self presentViewController:viewController animated:YES completion:nil];
     }];
}

@end

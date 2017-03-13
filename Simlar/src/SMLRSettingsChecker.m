/**
 * Copyright (C) 2017 The Simlar Authors.
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

#import "SMLRSettingsChecker.h"

#import "SMLRLog.h"
#import "SMLRCredentials.h"
#import "SMLRReportBug.h"
#import "SMLRSettings.h"

@implementation SMLRSettingsChecker

+ (void)checkStatus:(UIViewController *const)parentViewController completionHandler:(void (^)())handler
{
    [SMLRReportBug checkAndReportBugWithViewController:parentViewController completionHandler:^{
        [SMLRSettingsChecker checkCreateAccountStatus:parentViewController completionHandler:handler];
    }];
}

+ (void)checkCreateAccountStatus:(UIViewController *const)parentViewController completionHandler:(void (^)())handler
{
    SMLRLogFunc;
    NSString *const viewControllerName = [SMLRSettingsChecker getViewControllerNameBasedOnCreateAccountStatus];
    if (viewControllerName != nil) {
        UIViewController *viewController = [[parentViewController storyboard] instantiateViewControllerWithIdentifier:viewControllerName];
        [parentViewController presentViewController:viewController animated:NO completion:nil];
    } else {
        if (handler != nil) {
            handler();
        }
    }
}

+ (NSString *)getViewControllerNameBasedOnCreateAccountStatus
{
    if ([SMLRSettings getReregisterNextStart]) {
        SMLRLogI(@"user triggered reregistration => deleting credentials and settings => starting AgreeViewController");
        [SMLRSettings reset];
        [SMLRCredentials delete];
        return @"SMLRAgreeViewController";
    }

    switch ([SMLRSettings getCreateAccountStatus]) {
        case SMLRCreateAccountStatusSuccess:
            if (![SMLRCredentials isInitialized]) {
                SMLRLogE(@"CreateAccountStatusSuccess but simlarId or password not set => starting AgreeViewController");
                return @"SMLRAgreeViewController";
            }
            SMLRLogI(@"CreateAccountStatusSuccess");
            return nil;
        case SMLRCreateAccountStatusWaitingForSms:
            SMLRLogI(@"CreateAccountStatusWaitingForSms => starting CreateAccountViewController");
            return @"SMLRCreateAccountViewController";
        case SMLRCreateAccountStatusAgreed:
            SMLRLogI(@"CreateAccountStatusAgreed => starting VerifyNumberViewController");
            return @"SMLRVerifyNumberViewController";
        case SMLRCreateAccountStatusNone:
        default:
            SMLRLogI(@"CreateAccountStatusNone => starting AgreeViewController");
            return @"SMLRAgreeViewController";
    }
}

@end

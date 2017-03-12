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

#import "SMLRReportBug.h"

#import "SMLRAlert.h"
#import "SMLRCredentials.h"
#import "SMLRHttpsPostError.h"
#import "SMLRLog.h"
#import "SMLRServerSettings.h"
#import "SMLRSettings.h"
#import "SMLRUploadLogFile.h"

#import <MessageUI/MessageUI.h>

@interface SMLRReportBugPrivate : NSObject <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) UIViewController *parentViewController;
@property (nonatomic, copy) void (^completionHandler)();
@property (nonatomic) NSObject *releasePreventer;

@end


@implementation SMLRReportBugPrivate

static NSString *const kEmailAddress = @"support@simlar.org";
static NSString *const kEmailText    =
    @"Please put in your bug description here. It may be in German or English\n"
    @"\n\n\n"
    @"Please do not delete the following link as it helps developers to identify your logfile\n"
    @"\n"
    @"sftp://root@" SIMLAR_DOMAIN @"/var/www/simlar/logfiles/%@";

- (instancetype)initWithViewController:(UIViewController *const)viewController completionHandler:(void (^)())handler
{
    self = [super init];
    if (self == nil) {
        SMLRLogE(@"unable to create SMLRReportBug")
        return nil;
    }

    _parentViewController = viewController;
    _completionHandler    = handler;
    _releasePreventer     = nil;

    return self;
}

- (void)dealloc
{
    SMLRLogFunc;
}

- (void)reportBug
{
    SMLRLogFunc;

    if (![MFMailComposeViewController canSendMail]) {
        SMLRLogI(@"iphone is not configured to send mail");

        [SMLRAlert showWithViewController:_parentViewController
                                    title:@"No EMail Configured"
                                  message:@"You do not have an EMail app configured. This is mandatory in order to report a bug."
                              buttonTitle:@"Abort"
                            buttonHandler:^{
                                _completionHandler();
                            }];

        return;
    }

    if (![SMLRSettings getLogEnabled]) {
        [SMLRAlert showWithViewController:_parentViewController
                                    title:@"Logging Disabled"
                                  message:@"Enable logging in the settings, reproduce the bug and start bug reporting again"
                              abortButtonTitle:@"Abort"
                       abortButtonHandler:^{
                           SMLRLogI(@"reporting bug aborted by user");
                           _completionHandler();
                       }
                      continueButtonTitle:@"Go to Settings"
                    continueButtonHandler:^{
                           [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                       }];

        return;
    }

    [SMLRAlert showWithViewController:_parentViewController
                                title:@"Report Bug"
                              message:@"This will upload a log file. Afterwards you will be asked to write an email describing the bug.\n\nDo you want to continue?"
                     abortButtonTitle:@"Abort"
                   abortButtonHandler:^{
                       SMLRLogI(@"reporting bug aborted by user");
                       _completionHandler();
                   }
                  continueButtonTitle:@"Continue"
                continueButtonHandler:^{
                    [self uploadLogFile];
                }];
}

- (void)uploadLogFile
{
    SMLRLogFunc;

    [SMLRUploadLogFile uploadWithCompletionHandler:^(NSString *const logFileName, NSError *const error) {
        if (error != nil) {
            SMLRLogE(@"failed to upload logfile: %@", error);

            if (isSMLRHttpsPostOfflineError(error)) {
                [self showErrorAlertWithTitle:@"You Are Offline"
                                      message:@"Check your internet connection."];
            } else {
                [self showErrorAlertWithTitle:@"Unknown Error"
                                      message:error.localizedDescription];
            }
            return;
        }

        [self writeEmailWithLogFileName:logFileName];
    }];
}

- (void)showErrorAlertWithTitle:(NSString *const)title message:(NSString *const)message
{
    [SMLRAlert showWithViewController:_parentViewController
                                title:title
                              message:message
                     abortButtonTitle:@"Cancel"
                   abortButtonHandler:^{
                       _completionHandler();
                   }
                  continueButtonTitle:@"Try again"
                continueButtonHandler:^{
                    [self uploadLogFile];
                }];
}

- (void)writeEmailWithLogFileName:(NSString *const)logFileName
{
    SMLRLogFunc;

    if (![MFMailComposeViewController canSendMail]) {
        SMLRLogI(@"iphone is not configured to send mail");
        _completionHandler();
        return;
    }

    MFMailComposeViewController *const picker = [[MFMailComposeViewController alloc] init];
    [picker setMailComposeDelegate:self];
    [picker setSubject:@"Simlar iPhone bug report"];
    [picker setToRecipients:@[kEmailAddress]];
    [picker setMessageBody:[NSString stringWithFormat:@"%@%@", kEmailText, logFileName] isHTML:NO];
    self.releasePreventer = self;

    [_parentViewController presentViewController:picker animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(const MFMailComposeResult)result error:(NSError *const)error
{
    SMLRLogFunc;
    [_parentViewController dismissViewControllerAnimated:YES completion:^{
        _completionHandler();
        self.releasePreventer = nil;
    }];
}

@end

@implementation SMLRReportBug

+ (void)checkAndReportBugWithViewController:(UIViewController *const)viewController completionHandler:(void (^)())handler
{
    if (![SMLRSettings getReportBugNextStart]) {
        handler();
        return;
    }

    [SMLRSettings resetReportBugNextStart];
    SMLRReportBugPrivate *const reportBug = [[SMLRReportBugPrivate alloc] initWithViewController:viewController completionHandler:handler];
    [reportBug reportBug];
}

@end

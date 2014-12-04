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

#import "SMLRCredentials.h"
#import "SMLRHttpsPostError.h"
#import "SMLRLog.h"
#import "SMLRSettings.h"
#import "SMLRUploadLogFile.h"

#import <MessageUI/MessageUI.h>

@interface SMLRReportBugPrivate : NSObject <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) UIViewController *parentViewController;

@end


@implementation SMLRReportBugPrivate

static NSString *const kEmailAddress = @"support@simlar.org";
static NSString *const kEmailText    =
    @"Please put in your bug description here. It may be in German or English\n"
    @"\n\n\n"
    @"Please do not delete the following link as it helps developers to identify your logfile\n"
    @"\n"
    @"sftp://root@sip.simlar.org/var/www/simlar/logfiles/";

- (instancetype)initWithViewController:(UIViewController *const)viewController
{
    self = [super init];
    if (self == nil) {
        SMLRLogE(@"unable to create SMLRReportBug")
        return nil;
    }

    _parentViewController = viewController;

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

        [[[UIAlertView alloc] initWithTitle:@"No EMail configured"
                                    message:@"You do not have an EMail app configured. This is mandatory in order to report a bug"
                                   delegate:nil
                          cancelButtonTitle:@"Abort"
                          otherButtonTitles:nil
          ] show];

        return;
    }

    if (![SMLRSettings getLogEnabled]) {
        UIAlertController *const alert = [UIAlertController alertControllerWithTitle:@"Logging Disabled"
                                                                             message:@"Enable logging in the settings, reproduce the bug and start bug reporting again"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Abort"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action) {
                                                    SMLRLogI(@"reporting bug aborted by user");
                                                }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"Goto Settings"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {
                                                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                                }]];
        [_parentViewController presentViewController:alert animated:YES completion:nil];

        return;
    }

    UIAlertController *const alert = [UIAlertController alertControllerWithTitle:@"Report Bug"
                                                                         message:@"This will upload a log file. Afterwards you will be asked to write an email describing the bug.\n\nDo you want to continue?"
                                                                  preferredStyle:UIAlertControllerStyleAlert];

    [alert addAction:[UIAlertAction actionWithTitle:@"Abort"
                                              style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction * action) {
                                                SMLRLogI(@"reporting bug aborted by user");
                                            }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"Continue"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                [self uploadLogFile];
                                            }]];

    [_parentViewController presentViewController:alert animated:YES completion:nil];
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
    UIAlertController *const alert = [UIAlertController alertControllerWithTitle:title
                                                                         message:message
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action) {
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Try Again"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *action) {
                                                [self uploadLogFile];
                                            }]];
    [_parentViewController presentViewController:alert animated:YES completion:nil];
}

- (void)writeEmailWithLogFileName:(NSString *const)logFileName
{
    SMLRLogFunc;

    if (![MFMailComposeViewController canSendMail]) {
        SMLRLogI(@"iphone is not configured to send mail");
        return;
    }

    MFMailComposeViewController *const picker = [[MFMailComposeViewController alloc] init];
    [picker setMailComposeDelegate:self];
    [picker setSubject:@"Simlar iPhone bug report"];
    [picker setToRecipients:@[kEmailAddress]];
    [picker setMessageBody:[NSString stringWithFormat:@"%@%@", kEmailText, logFileName] isHTML:NO];

    [_parentViewController presentViewController:picker animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(const MFMailComposeResult)result error:(NSError *const)error
{
    SMLRLogFunc;
    [_parentViewController dismissViewControllerAnimated:YES completion:nil];
}

@end

@implementation SMLRReportBug

+ (void)checkAndReportBugWithViewController:(UIViewController *const)viewController
{
    if (![SMLRSettings getReportBugNextStart]) {
        return;
    }

    [SMLRSettings resetReportBugNextStart];
    SMLRReportBugPrivate *const reportBug = [[SMLRReportBugPrivate alloc] initWithViewController:viewController];
    [reportBug reportBug];
}

@end

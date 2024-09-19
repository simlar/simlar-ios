/**
 * Copyright (C) The Simlar Authors.
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

#import "SMLRUnmaintainedWarning.h"

#import "SMLRBrowser.h"
#import "SMLRLog.h"

@implementation SMLRUnmaintainedWarning

static NSString *const kTitle   = @"Simlar now unmaintained";
static NSString *const kMessage = @"\
Simlar has always been a personal passion project for me, something I have truly enjoyed working on since its inception in 2013. However, a few months ago I welcomed my son into the world and have decided to dedicate my free time to him.\n\
\n\
While I will keep the servers running for now, I want to give a heads-up: If any major issues arise, I may need to shut them down without notice. In the meantime, I hope to find some time here and there to update the apps dependencies.\n\
\n\
For the moment Simlar is still available (as always, at your own risk) but it is time to start exploring alternatives. Signal, Matrix (Element), and Linphone are all doing an excellent job.\n\
\n\
I would like to extend a heartfelt thanks to all users and especially the Simlar team - this project would not have been possible without you.\n\
\n\
Sincerely,\n\
 Ben Sartor";

+ (void)showAlert:(UIViewController *const)viewController
{
    UIAlertController *const alert = [UIAlertController alertControllerWithTitle:kTitle
                                                                         message:kMessage
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];

    [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil]];

    [alert addAction:[UIAlertAction actionWithTitle:@"Signal"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *const action) {
        [SMLRBrowser openUrl:@"https://signal.org"];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:@"Matrix (Element)"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *const action) {
        [SMLRBrowser openUrl:@"https://element.io"];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Linphone", nil)
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *const action) {
        [SMLRBrowser openUrl:@"https://linphone.org"];
    }]];

    NSMutableParagraphStyle *const paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentJustified;

    NSMutableAttributedString *const attributedMessage = [[NSMutableAttributedString alloc] initWithString:kMessage
                                                                                                attributes:@{
        NSParagraphStyleAttributeName: paragraphStyle,
        NSFontAttributeName:           [UIFont systemFontOfSize:13.0]
    }];

    [alert setValue:attributedMessage forKey:@"attributedMessage"];
    [viewController presentViewController:alert animated:YES completion:nil];
}

@end

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

@interface SMLRUnmaintainedWarningBanner : NSObject
@property (weak, nonatomic) UIViewController *viewController;
@end

@implementation SMLRUnmaintainedWarningBanner

- (instancetype)initWithViewController:(UIViewController *const)viewController
{
    self = [super init];

    if (self == nil) {
        SMLRLogE(@"unable to create SMLRUnmaintainedWarningHelper");
        return nil;
    }

    _viewController = viewController;

    return self;
}

- (void) showUnmaintainedWarning:(UITapGestureRecognizer *const)tapGestureRecognizer
{
    SMLRLogI(@"showUnmaintainedWarning");
    [SMLRUnmaintainedWarning showAlert:self.viewController];
}

@end


@interface SMLRUnmaintainedWarning ()

@end

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

    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Dismiss", nil) style:UIAlertActionStyleCancel handler:nil]];

    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Signal", nil)
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *const action) {
        [SMLRBrowser openUrl:@"https://signal.org"];
    }]];

    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Matrix (Element)", nil)
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

+ (SMLRUnmaintainedWarningBanner *)addBanner:(UIViewController *const)viewController
{
    const CGFloat squareRootOfHalf = sqrtf(0.5f);
    const CGFloat width = 240;
    const CGFloat height = 30;
    const CGFloat y = squareRootOfHalf * 0.5f * width - (squareRootOfHalf * height) - 4.0f;
    const CGFloat x = [[viewController view] frame].size.width - (squareRootOfHalf * width + squareRootOfHalf * height) + 4.0f;

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    label.numberOfLines = 1;
    label.text = NSLocalizedString(@"unmaintained", nil);
    label.backgroundColor = [UIColor yellowColor];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.transform = CGAffineTransformMakeRotation( M_PI_4 );
    label.userInteractionEnabled = YES;

    SMLRUnmaintainedWarningBanner *const banner = [[SMLRUnmaintainedWarningBanner alloc] initWithViewController:viewController];
    [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:banner
                                                                        action:@selector(showUnmaintainedWarning:)]];

    [[viewController view] addSubview:label];

    return banner;
}

@end

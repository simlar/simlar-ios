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

#import "SMLRNoAddressBookPermissionViewController.h"

#import "SMLRLog.h"


@interface SMLRNoAddressBookPermissionViewController ()

- (IBAction)buttonGoToSettingsPressed:(id)sender;
- (IBAction)buttonCallContactPressed:(id)sender;

@end

@implementation SMLRNoAddressBookPermissionViewController

- (instancetype)initWithCoder:(NSCoder *const)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self == nil) {
        SMLRLogE(@"unable to create SMLRNoAddressBookPermissionViewController");
        return nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonGoToSettingsPressed:(id)sender
{
    SMLRLogFunc;
    /// Note: iOS sends a SIGKILL to the app after the user changed permission preferences
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

- (IBAction)buttonCallContactPressed:(id)sender
{
    SMLRLogFunc;
}
@end

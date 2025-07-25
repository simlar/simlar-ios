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

#import "SMLRAgreeViewController.h"

#import "SMLRBrowser.h"
#import "SMLRLog.h"
#import "SMLRUnmaintainedWarning.h"

@interface SMLRAgreeViewController ()

- (IBAction)buttonPrivacyStatementPressed:(id)sender;
- (IBAction)buttonTermsOfUsePressed:(id)sender;

@end

@implementation SMLRAgreeViewController

- (instancetype)initWithCoder:(NSCoder *const)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self == nil) {
        SMLRLogE(@"unable to create SMLRAgreeViewController");
        return nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(const BOOL)animated
{
    [super viewDidAppear:animated];

    [SMLRUnmaintainedWarning showAlert:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonPrivacyStatementPressed:(id)sender
{
    [SMLRBrowser openUrl:@"https://www.simlar.org/datenschutzerklaerung/"];
}

- (IBAction)buttonTermsOfUsePressed:(id)sender
{
    [SMLRBrowser openUrl:@"https://www.simlar.org/nutzungsbedingungen/"];
}

@end

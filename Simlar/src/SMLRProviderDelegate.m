/**
 * Copyright (C) 2019 The Simlar Authors.
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

#import "SMLRProviderDelegate.h"

#import "SMLRLog.h"
#import "SMLRRingtone.h"

@interface SMLRProviderDelegate () <CXProviderDelegate>

@property (nonatomic) CXProvider *provider;

@end

@implementation SMLRProviderDelegate

- (instancetype)init
{
    self = [super init];
    if (self == nil) {
        SMLRLogE(@"unable to create SMLRProviderDelegate");
        return nil;
    }

    [self providerConfiguration];

    return self;
}

- (void)providerConfiguration
{
    CXProviderConfiguration *const config = [[CXProviderConfiguration alloc]
        initWithLocalizedName:[NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleDisplayName"]];
    config.ringtoneSound = SIMLAR_RINGTONE;
    config.supportsVideo = NO;
    config.iconTemplateImageData = UIImagePNGRepresentation([UIImage imageNamed:@"CallkitLogo"]);
    config.maximumCallGroups = 1;
    config.maximumCallsPerCallGroup = 1;

    self.provider = [[CXProvider alloc] initWithConfiguration:config];
    [_provider setDelegate:self queue:dispatch_get_main_queue()];
}

- (void)reportIncomingCallWithHandle:(NSString *const)handle
{
    SMLRLogFunc;

    CXCallUpdate *const update = [[CXCallUpdate alloc] init];
    update.remoteHandle = [[CXHandle alloc] initWithType:CXHandleTypeGeneric value:handle];

    NSUUID *const uuid = [NSUUID UUID];

    SMLRLogI(@"reportNewIncomingCall with uuid=%@ and handle=%@", uuid, handle);
    [_provider reportNewIncomingCallWithUUID:uuid
                                      update:update
                                  completion:^(NSError *const error) {
        SMLRLogI(@"update: %@", update);

        if (error) {
            SMLRLogE(@"error: %@", error);
        }
    }];
}

#pragma mark - CXProviderDelegate Protocol
- (void)providerDidReset:(nonnull CXProvider *const)provider
{
    SMLRLogFunc;
}

@end

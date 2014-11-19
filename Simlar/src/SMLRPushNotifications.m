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

#import "SMLRPushNotifications.h"

#import "SMLRLog.h"

//#define NO_PUSHKIT_SUPPORT

#ifndef NO_PUSHKIT_SUPPORT
#import <PushKit/PushKit.h>
#endif

@implementation SMLRPushNotifications

+ (BOOL)isVoipSupported
{
#ifndef NO_PUSHKIT_SUPPORT
    return [PKPushRegistry class] != nil;
#else
    return NO;
#endif
}

+ (void)registerAtServerWithDelegate:(id<PKPushRegistryDelegate>)delegate
{
#ifndef NO_PUSHKIT_SUPPORT
    SMLRLogI(@"using voip push notifications (iOS 8 and later)");
    PKPushRegistry *const voipRegistry = [[PKPushRegistry alloc] initWithQueue:dispatch_get_main_queue()];
    voipRegistry.delegate = delegate;
    voipRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
#else
    SMLRLogI(@"using no-voip push notifications (before iOS 8)");
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
#endif
}

+ (void)parseLaunchOptions:(NSDictionary *const)launchOptions
{
    NSDictionary *const pushNotifications = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    if (pushNotifications) {
        SMLRLogI(@"Push notification triggered launch: %@", pushNotifications);
    }
}

@end

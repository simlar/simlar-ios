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

#import "SMLRAppDelegate.h"

#import "SMLRAddressBookViewController.h"
#import "SMLRCredentials.h"
#import "SMLRSettings.h"
#import "SMLRStorePushId.h"
#import "SMLRLog.h"
#import "SMLRPushNotifications.h"

@interface SMLRAppDelegate ()

@end

@implementation SMLRAppDelegate

- (instancetype)init
{
    self = [super init];
    if (self) {
        [SMLRLog enableLogging:[SMLRSettings getLogEnabled]];

        NSString *const version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
        SMLRLogI(@"simlar started with version=%@", version);
    }
    return self;
}

- (BOOL)application:(UIApplication *const)application didFinishLaunchingWithOptions:(NSDictionary *const)launchOptions
{
    SMLRLogI(@"didFinishLaunchingWithOptions");

    /// push notifications
    if ([SMLRCredentials isInitialized]) {
        [SMLRPushNotifications registerAtServer];
        [SMLRPushNotifications parseLaunchOptions:launchOptions];
    }

    /// local notifications
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings
                                                       settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound
                                                             categories:nil]];
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *const)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

    SMLRLogI(@"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *const)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    SMLRLogI(@"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *const)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

    SMLRLogI(@"applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *const)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

    SMLRLogI(@"applicationDidBecomeActive");
    [self checkForIncomingCalls];

    // Hack to silent ringtone after app was opened
    [UIApplication.sharedApplication setApplicationIconBadgeNumber:1];
    [UIApplication.sharedApplication setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *const)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    SMLRLogI(@"applicationWillTerminate");
}

- (void)application:(UIApplication *const)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *const)deviceToken
{
    const uint32_t *const tokenArray = [deviceToken bytes];
    NSString *const pushId = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                                                        ntohl(tokenArray[0]), ntohl(tokenArray[1]), ntohl(tokenArray[2]), ntohl(tokenArray[3]),
                                                        ntohl(tokenArray[4]), ntohl(tokenArray[5]), ntohl(tokenArray[6]), ntohl(tokenArray[7])];

    SMLRLogI(@"Push notification deviceToken=%@", deviceToken);
    SMLRLogI(@"Push notification deviceToken=%@", pushId);

    [SMLRStorePushId storeWithPushId:pushId completionHandler:^(NSError *const error) {
        if (error != nil) {
            SMLRLogE(@"An error occured while trying to store pushId: %@", error);
            return;
        }

        SMLRLogI(@"Successfully stored pushId on server");
    }];
}

- (void)application:(UIApplication *const)application didFailToRegisterForRemoteNotificationsWithError:(NSError *const)error
{
    SMLRLogE(@"Failed to register to push notification, error: %@", error);
}

- (void)application:(UIApplication *const)application didReceiveRemoteNotification:(NSDictionary *const)userInfo
{
    SMLRLogW(@"Received push notification without completion handler");
    [self handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *const)application didReceiveRemoteNotification:(NSDictionary *const)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))handler
{
    [self handleRemoteNotification:userInfo];
    handler(UIBackgroundFetchResultNoData);
}

- (void)handleRemoteNotification:(NSDictionary *const)userInfo
{
    SMLRLogI(@"Received push notification: userInfo=%@", userInfo);
    [self checkForIncomingCalls];
}

- (void)checkForIncomingCalls
{
    if (![SMLRCredentials isInitialized]) {
        return;
    }

    SMLRAddressBookViewController *const rootViewController = (SMLRAddressBookViewController *)self.window.rootViewController;
    if (rootViewController == nil) {
        SMLRLogE(@"ERROR: no root view controller => aborting to handle push notification ");
        return;
    }

    [rootViewController checkForIncomingCalls];
}

@end

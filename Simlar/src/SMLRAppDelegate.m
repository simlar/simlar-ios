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
#import "SMLRAesUtil.h"
#import "SMLRAlert.h"
#import "SMLRContact.h"
#import "SMLRCredentials.h"
#import "SMLRLog.h"
#import "SMLRMissedCallUserNotification.h"
#import "SMLRProviderDelegate.h"
#import "SMLRPushNotifications.h"
#import "SMLRSettings.h"
#import "SMLRStorePushId.h"

#import <AVFoundation/AVFoundation.h>
#import <Intents/Intents.h>
#import <PushKit/PushKit.h>
#import <UserNotifications/UserNotifications.h>

@interface SMLRAppDelegate () <PKPushRegistryDelegate, UNUserNotificationCenterDelegate>

@property (nonatomic) UIBackgroundTaskIdentifier backgroundTaskIdentifier;
@property (nonatomic) SMLRProviderDelegate *providerDelegate;

@end

@implementation SMLRAppDelegate

- (instancetype)init
{
    self = [super init];
    if (self == nil) {
        SMLRLogE(@"unable to create SMLRAppDelegate");
        return nil;
    }

    [SMLRLog enableLogging:[SMLRSettings getLogEnabled]];

    NSString *const version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    SMLRLogI(@"simlar started with version=%@", version);

    return self;
}

- (BOOL)application:(UIApplication *const)application didFinishLaunchingWithOptions:(NSDictionary *const)launchOptions
{
    SMLRLogFunc;

    /// push notifications
    if ([SMLRCredentials isInitialized] && [SMLRSettings getCreateAccountStatus] == SMLRCreateAccountStatusSuccess) {
        self.backgroundTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            SMLRLogE(@"background task expired");
        }];

        [self registerPushNotifications];

        [SMLRPushNotifications parseLaunchOptions:launchOptions];
    }

    /// UserNotifications
    UNUserNotificationCenter *const userNotificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    const UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionBadge + UNAuthorizationOptionSound;
    [userNotificationCenter requestAuthorizationWithOptions:options completionHandler:^(const BOOL granted, NSError *const _Nullable error) {
        if (error != nil) {
            SMLRLogE(@"Error while requesting authorization for UserNotification: %@", error);
        } else if (!granted) {
            SMLRLogE(@"Requesting UserNotification authorization not granted");
        } else {
            SMLRLogI(@"UserNotification authorization granted");
            [userNotificationCenter setNotificationCategories:[NSSet setWithObjects:[SMLRMissedCallUserNotification createCategory], nil]];
            [userNotificationCenter setDelegate:self];
        }
    }];

    return YES;
}

- (void)registerPushNotifications
{
    self.providerDelegate = [[SMLRProviderDelegate alloc] initWithPhoneManager:[[self getRootViewController] getPhoneManager]];

    [SMLRPushNotifications registerAtServerWithDelegate:self];
}

- (void)applicationWillResignActive:(UIApplication *const)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

    SMLRLogFunc;
}

- (void)applicationDidEnterBackground:(UIApplication *const)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    SMLRLogFunc;
}

- (void)applicationWillEnterForeground:(UIApplication *const)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

    SMLRLogFunc;
}

- (void)applicationDidBecomeActive:(UIApplication *const)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

    SMLRLogFunc;

    // Hack to silent ringtone after app was opened
    [UIApplication.sharedApplication setApplicationIconBadgeNumber:1];
    [UIApplication.sharedApplication setApplicationIconBadgeNumber:0];

    [self checkAudioPermissions];
}

- (void)applicationWillTerminate:(UIApplication *const)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

    SMLRLogFunc;
}

- (SMLRAddressBookViewController *)getRootViewController
{
    if ([self.window.rootViewController isKindOfClass:SMLRAddressBookViewController.class]) {
        return (SMLRAddressBookViewController *)self.window.rootViewController;
    }

    SMLRLogE(@"no root view controller");
    return nil;
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler
{
    SMLRLogI(@"didReceiveNotificationResponse: %@", response.notification.request.content.userInfo);

    if ([SMLRMissedCallUserNotification isActionCall:response]) {
        [[self getRootViewController] callContact:[[SMLRContact alloc] initWithDictionary:response.notification.request.content.userInfo]];
    }

    if (completionHandler) {
        completionHandler();
    }
}

- (BOOL)application:(UIApplication *)application
    continueUserActivity:(nonnull NSUserActivity *)userActivity
      restorationHandler:(nonnull void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler
{
    SMLRLogI(@"continueUserActivity: %@", userActivity);
    if ([userActivity.activityType isEqualToString:@"INStartAudioCallIntent"]) {
        INPerson *const person = [[(INStartAudioCallIntent*)userActivity.interaction.intent contacts] firstObject];
        NSString *const phoneNumber = person.personHandle.value;

        SMLRLogI(@"calling contact with phoneNumer=%@", phoneNumber);
        [[self getRootViewController] callPhoneNumber:phoneNumber];
    }

    return YES;
}

- (void)application:(UIApplication *const)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *const)deviceToken
{
    SMLRLogI(@"not storing no-voip push notification token=%@", (NSString *)deviceToken);
}

- (void)application:(UIApplication *const)application didFailToRegisterForRemoteNotificationsWithError:(NSError *const)error
{
    SMLRLogE(@"Failed to register to no-voip push notification, error: %@", error);
    [[UIApplication sharedApplication] endBackgroundTask:_backgroundTaskIdentifier];
}

- (void)application:(UIApplication *const)application didReceiveRemoteNotification:(NSDictionary *const)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))handler
{
    [self handleRemoteNotification:userInfo];
    handler(UIBackgroundFetchResultNoData);
}

- (void)handleRemoteNotification:(NSDictionary *const)userInfo
{
    SMLRLogI(@"Received no-voip push notification: userInfo=%@", userInfo);
    [self checkForIncomingCalls];
}

- (void)pushRegistry:(PKPushRegistry *const)registry didUpdatePushCredentials:(PKPushCredentials *const)credentials forType:(NSString *const)type
{
    SMLRLogI(@"voip push notification credentials received type=%@", type);
    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self storeDeviceToken:credentials.token];
    });
}

- (void)pushRegistry:(PKPushRegistry *const)registry didReceiveIncomingPushWithPayload:(PKPushPayload *const)payload forType:(PKPushType)type withCompletionHandler:(void (^)(void))completion
{
    SMLRLogI(@"voip push notification arrived with type: %@", type);

    [self reportIncomingCallWithPayload:payload];

    completion();

    dispatch_async(dispatch_get_main_queue(), ^(void){
        [self checkForIncomingCalls];
    });
}

- (void)reportIncomingCallWithPayload:(PKPushPayload *const)payload
{
    NSDictionary *const payloadCaller = [[payload dictionaryPayload] valueForKey:@"caller"];
    NSString *const callerSimlarId = [SMLRAesUtil decryptMessage:[payloadCaller valueForKey:@"encryptedSimlarId"]
                                        withInitializationVector:[payloadCaller valueForKey:@"initializationVector"]
                                                    withPassword:[SMLRCredentials getPasswordHash]];

    [[self getRootViewController] getGuiTelephoneNumberWithSimlarId:callerSimlarId completionHandler:^(NSString *const guiTelephoneNumber) {
        [_providerDelegate reportIncomingCallWithHandle:guiTelephoneNumber != nil ? guiTelephoneNumber : @"Simlar Call"];
    }];
}

- (void)storeDeviceToken:(NSData *const)deviceToken
{
    const uint32_t *const tokenArray = [deviceToken bytes];
    NSString *const pushId = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                              ntohl(tokenArray[0]), ntohl(tokenArray[1]), ntohl(tokenArray[2]), ntohl(tokenArray[3]),
                              ntohl(tokenArray[4]), ntohl(tokenArray[5]), ntohl(tokenArray[6]), ntohl(tokenArray[7])];

    SMLRLogI(@"Push notification deviceToken=%@", pushId);

    [SMLRStorePushId storeWithPushId:pushId completionHandler:^(NSError *const error)
    {
        [[UIApplication sharedApplication] endBackgroundTask:_backgroundTaskIdentifier];

        if (error != nil) {
            SMLRLogE(@"An error occured while trying to store pushId: %@", error);
            return;
        }

        SMLRLogI(@"Successfully stored pushId on server");
    }];
}

- (void)checkForIncomingCalls
{
    if (![SMLRCredentials isInitialized]) {
        return;
    }

    [[self getRootViewController] checkForIncomingCalls];
}

- (void)checkAudioPermissions
{
    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
        if (!granted) {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                SMLRLogW(@"no microphone permission");
                [SMLRAlert showWithViewController:[[self getRootViewController] getPresentingViewController]
                                            title:@"No Microphone Permission"
                                          message:@"Please allow Simlar to use the microphone. Check your settings."
                                 closeButtonTitle:@"Ok"];
            });
        }
    }];
}

@end

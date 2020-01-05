/**
 * Copyright (C) 2014 - 2016 The Simlar Authors.
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

#import "SMLRMissedCallUserNotification.h"

#import "SMLRContact.h"
#import "SMLRLog.h"

#import <UserNotifications/UserNotifications.h>

@implementation SMLRMissedCallUserNotification

static NSString *const kCategoryIdentifier = @"MISSED_CALL_CATEGORY";
static NSString *const kRequestIdentifier = @"MISSED_CALL_REQUEST";
static NSString *const kActionIdentifierCall = @"CALL_MISSED_CALL";

+ (void)presentWithContact:(SMLRContact *const)contact
{
    SMLRLogI(@"showing missed call notification");

    UNMutableNotificationContent *const content = [[UNMutableNotificationContent alloc] init];
    content.body = [NSString stringWithFormat:@"%@ tried to call you", contact.name];
    content.userInfo = contact.toDictonary;
    content.categoryIdentifier = kCategoryIdentifier;

    UNNotificationRequest *const notificationRequest = [UNNotificationRequest requestWithIdentifier:kRequestIdentifier content:content trigger:nil];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:notificationRequest
                                                           withCompletionHandler:^(NSError *const _Nullable error) {
        if (error != nil) {
            SMLRLogE(@"Error while requesting missed call UserNotification: %@", error);
        } else {
            SMLRLogI(@"requested missed call UserNotification");
        }
    }];
}

+ (UNNotificationCategory *)createCategory
{
    UNNotificationAction *const actionCall = [UNNotificationAction actionWithIdentifier:kActionIdentifierCall
                                                                                  title:@"Call back"
                                                                                options:UNNotificationActionOptionForeground];

    return [UNNotificationCategory categoryWithIdentifier:kCategoryIdentifier
                                                  actions:@[actionCall]
                                        intentIdentifiers:@[]
                                                  options:UNNotificationCategoryOptionNone];
}

+ (BOOL)isActionCall:(UNNotificationResponse *const)response
{
    return [response.actionIdentifier isEqualToString:kActionIdentifierCall];
}

@end

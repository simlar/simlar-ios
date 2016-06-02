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

#import "SMLRIncomingCallLocalNotification.h"

#import "SMLRRingtone.h"

@implementation SMLRIncomingCallLocalNotification

static NSString *const kCategoryIdentifier = @"INCOMING_CALL_CATEGORY";
static NSString *const kLocalNotificationActionIdentifierAcceptCall = @"SIMLAR_ACCEPT_CALL";
static NSString *const kLocalNotificationActionIdentifierDeclineCall = @"SIMLAR_DECLINE_CALL";

+ (UILocalNotification *)createWithContactName:(NSString *const)contactName
{
    UILocalNotification *const notification = [[UILocalNotification alloc] init];
    notification.alertBody = [NSString stringWithFormat:@"%@ is calling you", contactName];
    notification.soundName = SIMLAR_RINGTONE;
    notification.category  = kCategoryIdentifier;
    return notification;
}

+ (UIMutableUserNotificationCategory *)createCategory
{
    UIMutableUserNotificationAction *const acceptAction = [[UIMutableUserNotificationAction alloc] init];
    acceptAction.identifier             = kLocalNotificationActionIdentifierAcceptCall;
    acceptAction.title                  = @"Accept";
    acceptAction.activationMode         = UIUserNotificationActivationModeBackground; // foreground requires user to login
    acceptAction.destructive            = NO;
    acceptAction.authenticationRequired = NO;

    UIMutableUserNotificationAction *const declineAction = [[UIMutableUserNotificationAction alloc] init];
    declineAction.identifier             = kLocalNotificationActionIdentifierDeclineCall;
    declineAction.title                  = @"Decline";
    declineAction.activationMode         = UIUserNotificationActivationModeBackground;
    declineAction.destructive            = NO;
    declineAction.authenticationRequired = NO;

    UIMutableUserNotificationCategory *const incomingCallCategory = [[UIMutableUserNotificationCategory alloc] init];
    incomingCallCategory.identifier = kCategoryIdentifier;
    [incomingCallCategory setActions:@[acceptAction, declineAction] forContext:UIUserNotificationActionContextDefault];
    [incomingCallCategory setActions:@[acceptAction, declineAction] forContext:UIUserNotificationActionContextMinimal];
    return incomingCallCategory;
}

+ (BOOL)euqalsCategoryName:(UILocalNotification *const)notification
{
    return [notification.category isEqualToString:kCategoryIdentifier];
}

+ (BOOL)euqalsActionIdentifierAcceptCall:(NSString *const)identifier
{
    return [identifier isEqualToString:kLocalNotificationActionIdentifierAcceptCall];
}

+ (BOOL)euqalsActionIdentifierDeclineCall:(NSString *const)identifier
{
    return [identifier isEqualToString:kLocalNotificationActionIdentifierDeclineCall];
}

@end

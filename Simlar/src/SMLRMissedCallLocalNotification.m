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

#import "SMLRMissedCallLocalNotification.h"

#import "SMLRContact.h"

@implementation SMLRMissedCallLocalNotification

static NSString *const kCategoryIdentifier = @"MISSED_CALL_CATEGORY";
static NSString *const kLocalNotificationActionIdentifierCall = @"SIMLAR_CALL";

+ (UILocalNotification *)createWithContact:(SMLRContact *const)contact
{
    UILocalNotification *const notification = [[UILocalNotification alloc] init];
    notification.alertBody = [NSString stringWithFormat:@"%@ tried to call you", contact.name];
    notification.category  = kCategoryIdentifier;
    notification.userInfo  = contact.toDictonary;
    return notification;
}

+ (UIMutableUserNotificationCategory *)createCategory
{
    UIMutableUserNotificationAction *const acceptAction = [[UIMutableUserNotificationAction alloc] init];
    acceptAction.identifier             = kLocalNotificationActionIdentifierCall;
    acceptAction.title                  = @"Call back";
    acceptAction.activationMode         = UIUserNotificationActivationModeForeground;
    acceptAction.destructive            = NO;
    acceptAction.authenticationRequired = NO;
    
    UIMutableUserNotificationCategory *const incomingCallCategory = [[UIMutableUserNotificationCategory alloc] init];
    incomingCallCategory.identifier = kCategoryIdentifier;
    [incomingCallCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextDefault];
    [incomingCallCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextMinimal];
    return incomingCallCategory;
}

+ (BOOL)euqalsCategoryName:(UILocalNotification *const)notification actionIdentifierCall:(NSString *const)identifier
{
    return [notification.category isEqualToString:kCategoryIdentifier] && [identifier isEqualToString:kLocalNotificationActionIdentifierCall];
}

@end

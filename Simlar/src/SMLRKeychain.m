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

#import "SMLRKeychain.h"

#import "SMLRLog.h"

#import <Security/Security.h>

@implementation SMLRKeychain

static NSString *const SERVICE_NAME = @"org.simlar";

+ (BOOL)storeWithKey:(NSString *const)key value:(NSString *const)value
{
    if ([key length] == 0) {
        SMLRLogI(@"ERROR: No key given");
        return NO;
    }

    if ([value length] == 0) {
        SMLRLogI(@"ERROR: No value given with key=%@", key);
        return NO;
    }

    NSMutableDictionary *const searchDictionary = [self createSearchDictionaryWithKey:key];
    NSData *const data = [value dataUsingEncoding:NSUTF8StringEncoding];
    searchDictionary[(__bridge id)kSecValueData] = data;

    // Access the entry only if the device was unlocked at least once.
    searchDictionary[(__bridge id)kSecAttrAccessible] = (__bridge id)kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly;

    const OSStatus status = SecItemAdd((__bridge CFDictionaryRef)searchDictionary, NULL);
    if (status == errSecSuccess) {
        return YES;
    }

    if (status == errSecDuplicateItem) {
        // Update entry
        NSMutableDictionary *const updateDictionary = [[NSMutableDictionary alloc] init];
        updateDictionary[(__bridge id)kSecValueData] = data;

        OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)searchDictionary,
                                        (__bridge CFDictionaryRef)updateDictionary);

        return (status == errSecSuccess) ? YES : NO;
    }

    return NO;
}

+ (NSString *)getWithKey:(NSString *const)key
{
    if ([key length] == 0) {
        SMLRLogI(@"ERROR: No key given");
        return nil;
    }

    NSMutableDictionary *const searchDictionary = [self createSearchDictionaryWithKey:key];
    searchDictionary[(__bridge id)kSecMatchLimit] = (__bridge id)kSecMatchLimitOne;
    searchDictionary[(__bridge id)kSecReturnData] = (__bridge id)kCFBooleanTrue;

    CFTypeRef foundData = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)searchDictionary, &foundData);

    if (status != noErr) {
        return nil;
    }

    NSData *const data = (__bridge_transfer NSData *)foundData;
    return (data == nil) ? nil : [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (void)deleteWithKey:(NSString *const)key
{
    if ([key length] == 0) {
        SMLRLogI(@"ERROR: No key given");
        return;
    }

    SecItemDelete((__bridge CFDictionaryRef)[self createSearchDictionaryWithKey : key]);
}

+ (NSMutableDictionary *)createSearchDictionaryWithKey:(NSString *const)key
{
    NSData *const encodedKey = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *const searchDictionary = [[NSMutableDictionary alloc] init];
    searchDictionary[(__bridge id)kSecClass] = (__bridge id)kSecClassGenericPassword;
    searchDictionary[(__bridge id)kSecAttrService] = SERVICE_NAME;
    searchDictionary[(__bridge id)kSecAttrGeneric] = encodedKey;
    searchDictionary[(__bridge id)kSecAttrAccount] = encodedKey;

    return searchDictionary;
}

@end

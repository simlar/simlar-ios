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

#import "SMLRCredentials.h"

#import "SMLRKeychain.h"

#include <CommonCrypto/CommonDigest.h>

@implementation SMLRCredentials

static NSString *const KEY_TELEPHONE_NUMBER = @"telephoneNumber";
static NSString *const KEY_SIMLAR_ID        = @"simlarId";
static NSString *const KEY_PASSWORD         = @"password";


+ (BOOL)saveWithTelephoneNumber:(NSString *const)telephoneNumber simlarId:(NSString *const)simlarId password:(NSString *const)password
{
    return [SMLRKeychain storeWithKey:KEY_TELEPHONE_NUMBER value:telephoneNumber] &&
           [SMLRKeychain storeWithKey:KEY_SIMLAR_ID value:simlarId] &&
           [SMLRKeychain storeWithKey:KEY_PASSWORD value:password];
}

+ (NSString *)getTelephoneNumber
{
    return [SMLRKeychain getWithKey:KEY_TELEPHONE_NUMBER];
}

+ (NSString *)getSimlarId
{
    return [SMLRKeychain getWithKey:KEY_SIMLAR_ID];
}

+ (NSString *)getPassword
{
    return [SMLRKeychain getWithKey:KEY_PASSWORD];
}

+ (NSString *)getPasswordHash
{
    // kamailio password hash md5(username:realm:password)
    return [self md5:[NSString stringWithFormat:@"%@:sip.simlar.org:%@", [self getSimlarId], [self getPassword]]];
}

+ (BOOL)isInitialized
{
    return [[self getSimlarId] length] > 0 && [[self getPassword] length] > 0 && [[self getTelephoneNumber] length] > 0;
}

+ (void) delete
{
    [SMLRKeychain deleteWithKey:KEY_TELEPHONE_NUMBER];
    [SMLRKeychain deleteWithKey:KEY_SIMLAR_ID];
    [SMLRKeychain deleteWithKey:KEY_PASSWORD];
}

+ (NSString *)md5:(NSString *const)string
{
    const char *cString = [string UTF8String];
    unsigned char hash[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cString, strlen(cString), hash);

    /// convert to hex format
    NSMutableString *const retval = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [retval appendFormat:@"%02x", hash[i]];
    }

    return retval;
}

@end

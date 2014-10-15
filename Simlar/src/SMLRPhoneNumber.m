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

#import "SMLRPhoneNumber.h"

#import "SMLRLog.h"
#import "SMLRStringCategory.h"
#import "SMLRSettings.h"

#import "NBPhoneNumberUtil.h"

@interface SMLRPhoneNumber ()

@property (readonly) NBPhoneNumber *phoneNumber;

@end

@implementation SMLRPhoneNumber

+ (SMLRPhoneNumber *)createWithNumber:(NSString *const)number
{
    SMLRPhoneNumber *const instance = [[SMLRPhoneNumber alloc] init];
    NSError *error = nil;
    instance->_phoneNumber = [[NBPhoneNumberUtil sharedInstance] parse:number defaultRegion:[SMLRSettings getDefaultRegion] error:&error];

    if (error != nil) {
        SMLRLogI(@"Error parsing number=%@ error=%@", number, error);
    }

    return instance;
}

- (BOOL)isValid
{
    return [[NBPhoneNumberUtil sharedInstance] isValidNumber:self.phoneNumber];
}

- (NSString *)getRegistrationNumber
{
    return [[NBPhoneNumberUtil sharedInstance] format:self.phoneNumber numberFormat:NBEPhoneNumberFormatE164 error:nil];
}

- (NSString *)getGuiNumber
{
    return [[NBPhoneNumberUtil sharedInstance] format:self.phoneNumber numberFormat:NBEPhoneNumberFormatINTERNATIONAL error:nil];
}

- (NSString *)getSimlarId
{
    NBPhoneNumberUtil *util = [NBPhoneNumberUtil sharedInstance];
    return [NSString stringWithFormat:@"*%@%@*",
                                      [util getCountryCodeForRegion:[util getRegionCodeForNumber:self.phoneNumber]],
                                      [util getNationalSignificantNumber:self.phoneNumber]];
}

+ (NSString *)getRegionWithNumber:(NSString *)countryNumber
{
    return [[NBPhoneNumberUtil sharedInstance] getRegionCodeForCountryCode:@([countryNumber intValue])];
}

+ (BOOL)isSimlarId:(NSString *const)simlarId
{
    return [simlarId matchesPattern:@"^\\*\\d+\\*$"];
}

@end

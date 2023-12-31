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

#import "NBMetadataHelper.h"
#import "NBPhoneNumberUtil.h"

@interface SMLRPhoneNumber ()

@property (nonatomic, readonly) NBPhoneNumber *phoneNumber;

@end

@implementation SMLRPhoneNumber

- (instancetype)initWithNumber:(NSString *const)number
{
    self = [super init];
    if (self == nil) {
        SMLRLogE(@"unable to create SMLRPhoneNumber");
        return nil;
    }

    NSError *error = nil;
    _phoneNumber = [[NBPhoneNumberUtil sharedInstance] parse:number defaultRegion:[SMLRSettings getDefaultRegion] error:&error];

    if (error != nil) {
        SMLRLogI(@"unparsable telephone number=%@ error=%@", number, error);
        return nil;
    }

    return self;
}

- (BOOL)isValid
{
    return [[NBPhoneNumberUtil sharedInstance] isValidNumber:_phoneNumber];
}

- (NSString *)getRegistrationNumber
{
    return [[NBPhoneNumberUtil sharedInstance] format:_phoneNumber numberFormat:NBEPhoneNumberFormatE164 error:nil];
}

- (NSString *)getGuiNumber
{
    return [[NBPhoneNumberUtil sharedInstance] format:_phoneNumber numberFormat:NBEPhoneNumberFormatINTERNATIONAL error:nil];
}

- (NSString *)getSimlarId
{
    NBPhoneNumberUtil *const util = [NBPhoneNumberUtil sharedInstance];
    return [NSString stringWithFormat:@"*%@%@*",
                                      [util getCountryCodeForRegion:[util getRegionCodeForNumber:_phoneNumber]],
                                      [util getNationalSignificantNumber:_phoneNumber]];
}

+ (NSString *)getRegionWithNumber:(NSString *)countryNumber
{
    return [[NBPhoneNumberUtil sharedInstance] getRegionCodeForCountryCode:@([countryNumber intValue])];
}

+ (BOOL)isSimlarId:(NSString *const)simlarId
{
    return [simlarId matchesPattern:@"^\\*\\d+\\*$"];
}

+ (NSString *)getCountryNumberBasedOnCurrentLocale
{
    return [[[NBPhoneNumberUtil sharedInstance] getCountryCodeForRegion:[NSLocale.currentLocale objectForKey:NSLocaleCountryCode]] stringValue];
}

+ (NSArray *)getAllSupportedCountryNumbers
{
    NSMutableOrderedSet *const supportedCountryNumbers = [NSMutableOrderedSet orderedSet];

    for (NSDictionary *const data in [[[NBMetadataHelper alloc] init] getAllMetadata]) {
        [supportedCountryNumbers addObject:[[NBPhoneNumberUtil sharedInstance] getCountryCodeForRegion:data[@"code"]]];
    }

    [supportedCountryNumbers sortUsingComparator:^NSComparisonResult(NSNumber *const obj1, NSNumber *const obj2) {
        return [obj1 compare:obj2];
    }];

    return [supportedCountryNumbers array];
}

@end

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

#import "SMLRStorePushId.h"

#import "SMLRCredentials.h"
#import "SMLRHttpsPost.h"
#import "SMLRLog.h"

@interface SMLRStorePushIdParser : NSObject <NSXMLParserDelegate>

@property (nonatomic) NSError  *error;
@property (nonatomic) NSString *deviceType;
@property (nonatomic) NSString *pushId;

@end

@implementation SMLRStorePushIdParser

- (instancetype)initWithData:(NSData *const)data
{
    self = [super init];
    if (self == nil) {
        SMLRLogE(@"unable to create SMLRStorePushIdParser");
        return nil;
    }

    NSXMLParser *const parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    if (![parser parse] && _error == nil) {
        _error = [NSError errorWithDomain:@"SMLRStorePushIdParser" code:-1 userInfo:@{ NSLocalizedDescriptionKey:@"Parser Error" }];
    }

    return self;
}

- (void)parser:(NSXMLParser *const)parser didStartElement:(NSString *const)elementName namespaceURI:(NSString *const)namespaceURI qualifiedName:(NSString *const)qualifiedName attributes:(NSDictionary *const)attributeDict
{
    if ([elementName isEqualToString:@"error"]) {
        SMLRLogI(@"received error with id=%@ and message=%@", attributeDict[@"id"], attributeDict[@"message"]);
        self.error = [NSError errorWithDomain:@"org.simlar.storePushId" code:[attributeDict[@"id"] integerValue] userInfo:@{NSLocalizedDescriptionKey: attributeDict[@"message"]}];
        return;
    }

    if ([elementName isEqualToString:@"success"]) {
        self.deviceType = attributeDict[@"deviceType"];
        self.pushId     = attributeDict[@"pushId"];
        return;
    }
}

@end



@implementation SMLRStorePushId

static NSString *const kCommand                         = @"store-push-id.php";
static NSString *const kDeviceTypeIphone                = @"2";
static NSString *const kDeviceTypeIphoneDevelopment     = @"3";
static NSString *const kDeviceTypeIphoneVoip            = @"4";
static NSString *const kDeviceTypeIphoneVoipDevelopment = @"5";

+ (NSString *)determineApsEnvironment
{
    NSString *const profilePath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    NSString *const profileAsString = [NSString stringWithContentsOfFile:profilePath encoding:NSISOLatin1StringEncoding error:NULL];

    const NSRange beginRange = [profileAsString rangeOfString:@"<plist"];
    const NSRange endRange = [profileAsString rangeOfString:@"</plist>"];
    if (beginRange.location == NSNotFound || endRange.location == NSNotFound) {
        SMLRLogE(@"plist tags not found in: '%@'", profileAsString);
        return nil;
    }

    const NSRange range = NSMakeRange(beginRange.location, endRange.location + endRange.length - beginRange.location);
    NSString *const plistAsString = [profileAsString substringWithRange:range];

    NSDictionary *const plist = [NSPropertyListSerialization propertyListWithData:[plistAsString dataUsingEncoding:NSISOLatin1StringEncoding]
                                                                          options:NSPropertyListImmutable
                                                                           format:nil
                                                                            error:nil];

    return [[plist valueForKey:@"Entitlements"] valueForKey:@"aps-environment"];
}

+ (NSString *)detectIphoneDeviceTypeWithApsEnvironment:(NSString *const)apsEnvironment
{
    if ([[apsEnvironment uppercaseString] isEqualToString:@"DEVELOPMENT"]) {
        return kDeviceTypeIphoneVoipDevelopment;
    } else {
        return [self needsIOS80Workaround] ? kDeviceTypeIphoneVoipDevelopment : kDeviceTypeIphoneVoip;
    }
}

+ (BOOL)needsIOS80Workaround
{
    const NSOperatingSystemVersion version = [[NSProcessInfo alloc] init].operatingSystemVersion;
    return version.majorVersion == 8 && version.minorVersion == 0; // Versions >= 8.1 are not affected
}

+ (void)storeWithPushId:(NSString *const)pushId completionHandler:(void (^)(NSError *const error))handler
{
    if (![SMLRCredentials isInitialized]) {
        handler([NSError errorWithDomain:@"org.simlar.storePushId" code:2 userInfo:@{ NSLocalizedDescriptionKey :@"credentials not initialized" }]);
        return;
    }

    NSString *const apsEnvironment = [self determineApsEnvironment];
    NSString *const deviceType = [self detectIphoneDeviceTypeWithApsEnvironment:apsEnvironment];
    SMLRLogI(@"detected deviceType '%@' in environment '%@'", deviceType, apsEnvironment);

    NSDictionary *const dict = @{ @"login" : [SMLRCredentials getSimlarId],
                                  @"password" : [SMLRCredentials getPasswordHash],
                                  @"deviceType" : deviceType,
                                  @"pushId" : pushId };
    [SMLRHttpsPost postAsynchronousCommand:kCommand parameters:dict completionHandler:^(NSData *const data, NSError *const error)
     {
         if (error != nil) {
             handler(error);
             return;
         }

         SMLRStorePushIdParser *const parser = [[SMLRStorePushIdParser alloc] initWithData:data];
         if (parser.error != nil) {
             handler(parser.error);
             return;
         }

         if (![parser.deviceType isEqualToString:deviceType] || ![parser.pushId isEqualToString:pushId]) {
             handler([NSError errorWithDomain:@"org.simlar.storePushId" code:2 userInfo:@{ NSLocalizedDescriptionKey :@"deviceType or pushId mismatch" }]);
             return;
         }

         handler(nil);
     }];
}

@end

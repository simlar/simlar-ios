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

@property NSError  *error;
@property NSString *deviceType;
@property NSString *pushId;

@end

@implementation SMLRStorePushIdParser

- (void)parseXml:(NSData *const)data
{
    NSXMLParser *const parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    const BOOL result = [parser parse];

    SMLRLogI(@"Parse result %d", result);
}

- (void)parser:(NSXMLParser *const)parser didStartElement:(NSString *const)elementName namespaceURI:(NSString *const)namespaceURI qualifiedName:(NSString *const)qualifiedName attributes:(NSDictionary *const)attributeDict
{
    if ([elementName isEqualToString:@"error"]) {
        SMLRLogI(@"error element with id=%@ and message=%@", attributeDict[@"id"], attributeDict[@"message"]);
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

static NSString *const COMMAND                        = @"store-push-id.php";
static NSString *const DEVICE_TYPE_IPHONE             = @"2";
static NSString *const DEVICE_TYPE_IPHONE_DEVELOPMENT = @"3";

+ (NSString *)detectIphoneDeviceType
{
#if DEBUG
    return DEVICE_TYPE_IPHONE_DEVELOPMENT;
#else
    return DEVICE_TYPE_IPHONE;
#endif
}

+ (void)storeWithPushId:(NSString *const)pushId completionHandler:(void (^)(NSError *const error))handler
{
    NSDictionary *const dict = @{ @"login" : [SMLRCredentials getSimlarId],
                                  @"password" : [SMLRCredentials getPasswordHash],
                                  @"deviceType" : [self detectIphoneDeviceType],
                                  @"pushId" : pushId };
    [SMLRHttpsPost postAsynchronousCommand:COMMAND parameters:dict completionHandler:^(NSData *const data, NSError *const error)
     {
         if (error != nil) {
             handler(error);
             return;
         }

         SMLRStorePushIdParser *const parser = [[SMLRStorePushIdParser alloc] init];
         [parser parseXml:data];
         if (parser.error != nil) {
             handler(parser.error);
             return;
         }

         if (![parser.deviceType isEqualToString:[self detectIphoneDeviceType]] || ![parser.pushId isEqualToString:pushId]) {
             handler([NSError errorWithDomain:@"org.simlar.storePushId" code:2 userInfo:@{ NSLocalizedDescriptionKey :@"deviceType or pushId mismatch" }]);
             return;
         }

         handler(nil);
     }];
}

@end

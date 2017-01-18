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

#import "SMLRGetContactStatus.h"

#import "SMLRCredentials.h"
#import "SMLRHttpsPost.h"
#import "SMLRLog.h"

@interface SMLRContactsParser : NSObject <NSXMLParserDelegate>

@property (nonatomic) NSError             *error;
@property (nonatomic) NSMutableDictionary *contactStatusMap;

@end

@implementation SMLRContactsParser

- (instancetype)initWithData:(NSData *const)data
{
    self = [super init];
    if (self == nil) {
        SMLRLogE(@"unable to create SMLRContactsParser");
        return nil;
    }

    _error = nil;
    _contactStatusMap = [NSMutableDictionary dictionary];

    NSXMLParser *const parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    if (![parser parse] && _error == nil) {
        _error = [NSError errorWithDomain:@"org.simlar.getContactStatus" code:-1 userInfo:@{ NSLocalizedDescriptionKey:@"Parser Error" }];
    }

    return self;
}

- (void)parser:(NSXMLParser *const)parser  didStartElement:(NSString *const)elementName
  namespaceURI:(NSString *const)namespaceURI qualifiedName:(NSString *const)qualifiedName
    attributes:(NSDictionary *const)attributeDict
{
    if ([elementName isEqualToString:@"error"]) {
        SMLRLogI(@"error element with id=%@ and message=%@", attributeDict[@"id"], attributeDict[@"message"]);
        self.error = [NSError errorWithDomain:@"org.simlar.getContactStatus" code:[attributeDict[@"id"] integerValue] userInfo:@{NSLocalizedDescriptionKey: attributeDict[@"message"]}];
        return;
    }

    if ([elementName isEqualToString:@"contact"]) {
        [self.contactStatusMap setValue:attributeDict[@"status"] forKey:attributeDict[@"id"]];
        return;
    }
}

@end


@implementation SMLRGetContactStatus

static NSString *const kCommand = @"get-contacts-status.php";


+ (void)getWithSimlarIds:(NSArray *const)simlarIds
       completionHandler:(void (^)(NSDictionary *const contactStatusMap, NSError *const error))handler
{
    NSDictionary *const dict = @{ @"login":[SMLRCredentials getSimlarId],
                               @"password":[SMLRCredentials getPasswordHash],
                               @"contacts":[simlarIds componentsJoinedByString:@"|"] };
    [SMLRHttpsPost postAsynchronousCommand:kCommand parameters:dict completionHandler:^(NSData *const data, NSError *const error)
     {
         if (error != nil) {
             handler(nil, error);
             return;
         }

         SMLRContactsParser *const parser = [[SMLRContactsParser alloc] initWithData:data];
         handler(parser.contactStatusMap, parser.error);
     }];
}

@end

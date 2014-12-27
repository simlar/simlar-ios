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

#import "SMLRCreateAccount.h"

#import "SMLRHttpsPost.h"
#import "SMLRLog.h"

@interface SMLRCreateAccountParser : NSObject <NSXMLParserDelegate>

@property (nonatomic) NSError  *error;
@property (nonatomic) NSString *simlarId;
@property (nonatomic) NSString *password;
@property (nonatomic) NSString *registrationCode;

@end

NSString *const SMLRCreateAccountErrorDomain = @"org.simlar.createAccount";

@implementation SMLRCreateAccountParser

- (instancetype)initWithData:(NSData *const)data
{
    self = [super init];
    if (self == nil) {
        SMLRLogE(@"unable to create SMLRCreateAccountParser");
        return nil;
    }

    NSXMLParser *const parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    if (![parser parse] && _error == nil) {
        _error = [NSError errorWithDomain:SMLRCreateAccountErrorDomain code:-1 userInfo:@{ NSLocalizedDescriptionKey:@"Parser Error" }];
    }

    return self;
}

- (void)parser:(NSXMLParser *const)parser didStartElement:(NSString *const)elementName namespaceURI:(NSString *const)namespaceURI qualifiedName:(NSString *const)qualifiedName attributes:(NSDictionary *const)attributeDict
{
    if ([elementName isEqualToString:@"error"]) {
        SMLRLogI(@"error element with id=%@ and message=%@", attributeDict[@"id"], attributeDict[@"message"]);
        self.error = [NSError errorWithDomain:SMLRCreateAccountErrorDomain code:[attributeDict[@"id"] integerValue] userInfo:@{NSLocalizedDescriptionKey: attributeDict[@"message"]}];
        return;
    }

    if ([elementName isEqualToString:@"success"]) {
        self.simlarId = attributeDict[@"simlarId"];
        self.password = attributeDict[@"password"];
        self.registrationCode = attributeDict[@"registrationCode"];
        return;
    }
}

@end



@implementation SMLRCreateAccount

static NSString *const kCommand = @"create-account.php";
static NSString *const kSmsText = @"Welcome to Simlar! When the app asks for a registration code, use: *CODE*.";


+ (void)requestWithTelephoneNumber:(NSString *const)telephoneNumber
                 completionHandler:(void (^)(NSString *const simlarId, NSString *const password, NSError *const error))handler
{
    if ([telephoneNumber length] == 0) {
        SMLRLogI(@"confirmWithSimlarId ERROR: empty telephoneNumber");
        return;
    }

    if (handler == nil) {
        SMLRLogI(@"confirmWithSimlarId ERROR: empty completionHandler");
        return;
    }

    NSDictionary *const dict = @{ @"command":@"request", @"telephoneNumber":telephoneNumber, @"smsText":kSmsText };
    [SMLRHttpsPost postAsynchronousCommand:kCommand parameters:dict completionHandler:^(NSData *const data, NSError *const error) {
        if (error != nil) {
            handler(nil, nil, error);
            return;
        }

        SMLRCreateAccountParser *const parser = [[SMLRCreateAccountParser alloc] initWithData:data];
        handler(parser.simlarId, parser.password, parser.error);
    }];
}

+ (void)confirmWithSimlarId:(NSString *const)simlarId
           registrationCode:(NSString *const)registrationCode
          completionHandler:(void (^)(NSString *const simlarId, NSString *const registrationCode, NSError *const error))handler
{
    if ([simlarId length] == 0) {
        SMLRLogI(@"confirmWithSimlarId ERROR: empty simlarId");
        return;
    }

    if ([registrationCode length] == 0) {
        SMLRLogI(@"confirmWithSimlarId ERROR: empty registrationCode");
        return;
    }

    if (handler == nil) {
        SMLRLogI(@"confirmWithSimlarId ERROR: empty completionHandler");
        return;
    }

    NSDictionary *const dict = @{ @"command":@"confirm", @"simlarId":simlarId, @"registrationCode":registrationCode };
    [SMLRHttpsPost postAsynchronousCommand:kCommand parameters:dict completionHandler:^(NSData *const data, NSError *const error) {
        if (error != nil) {
            handler(nil, nil, error);
            return;
        }

        SMLRCreateAccountParser *const parser = [[SMLRCreateAccountParser alloc] initWithData:data];
        handler(parser.simlarId, parser.registrationCode, parser.error);
    }];
}

@end

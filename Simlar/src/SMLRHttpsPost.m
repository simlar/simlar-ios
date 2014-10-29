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

#import "SMLRHttpsPost.h"

#import "SMLRLog.h"

////
//// SMLRUrlConnection
////

@interface SMLRUrlConnection : NSURLConnection

@property (nonatomic) NSMutableData *receivedData;
@property (nonatomic, copy) void (^completionHandler)(NSData *const, NSError *const);

@end

@implementation SMLRUrlConnection

static NSString *const kSimlarUrl = @"https://sip.simlar.org:6161";

- (instancetype)initWithCommand:(NSString *const)command
                    contentType:(NSString *const)contentType
                           body:(NSData *const)body
              completionHandler:(void (^)(NSData *const data, NSError *const connectionError))handler

{
    SMLRLogI(@"startSend");

    NSURL *const url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", kSimlarUrl, command]];
    if (url == nil) {
        SMLRLogI(@"Invalid URL");
        return nil;
    }

    NSMutableURLRequest *const request = [NSMutableURLRequest requestWithURL:url
                                                                 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                             timeoutInterval:20.0];
    assert(request != nil);

    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:body];

    self = [super initWithRequest:request delegate:self];

    if (self) {
        _receivedData = [[NSMutableData alloc] init];
        _completionHandler = handler;
    }

    SMLRLogI(@"post started");
    return self;
}

+ (NSString *)urlEncode:(NSString *const)string
{
    return [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
}

- (void)dealloc
{
    SMLRLogFunc;
}

///
/// Delegate methods called by the NSURLConnection
///
- (void)connection:(NSURLConnection *const)theConnection didReceiveResponse:(NSURLResponse *const)response
{
    assert(theConnection == self);

    NSHTTPURLResponse *const httpResponse = (NSHTTPURLResponse *)response;
    assert([httpResponse isKindOfClass:[NSHTTPURLResponse class]]);

    _receivedData.length = 0;

    if ((httpResponse.statusCode / 100) != 2) {
        SMLRLogI(@"HTTP error %zd", (ssize_t)httpResponse.statusCode);
        [self cancel];
        self.completionHandler(nil, [NSError errorWithDomain:@"org.simlar.httpsPost" code:1 userInfo:@{NSLocalizedDescriptionKey: @"An error occured while connecting to simlar. Please try again later."}]);
    } else {
        SMLRLogI(@"Response OK.");
    }
}

- (void)connection:(NSURLConnection *const)theConnection didReceiveData:(NSData *const)data
{
    assert(theConnection == self);

    [_receivedData appendData:data];
}

- (void)connection:(NSURLConnection *const)theConnection didFailWithError:(NSError *const)error
{
    assert(theConnection == self);

    SMLRLogI(@"Connection failed with error: %@", [error description]);
    [self cancel];
    self.completionHandler(nil, error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *const)theConnection
{
    assert(theConnection == self);

    /// This may log the users password and should only be used for developing
    //NSString * xmlData = [[NSString alloc] initWithData:_receivedData encoding:NSUTF8StringEncoding];
    //SMLRLogI(@"connectionDidFinishLoading: %@", xmlData);

    self.completionHandler(_receivedData, nil);
}

/// Make sure we use the Simlar CA
- (void)connection:(NSURLConnection *const)theConnection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *const)challenge
{
    SMLRLogFunc;

    BOOL trusted = NO;
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSString *thePath = [[NSBundle mainBundle] pathForResource:@"simlarca" ofType:@"der"];
        NSData *certData = [[NSData alloc] initWithContentsOfFile:thePath];
        CFDataRef certDataRef = (__bridge_retained CFDataRef)certData;
        SecCertificateRef cert = SecCertificateCreateWithData(NULL, certDataRef);
        SecPolicyRef policyRef = SecPolicyCreateBasicX509();
        SecCertificateRef certArray[1] = { cert };
        CFArrayRef certArrayRef = CFArrayCreate(NULL, (void *)certArray, 1, NULL);
        SecTrustRef serverTrust = challenge.protectionSpace.serverTrust;
        SecTrustSetAnchorCertificates(serverTrust, certArrayRef);
        SecTrustResultType trustResult;
        SecTrustEvaluate(serverTrust, &trustResult);
        trusted = (trustResult == kSecTrustResultUnspecified);
        CFRelease(certArrayRef);
        CFRelease(policyRef);
        CFRelease(cert);
        CFRelease(certDataRef);
    }

    if (trusted) {
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    } else {
        [challenge.sender performDefaultHandlingForAuthenticationChallenge:challenge];
    }
}

@end

////
//// SMLRHttpsPost
////

@interface SMLRHttpsPost ()

@end

@implementation SMLRHttpsPost

+ (NSData *)createBodyWithParameters:(NSDictionary *const)parameters
{
    NSString *const bodyData = [self createQueryString:parameters];
    return [NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])];
}

+ (NSString *)createQueryString:(NSDictionary *const)parameters
{
    __block NSMutableString *const queryString = [[NSMutableString alloc] init];
    __block BOOL first = YES;
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *const key, NSString *const value, BOOL *const stop) {
        if (first) {
            first = NO;
            [queryString appendString:[NSString stringWithFormat:@"%@=%@", [SMLRUrlConnection urlEncode:key], [SMLRUrlConnection urlEncode:value]]];
        } else {
            [queryString appendString:[NSString stringWithFormat:@"&%@=%@", [SMLRUrlConnection urlEncode:key], [SMLRUrlConnection urlEncode:value]]];
        }
    }];
    return queryString;
}

+ (void)postAsynchronousCommand:(NSString *const)command
                     parameters:(NSDictionary *const)parameters
              completionHandler:(void (^)(NSData *const data, NSError *const connectionError))handler
{
    [self postAsynchronousCommand:command
                      contentType:@"application/x-www-form-urlencoded"
                             body:[self createBodyWithParameters:parameters]
                completionHandler:handler];
}

+ (void)postAsynchronousCommand:(NSString *const)command
                    contentType:(NSString *const)contentType
                           body:(NSData *const)body
              completionHandler:(void (^)(NSData *const data, NSError *const connectionError))handler
{
    SMLRUrlConnection *const connection = [[SMLRUrlConnection alloc] initWithCommand:command
                                                                         contentType:contentType
                                                                                body:body
                                                                   completionHandler:handler];
#pragma unused(connection)
}

@end

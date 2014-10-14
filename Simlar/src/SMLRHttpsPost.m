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

static NSString *const SIMLAR_URL = @"https://sip.simlar.org:6161";

- (instancetype)initWithCommand:(NSString *const)command
           parameters:(NSDictionary *const)parameters
    completionHandler:(void (^)(NSData *const data, NSError *const connectionError))handler

{
    SMLRLogI(@"startSend");

    NSURL *const url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", SIMLAR_URL, command]];
    if (url == nil) {
        SMLRLogI(@"Invalid URL");
        return nil;
    }

    NSMutableURLRequest *const request = [NSMutableURLRequest requestWithURL:url
                                                                 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                             timeoutInterval:20.0];
    assert(request != nil);

    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];

    NSString *const bodyData = [SMLRUrlConnection createQueryString:parameters];
    [request setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:strlen([bodyData UTF8String])]];

    self = [super initWithRequest:request delegate:self];

    if (self) {
        self.receivedData = [[NSMutableData alloc] init];
        self.completionHandler = handler;
    }

    SMLRLogI(@"post started");
    return self;
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

    self.receivedData.length = 0;

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

    [self.receivedData appendData:data];
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
    //NSString * xmlData = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    //SMLRLogI(@"connectionDidFinishLoading: %@", xmlData);

    self.completionHandler(self.receivedData, nil);
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

+ (void)postAsynchronousCommand:(NSString *const)command
                     parameters:(NSDictionary *const)parameters
              completionHandler:(void (^)(NSData *const data, NSError *const connectionError))handler
{
    SMLRUrlConnection *const connection = [[SMLRUrlConnection alloc] initWithCommand:command parameters:parameters completionHandler:handler];
#pragma unused(connection)
}

@end

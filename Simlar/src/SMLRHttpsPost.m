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
#import "SMLRHttpsPostError.h"
#import "SMLRServerSettings.h"

#import "SMLRLog.h"

////
//// SMLRUrlConnection
////

@interface SMLRUrlConnection : NSObject<NSURLSessionDelegate>
@end

@implementation SMLRUrlConnection

static NSString *const kSimlarUrl = @"https://" SIMLAR_DOMAIN @":6161";

- (instancetype)initWithCommand:(NSString *const)command
                    contentType:(NSString *const)contentType
                           body:(NSData *const)body
              completionHandler:(void (^)(NSData *const data, NSError *const connectionError))handler

{
    SMLRLogI(@"startSend");

    self = [super init];

    if (self == nil) {
        SMLRLogE(@"unable to create SMLRUrlConnection");
        return nil;
    }

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

    NSURLSessionConfiguration *const config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *const session = [NSURLSession sessionWithConfiguration:config
                                                                delegate:self
                                                           delegateQueue:[NSOperationQueue mainQueue]];

    NSURLSessionDataTask *const task = [session dataTaskWithRequest:request
                                                  completionHandler:^(NSData *const data,
                                                                      NSURLResponse *const response,
                                                                      NSError *const error) {
        NSHTTPURLResponse *const httpResponse = (NSHTTPURLResponse *)response;
        assert([httpResponse isKindOfClass:[NSHTTPURLResponse class]]);

        if ((httpResponse.statusCode / 100) != 2) {
            SMLRLogI(@"HTTP error %zd", (ssize_t)httpResponse.statusCode);
            handler(nil, [NSError errorWithDomain:@"org.simlar.httpsPost"
                                             code:1
                                         userInfo:@{NSLocalizedDescriptionKey:@"An error occured while connecting to simlar. Please try again later."}]);
        } else {
            handler(data, error);
        }
    }];

    [task resume];

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

+ (BOOL)remoteCertificatesContain:(SecTrustRef)serverTrust key:(NSData *const)certificateData
{
    for (CFIndex i = 0; i < SecTrustGetCertificateCount(serverTrust); ++i) {
        SecCertificateRef remoteCertificate = SecTrustGetCertificateAtIndex(serverTrust, i);
        NSData *const remoteCertificateData = CFBridgingRelease(SecCertificateCopyData(remoteCertificate));

        if ([remoteCertificateData isEqualToData:certificateData]) {
            return YES;
        }
    }

    return NO;
}

///
/// Delegate methods called by NSURLSession
///

/// Make sure we use the Simlar CA
- (void)URLSession:(NSURLSession *const)session didReceiveChallenge:(NSURLAuthenticationChallenge *const)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
{
    SMLRLogFunc;

    NSString *const certificatePath = [[NSBundle mainBundle] pathForResource:@"simlarca" ofType:@"der"];
    NSData *const certificateData   = [[NSData alloc] initWithContentsOfFile:certificatePath];
    SecCertificateRef certificate   = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)certificateData);
    SecTrustRef serverTrust         = challenge.protectionSpace.serverTrust;
    SecTrustSetAnchorCertificates(serverTrust, (__bridge CFArrayRef)@[ CFBridgingRelease(certificate) ]);
    SecTrustResultType trustResult;
    const OSStatus status = SecTrustEvaluate(serverTrust, &trustResult);

    if (status == errSecSuccess && trustResult == kSecTrustResultUnspecified && [SMLRUrlConnection remoteCertificatesContain:serverTrust key:certificateData]) {
        completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
    } else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
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
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *const key, NSString *const value, BOOL *const stop) {
        if ([queryString length] > 0) {
            [queryString appendString:@"&"];
        }

        [queryString appendString:[NSString stringWithFormat:@"%@=%@", [SMLRUrlConnection urlEncode:key], [SMLRUrlConnection urlEncode:value]]];
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

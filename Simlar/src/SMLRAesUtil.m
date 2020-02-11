/**
 * Copyright (C) 2020 The Simlar Authors.
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

#import "SMLRAesUtil.h"

#import "SMLRLog.h"

#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation SMLRAesUtil

+ (NSData *)sha256:(NSString*)input
{
    NSData *const inputData = [input dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *const sha256Data = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    CC_SHA256([inputData bytes], (CC_LONG)[inputData length], [sha256Data mutableBytes]);
    return sha256Data;
}

+ (NSString *)decryptMessage:(NSString *const)message withInitializationVector:(NSString *const)initializationVector withPassword:(NSString *const)password
{
    if ([message length] == 0 || [initializationVector length] == 0) {
        SMLRLogW(@"decryptMessage with invalid parameters: message=%@ initializationVector=%@", message, initializationVector);
        return @"";
    }

    NSData *const encryptedData = [[NSData alloc] initWithBase64EncodedString:message options:0];
    const NSUInteger encryptedDataSize = [encryptedData length];

    NSData *const ivData = [[NSData alloc] initWithBase64EncodedString:initializationVector options:0];
    NSData *const keyData = [SMLRAesUtil sha256:password];

    const size_t outputSize = encryptedDataSize + kCCBlockSizeAES128;
    void *const output = malloc(outputSize);

    size_t decryptedBytes = 0;
    const CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                                kCCAlgorithmAES128,
                                                kCCOptionPKCS7Padding,
                                                [keyData bytes], kCCKeySizeAES256,
                                                [ivData bytes],
                                                [encryptedData bytes], encryptedDataSize,
                                                output, outputSize,
                                                &decryptedBytes);

    if (cryptStatus == kCCSuccess) {
        return [[NSString alloc] initWithData:[NSData dataWithBytesNoCopy:output
                                                                   length:decryptedBytes
                                                             freeWhenDone:YES]
                                     encoding:NSUTF8StringEncoding];
    }

    SMLRLogW(@"unable tp decrypt: message=%@ initializationVector=%@", message, initializationVector);
    free(output);
    return @"";
}

@end

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

#import "SMLRUploadLogFile.h"

#import "SMLRCredentials.h"
#import "SMLRHttpsPost.h"
#import "SMLRLog.h"
#import "SMLRStringCategory.h"

@implementation SMLRUploadLogFile

static NSString *const kCommand      = @"upload-logfile.php";
static NSString *const kDataBoundary = @"*****";
static NSString *const kLineEnd      = @"\r\n";
static NSString *const kTwoHyphens   = @"--";

+ (NSString *)createRemoteFileName
{
    NSDateFormatter *const dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd_HHmmss"];
    NSString *const currentDate = [dateFormatter stringFromDate:[[NSDate alloc] init]];

    return [NSString stringWithFormat:@"simlar_%@_%@.log", [SMLRCredentials getSimlarId], currentDate];
}

+ (NSString *)readLogFile
{
    NSString *const filePath = [SMLRLog getLogFilePath];
    SMLRLogI(@"Uploading logfile: %@", filePath);
    return [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:filePath] encoding:NSUTF8StringEncoding];
}

+ (void)uploadWithCompletionHandler:(void (^)(NSString *const logFileName, NSError *const error))handler
{
    SMLRLogFunc;

    NSString *const logFileContent = [self readLogFile];
    if ([logFileContent length] == 0) {
        SMLRLogE(@"Error: no log file content found");
        handler(nil, [NSError errorWithDomain:@"org.simlar.uploadLogFile" code:3 userInfo:@{ NSLocalizedDescriptionKey:@"No log file content found" }]);
        return;
    }

    NSString *const remoteFileName = [self createRemoteFileName];

    NSData *const body = [[NSString stringWithFormat:@"%@%@%@%@%@",
                           [NSString stringWithFormat:@"%@%@%@", kTwoHyphens, kDataBoundary, kLineEnd],
                           [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\";filename=\"%@\"", remoteFileName],
                           [NSString stringWithFormat:@"%@%@", kLineEnd, kLineEnd],
                           [self readLogFile],
                           [NSString stringWithFormat:@"%@%@%@%@%@", kLineEnd, kTwoHyphens, kDataBoundary, kTwoHyphens, kLineEnd]
                         ] dataUsingEncoding:NSUTF8StringEncoding];

    NSString *const contentType = [NSString stringWithFormat:@"multipart/form-data;boundary=%@", kDataBoundary];

    [SMLRHttpsPost postAsynchronousCommand:kCommand contentType:contentType body:body completionHandler:^(NSData *const data, NSError *const connectionError) {
        if (connectionError != nil) {
            SMLRLogW(@"Connection Error while uploading logfile: %@", connectionError);
            handler(nil, connectionError);
            return;
        }

        NSString *const response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![response matchesPattern:@"^OK \\d+$"]) {
            SMLRLogE(@"Error in response of log file upload: %@", response);
            handler(nil, [NSError errorWithDomain:@"org.simlar.uploadLogFile" code:2 userInfo:@{ NSLocalizedDescriptionKey :response }]);
            return;
        }

        SMLRLogI(@"uploaded log file successfully");
        handler(remoteFileName, nil);
    }];
}

@end

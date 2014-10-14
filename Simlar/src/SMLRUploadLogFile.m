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

static NSString *const COMMAND       = @"upload-logfile.php";
static NSString *const DATA_BOUNDARY = @"*****";
static NSString *const LINE_END      = @"\r\n";
static NSString *const TWO_HYPHENS   = @"--";

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

    NSString *const remoteFileName = [self createRemoteFileName];

    NSData *const body = [[NSString stringWithFormat:@"%@%@%@%@%@",
                           [NSString stringWithFormat:@"%@%@%@", TWO_HYPHENS, DATA_BOUNDARY, LINE_END],
                           [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\";filename=\"%@\"", remoteFileName],
                           [NSString stringWithFormat:@"%@%@", LINE_END, LINE_END],
                           [self readLogFile],
                           [NSString stringWithFormat:@"%@%@%@%@%@", LINE_END, TWO_HYPHENS, DATA_BOUNDARY, TWO_HYPHENS, LINE_END]
                         ] dataUsingEncoding:NSUTF8StringEncoding];

    NSString *const contentType = [NSString stringWithFormat:@"multipart/form-data;boundary=%@", DATA_BOUNDARY];

    [SMLRHttpsPost postAsynchronousCommand:COMMAND contentType:contentType body:body completionHandler:^(NSData *const data, NSError *const connectionError) {
        if (connectionError != nil) {
            SMLRLogW(@"Connection Error while uploading logfile: %@", connectionError);
            handler(nil, connectionError);
            return;
        }

        NSString * response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (![response matchesPattern:@"^OK \\d+$"]) {
            SMLRLogE(@"Error in response of log file uplpad: %@", response);
            handler(nil, [NSError errorWithDomain:@"org.simlar.uploadLogFile" code:2 userInfo:@{ NSLocalizedDescriptionKey :response }]);
            return;
        }

        SMLRLogI(@"uploaded log file successfully");
        handler(remoteFileName, nil);
    }];
}

@end

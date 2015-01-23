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

#import "SMLRLogFormatter.h"

@interface SMLRLogFormatter ()

@property (nonatomic, readonly) BOOL showDate;

@end

static const int kFileNameSize = 20;

static const NSUInteger kCalendarUnitFlags = (NSCalendarUnitYear  |
                                               NSCalendarUnitMonth |
                                               NSCalendarUnitDay   |
                                               NSCalendarUnitHour  |
                                               NSCalendarUnitMinute|
                                               NSCalendarUnitSecond);

@implementation SMLRLogFormatter

- (instancetype)init
{
    return [self initWithDateActivated:YES];
}

- (instancetype)initWithoutDate
{
    return [self initWithDateActivated:NO];
}

- (instancetype)initWithDateActivated:(BOOL)showDate
{
    self = [super init];
    if (self == nil) {
        return nil;
    }

    _showDate = showDate;

    return self;
}


+ (NSString *)stringWithTimestamp:(NSDate *const)timestamp
{
    NSDateComponents *const components = [[NSCalendar autoupdatingCurrentCalendar] components:kCalendarUnitFlags fromDate:timestamp];

    const NSTimeInterval epoch = [timestamp timeIntervalSinceReferenceDate];
    const int milliseconds = (int)((epoch - floor(epoch)) * 1000);

    return [NSString stringWithFormat:@"%04ld-%02ld-%02ld %02ld:%02ld:%02ld:%03d",
                                      (long)components.year,
                                      (long)components.month,
                                      (long)components.day,
                                      (long)components.hour,
                                      (long)components.minute,
                                      (long)components.second,
                                      milliseconds];
}

+ (NSString *)stringWithThreadId:(NSString *const)threadId
{
    return [NSString stringWithFormat:@"%i:%04x", (int)getpid(), [threadId intValue]];
}

+ (NSString *)stringWithLength:(NSString *const)string length:(const NSUInteger)length
{
    if ([string length] < length) {
        return [string stringByPaddingToLength:length withString:@" " startingAtIndex:0];
    }

    if ([string length] > length) {
        return [string substringToIndex:length];
    }

    return string;
}

+ (NSString *)stringWithFilename:(NSString *const)fileName lineNumber:(const NSUInteger)lineNumber
{
    NSString *const number   = [NSString stringWithFormat:@"%lu", (unsigned long)lineNumber];
    return [NSString stringWithFormat:@"%@(%@)",
                                      [SMLRLogFormatter stringWithLength:[fileName lastPathComponent] length:kFileNameSize - [number length]],
                                      number];
}

+ (NSString *)stringWithLogFlag:(const DDLogFlag)flag
{
    switch (flag)
    {
        case DDLogFlagError   : return @"E";
        case DDLogFlagWarning : return @"W";
        case DDLogFlagInfo    : return @"I";
        case DDLogFlagDebug   : return @"D";
        case DDLogFlagVerbose : return @"V";
        default               : return @" ";
    }
}

- (NSString *)formatLogMessage:(DDLogMessage *const)logMessage
{
    if (_showDate) {
        return [NSString stringWithFormat:@"%@ %@ %@ %@ %@",
                [SMLRLogFormatter stringWithTimestamp:logMessage.timestamp],
                [SMLRLogFormatter stringWithThreadId:logMessage.threadID],
                [SMLRLogFormatter stringWithFilename:logMessage.file lineNumber:logMessage.line],
                [SMLRLogFormatter stringWithLogFlag:logMessage.flag],
                logMessage.message];
    }

    return [NSString stringWithFormat:@"%@ %@ %@ %@",
            [SMLRLogFormatter stringWithThreadId:logMessage.threadID],
            [SMLRLogFormatter stringWithFilename:logMessage.file lineNumber:logMessage.line],
            [SMLRLogFormatter stringWithLogFlag:logMessage.flag],
            logMessage.message];
}

@end

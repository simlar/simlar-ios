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

static const int FILENAME_SIZE = 20;

static const NSUInteger CALENDAR_UNIT_FLAGS = (NSCalendarUnitYear  |
                                               NSCalendarUnitMonth |
                                               NSCalendarUnitDay   |
                                               NSCalendarUnitHour  |
                                               NSCalendarUnitMinute|
                                               NSCalendarUnitSecond);

@implementation SMLRLogFormatter

+ (NSString *)stringWithTimestamp:(NSDate *const)timestamp
{
    NSDateComponents *const components = [[NSCalendar autoupdatingCurrentCalendar] components:CALENDAR_UNIT_FLAGS fromDate:timestamp];

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

+ (NSString *)stringWithThreadId:(const mach_port_t)threadId
{
    return [NSString stringWithFormat:@"%i:%04x", (int)getpid(), threadId];
}

+ (NSString *)stringWithLength:(NSString *const)string length:(const int)length
{
    if ([string length] < length) {
        return [string stringByPaddingToLength:length withString:@" " startingAtIndex:0];
    }

    if ([string length] > length) {
        return [string substringToIndex:length];
    }

    return string;
}

+ (NSString *)stringWithFilename:(const char *const)charFileName lineNumber:(const int)lineNumber
{
    NSString *const fileName = [@(charFileName) lastPathComponent];
    NSString *const number   = [NSString stringWithFormat:@"%d", lineNumber];
    return [NSString stringWithFormat:@"%@(%@)",
                                      [SMLRLogFormatter stringWithLength:fileName length:FILENAME_SIZE - [number length]],
                                      number];
}

+ (NSString *)stringWithLogFlag:(const int)logFlag
{
    switch (logFlag)
    {
        case LOG_FLAG_ERROR   : return @"E";
        case LOG_FLAG_WARN    : return @"W";
        case LOG_FLAG_INFO    : return @"I";
        case LOG_FLAG_DEBUG   : return @"D";
        case LOG_FLAG_VERBOSE : return @"V";
        default               : return @" ";
    }
}

- (NSString *)formatLogMessage:(DDLogMessage *const)logMessage
{
    return [NSString stringWithFormat:@"%@ %@ %@ %@ %@",
                                      [SMLRLogFormatter stringWithTimestamp:logMessage->timestamp],
                                      [SMLRLogFormatter stringWithThreadId:logMessage->machThreadID],
                                      [SMLRLogFormatter stringWithFilename:logMessage->file lineNumber:logMessage->lineNumber],
                                      [SMLRLogFormatter stringWithLogFlag:logMessage->logFlag],
                                      logMessage->logMsg];
}

@end

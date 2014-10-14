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

#import "SMLRLog.h"

#import "SMLRLogFormatter.h"

#if DEBUG
const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
const int ddLogLevel = LOG_LEVEL_INFO;
#endif

@implementation SMLRLog

+ (void)enableLogging:(BOOL)enabled
{
    if ([self isLogging] == enabled) {
        return;
    }

    if (enabled) {
        [self startLogging];
    } else {
        [self stopLogging];
    }
}

+ (BOOL)isLogging
{
    return [[DDLog allLoggers] count] > 0;
}

+ (void)startLogging
{
    [DDLog addLogger:[DDASLLogger sharedInstance]];
#if DEBUG
    [[DDTTYLogger sharedInstance] setLogFormatter:[[SMLRLogFormatter alloc] init]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
#endif
}

+ (void)stopLogging
{
    [DDLog removeAllLoggers];
}

@end

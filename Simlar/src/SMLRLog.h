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

#ifndef Simlar_SMLRLog_h
#define Simlar_SMLRLog_h

#import <CocoaLumberjack/CocoaLumberjack.h>

extern const int ddLogLevel;

#define SMLRLogV(params...) DDLogVerbose(params);
#define SMLRLogD(params...) DDLogDebug(params);
#define SMLRLogI(params...) DDLogInfo(params);
#define SMLRLogW(params...) DDLogWarn(params);
#define SMLRLogE(params...) DDLogError(params);

#define SMLRLogFunc SMLRLogI(@"%s", __func__);

#define SMLR_LOG_ALWAYS_WITH_TAG(aFlag, aTag, frmt, ...) \
        [DDLog log : LOG_ASYNC_ENABLED                   \
             level : LOG_LEVEL_DEF                       \
              flag : aFlag                               \
           context : 0                                   \
              file : __FILE__                            \
          function : __PRETTY_FUNCTION__                 \
              line : __LINE__                            \
               tag : aTag                                \
            format : (frmt), ## __VA_ARGS__]

#define SMLRLogLevel DDLogFlag
#define SMLRVerbose  DDLogFlagVerbose
#define SMLRDebug    DDLogFlagDebug
#define SMLRInfo     DDLogFlagInfo
#define SMLRWarning  DDLogFlagWarning
#define SMLRError    DDLogFlagError

@interface SMLRLog : NSObject

+ (void)enableLogging:(BOOL)enabled;
+ (NSString *)getLogFilePath;

@end

#endif

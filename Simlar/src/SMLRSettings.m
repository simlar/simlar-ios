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

#import "SMLRSettings.h"

@implementation SMLRSettings

static NSString *const KEY_DEFAULT_REGION        = @"defaultRegion";
static NSString *const KEY_CREATE_ACCOUNT_STATUS = @"createAccountStatus";
static NSString *const KEY_REREGISTER_NEXT_START = @"reregister_next_start_preference";
static NSString *const KEY_LOG_ENABLED           = @"log_enabled_preference";
static NSString *const KEY_REPORT_BUG_NEXT_START = @"report_bug_next_start_preference";


+ (void)saveDefaultRegion:(NSString *const)region
{
    [[NSUserDefaults standardUserDefaults] setValue:region forKey:KEY_DEFAULT_REGION];
}

+ (NSString *)getDefaultRegion
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:KEY_DEFAULT_REGION];
}

+ (void)saveCreateAccountStatus:(const SMLRCreateAccountStatus)status
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults setInteger:status forKey:KEY_CREATE_ACCOUNT_STATUS];

    [defaults synchronize];
}

+ (SMLRCreateAccountStatus)getCreateAccountStatus
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:KEY_CREATE_ACCOUNT_STATUS];
}

+ (BOOL)getReregisterNextStart
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_REREGISTER_NEXT_START];
}

+ (BOOL)getLogEnabled
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_LOG_ENABLED];
}

+ (void)resetReportBugNextStart
{
    [[NSUserDefaults standardUserDefaults] setValue:NO forKey:KEY_REPORT_BUG_NEXT_START];
}

+ (BOOL)getReportBugNextStart
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_REPORT_BUG_NEXT_START];
}


+ (void)reset
{
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
}

@end

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

static NSString *const kKeyDefaultRegion       = @"defaultRegion";
static NSString *const kKeyCreateAccountStatus = @"createAccountStatus";
static NSString *const kKeyReregisterNextStart = @"reregister_next_start_preference";
static NSString *const kKeyLogEnabled          = @"log_enabled_preference";
static NSString *const kKeyReportBugNextStart  = @"report_bug_next_start_preference";


+ (void)saveDefaultRegion:(NSString *const)region
{
    [[NSUserDefaults standardUserDefaults] setValue:region forKey:kKeyDefaultRegion];
}

+ (NSString *)getDefaultRegion
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:kKeyDefaultRegion];
}

+ (void)saveCreateAccountStatus:(const SMLRCreateAccountStatus)status
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults setInteger:status forKey:kKeyCreateAccountStatus];

    [defaults synchronize];
}

+ (SMLRCreateAccountStatus)getCreateAccountStatus
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:kKeyCreateAccountStatus];
}

+ (BOOL)getReregisterNextStart
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kKeyReregisterNextStart];
}

+ (BOOL)getLogEnabled
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kKeyLogEnabled];
}

+ (void)resetReportBugNextStart
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kKeyReportBugNextStart];
}

+ (BOOL)getReportBugNextStart
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kKeyReportBugNextStart];
}


+ (void)reset
{
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
}

@end

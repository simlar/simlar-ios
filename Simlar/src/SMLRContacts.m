/**
 * Copyright (C) 2017 The Simlar Authors.
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

#import "SMLRContacts.h"

@implementation SMLRContacts

- (NSUInteger)getCount
{
    return 0;
}

- (NSUInteger)getGroupsCount
{
    return 0;
}

- (NSString *)getGroupLetter:(const NSInteger)index
{
    return NULL;
}

- (NSUInteger)getGroupCount:(const NSInteger)index
{
    return 0;
}

- (SMLRContact *)getContactWithGroupIndex:(const NSInteger)groupIndex contactIndex:(const NSInteger)contactIndex
{
    return NULL;
}

@end

@implementation SMLRAllContacts

- (SMLRContact *)getContactWithSimlarId:(NSString *const)simlarId
{
    return NULL;
}

- (SMLRContacts *)getSimlarContacts
{
    return NULL;
}

- (NSArray *)getSimlarIds
{
    return NULL;
}

@end

@implementation SMLRMutableAllContacts

- (void)addContact:(SMLRContact *const)contact groupLetter:(const unichar)groupLetter
{
    
}

@end

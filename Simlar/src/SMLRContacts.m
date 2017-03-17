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

#import "SMLRContact.h"
#import "SMLRLog.h"

@interface SMLRContacts ()

@property (nonatomic) NSMutableDictionary *simlarId2Contact;
@property (nonatomic) NSMutableArray      *groupLetters;
@property (nonatomic) NSMutableDictionary *groupedContacts;

@end

@interface SMLRMutableAllContacts ()

- (void)addContact:(SMLRContact *const)contact groupLetterString:(NSString *const)groupLetter;

@end

@implementation SMLRContacts

- (NSUInteger)getCount
{
    NSUInteger count = 0;
    for (NSArray *const contacts in [_groupedContacts allValues]) {
        count += [contacts count];
    }
    return count;
}

- (NSUInteger)getGroupsCount
{
    return [_groupedContacts count];
}

- (NSString *)getGroupLetter:(const NSInteger)index
{
    return _groupLetters[index];
}

- (NSArray *)getGroup:(const NSUInteger)index
{
    return [_groupedContacts valueForKey:[self getGroupLetter:index]];
}

- (NSUInteger)getGroupCount:(const NSInteger)index
{
    return [[self getGroup:index] count];
}

- (SMLRContact *)getContactWithGroupIndex:(const NSInteger)groupIndex contactIndex:(const NSInteger)contactIndex
{
    return [self getGroup:groupIndex][contactIndex];
}

@end

@implementation SMLRAllContacts

- (SMLRContact *)getContactWithSimlarId:(NSString *const)simlarId
{
    return [self.simlarId2Contact valueForKey:simlarId];
}

- (SMLRContacts *)getSimlarContacts
{
    SMLRMutableAllContacts *const simlarContacts = [[SMLRMutableAllContacts alloc] init];

    for (NSString *const groupLetter in self.groupLetters) {
        for (SMLRContact *const contact in [self.groupedContacts valueForKey:groupLetter]) {
            if (contact.registered) {
                [simlarContacts addContact:contact groupLetterString:groupLetter];
            }
        }
    }

    return simlarContacts;
}

- (NSArray *)getSimlarIds
{
    return [self.simlarId2Contact allKeys];
}

@end

@implementation SMLRMutableAllContacts

- (instancetype)init
{
    self = [super init];
    if (self == nil) {
        SMLRLogE(@"unable to create SMLRMutableAllContacts");
        return nil;
    }

    self.simlarId2Contact = [NSMutableDictionary dictionary];
    self.groupLetters = [NSMutableArray array];
    self.groupedContacts = [NSMutableDictionary dictionary];

    return self;
}

- (void)addContact:(SMLRContact *const)contact groupLetter:(const unichar)groupLetter
{
    [self addContact:contact groupLetterString:[NSString stringWithCharacters:&groupLetter length:1]];
}

- (void)addContact:(SMLRContact *const)contact groupLetterString:(NSString *const)groupLetter
{
    [self.simlarId2Contact setValue:contact
                             forKey:contact.simlarId];

    if ([self.groupedContacts valueForKeyPath:groupLetter] == NULL) {
        [self.groupLetters addObject:groupLetter];
        [self.groupedContacts setValue:[NSMutableArray array]
                                forKey:groupLetter];
    }

    [[self.groupedContacts valueForKeyPath:groupLetter] addObject:contact];
}

@end

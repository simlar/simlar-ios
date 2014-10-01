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

#import "SMLRContact.h"

#import "SMLRLog.h"

@implementation SMLRContact

- (instancetype)initWithSimlarId:(NSString *const)simlarId guiTelephoneNumber:(NSString *const)guiTelephoneNumber name:(NSString *const)name
{
    self = [super init];
    if (self) {
        if ([simlarId length] == 0) {
            SMLRLogE(@"Error contact with no simlarId");
        }
        self->_simlarId           = simlarId;
        self->_guiTelephoneNumber = [guiTelephoneNumber length] > 0 ? guiTelephoneNumber : simlarId;
        self->_name               = [name length] > 0 ? name : self.guiTelephoneNumber;
        self->_registered         = NO;
    }
    return self;
}

- (NSComparisonResult)compareByName:(SMLRContact *const)other
{
    return [self.name caseInsensitiveCompare:other.name];
}

- (NSString *)toString
{
    return [NSString stringWithFormat:@"name='%@' simlarId='%@' number='%@'", self.name, self.simlarId, self.guiTelephoneNumber];
}

- (unichar)getGroupLetter
{
    return [[self.name uppercaseString] characterAtIndex:0];
}

@end

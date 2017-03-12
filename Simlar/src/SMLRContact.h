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

#import <Foundation/Foundation.h>

@class CNContact;

@interface SMLRContact : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *guiTelephoneNumber;
@property (nonatomic, readonly) NSString *simlarId;
@property (nonatomic) BOOL registered;

- (instancetype)initWithSimlarId:(NSString *const)simlarId guiTelephoneNumber:(NSString *const)guiTelephoneNumber name:(NSString *const)name;
- (instancetype)initWithSimlarId:(NSString *const)simlarId;
- (instancetype)initWithDictionary:(NSDictionary *const)dictonary;
- (instancetype)initWithContact:(CNContact *const)contact phoneNumber:(NSString *const)phoneNumber;

- (NSString *)toString;
- (NSDictionary *)toDictonary;

@end

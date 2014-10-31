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

@protocol SMLRPhoneManagerDelegate;
@protocol SMLRPhoneManagerRootViewControllerDelegate;

@class SMLRCallStatus;
enum SMLRNetworkQuality : NSUInteger;

@interface SMLRPhoneManager : NSObject

- (void)setDelegate:(id<SMLRPhoneManagerDelegate>)delegate;
- (void)setDelegateRootViewController:(id<SMLRPhoneManagerRootViewControllerDelegate>)delegateRootViewController;

- (void)checkForIncomingCall;
- (void)callWithSimlarId:(NSString *const)simlarId;

- (void)terminateAllCalls;
- (void)acceptCall;
- (void)saveSasVerified;

- (SMLRCallStatus *)getCallStatus;
- (NSString *)getCurrentCallSimlarId;
- (BOOL)hasIncomingCall;
- (enum SMLRNetworkQuality)getCallNetworkQuality;

@end

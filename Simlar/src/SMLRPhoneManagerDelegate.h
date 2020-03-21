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

@class SMLRCallStatus;
enum SMLRNetworkQuality : NSUInteger;
enum SMLRMicrophoneStatus : NSUInteger;
enum SMLRAudioOutputType : NSUInteger;

@protocol SMLRPhoneManagerDelegate <NSObject>

- (void)onCallStatusChanged:(SMLRCallStatus *const)callStatus;
- (void)onCallEncrypted:(NSString *const)sas sasVerified:(const BOOL)sasVerified;
- (void)onCallNetworkQualityChanged:(const enum SMLRNetworkQuality)quality;
- (void)onMicrophoneStatusChanged:(const enum SMLRMicrophoneStatus)status;
- (void)onAudioOutputTypeChanged:(const enum SMLRAudioOutputType)type;

@end


@protocol SMLRPhoneManagerCallStatusDelegate <NSObject>

- (void)onCallStatusChanged:(SMLRCallStatus *const)callStatus;

@end


@protocol SMLRPhoneManagerRootViewControllerDelegate <NSObject>

- (void)onIncomingCall;
- (void)onCallEnded:(NSString *const)missedCaller;

@end

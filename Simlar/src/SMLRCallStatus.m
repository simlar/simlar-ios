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

#import "SMLRCallStatus.h"

#import "SMLRLog.h"

@implementation SMLRCallStatus

- (instancetype)initWithStatus:(const SMLRCallStatusEnum)status
{
    if (status == SMLRCallStatusEnded) {
        SMLRLogE(@"Error: use initWithEndReason");
        return nil;
    }

    return [self initWithStatus:status
                      endReason:nil
                   wantsDismiss:NO];
}

- (instancetype)initWithEndReason:(NSString *const)reason wantsDismiss:(const BOOL)wantsDismiss
{
    return [self initWithStatus:SMLRCallStatusEnded
                      endReason:reason
                   wantsDismiss:wantsDismiss];
}

- (instancetype)initWithStatus:(const SMLRCallStatusEnum)status endReason:(NSString *const)reason wantsDismiss:(const BOOL)wantsDismiss
{
    self = [super init];
    if (self == nil) {
        SMLRLogE(@"unable to create SMLRCallStatus");
        return nil;
    }

    _enumValue    = status;
    _endReason    = reason;
    _wantsDismiss = wantsDismiss;

    return self;
}

- (BOOL)isEqualToCallStatus:(SMLRCallStatus *const)callStatus
{
    return _enumValue == callStatus.enumValue &&
           _wantsDismiss == callStatus.wantsDismiss &&
           ((_endReason == nil && callStatus.endReason == nil) || [_endReason isEqualToString:callStatus.endReason]);
}

- (NSString *)description
{
    switch (_enumValue) {
        case SMLRCallStatusNone:               return @"NONE";
        case SMLRCallStatusConnectingToServer: return @"CONNECTING_TO_SERVER";
        case SMLRCallStatusWaitingForContact:  return @"WAITING_FOR_CONTACT";
        case SMLRCallStatusRemoteRinging:      return @"REMOTE RINGING";
        case SMLRCallStatusIncomingCall:       return @"INCOMING CALL";
        case SMLRCallStatusEncrypting:         return @"ENCRYPTING";
        case SMLRCallStatusTalking:            return @"TALKING";
        case SMLRCallStatusEnded:              return @"ENDED";
    }
}

- (NSString *)guiText
{
    switch (_enumValue) {
        case SMLRCallStatusNone:               return @"";
        case SMLRCallStatusConnectingToServer: return @"Connecting to server...";
        case SMLRCallStatusWaitingForContact:  return @"Waiting for contact...";
        case SMLRCallStatusRemoteRinging:      return @"Ringing...";
        case SMLRCallStatusIncomingCall:       return @"is calling you...";
        case SMLRCallStatusEncrypting:         return @"Encrypting...";
        case SMLRCallStatusTalking:            return @"Talking...";
        case SMLRCallStatusEnded:              return @"Call ended";
    }
}

@end

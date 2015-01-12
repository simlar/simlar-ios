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

#import "SMLRPhoneManager.h"

#import "SMLRCallStatus.h"
#import "SMLRLinphoneHandler.h"
#import "SMLRLog.h"
#import "SMLRPhoneManagerDelegate.h"

@interface SMLRPhoneManager () <SMLRLinphoneHandlerDelegate>

@property (weak, nonatomic) id<SMLRPhoneManagerRootViewControllerDelegate> rootViewControllerDelegate;
@property (nonatomic) SMLRLinphoneHandler *linphoneHandler;
@property (nonatomic) NSString *calleeSimlarId;
@property (nonatomic) BOOL initializeAgain;

@end

@implementation SMLRPhoneManager

- (void)setDelegate:(id<SMLRPhoneManagerDelegate>)delegate
{
    _linphoneHandler.phoneManagerDelegate = delegate;
}

- (void)setDelegateRootViewController:(id<SMLRPhoneManagerRootViewControllerDelegate>)delegateRootViewController
{
    self.rootViewControllerDelegate = delegateRootViewController;
}

- (void)checkForIncomingCall
{
    const SMLRLinphoneHandlerStatus status = [_linphoneHandler getLinphoneHandlerStatus];
    SMLRLogI(@"checkForIncomingCall with status=%@", nameForSMLRLinphoneHandlerStatus(status));
    switch (status) {
        case SMLRLinphoneHandlerStatusDestroyed:
        case SMLRLinphoneHandlerStatusNone:
            [self initLibLinphone];
            break;
        case SMLRLinphoneHandlerStatusGoingDown:
            self.initializeAgain = YES;
            break;
        case SMLRLinphoneHandlerStatusInitializing:
            break;
        case SMLRLinphoneHandlerStatusFailedToConnectToSipServer:
            break;
        case SMLRLinphoneHandlerStatusConnectedToSipServer:
            if ([_linphoneHandler hasIncomingCall]) {
                [self onIncomingCall];
            }
            break;
    }
}

- (void)initLibLinphone
{
    if (_linphoneHandler) {
        SMLRLogI(@"WARNING liblinphone already initialized");
        return;
    }

    SMLRLogI(@"initializing liblinphone");
    self.linphoneHandler = [[SMLRLinphoneHandler alloc] init];
    _linphoneHandler.delegate = self;
    [_linphoneHandler initLibLinphone];
    SMLRLogI(@"initialized liblinphone");
}

- (void)terminateAllCalls
{
    [_linphoneHandler terminateAllCalls];
}

- (void)acceptCall
{
    [_linphoneHandler acceptCall];
}

- (void)saveSasVerified
{
    [_linphoneHandler saveSasVerified];
}

- (void)callWithSimlarId:(NSString *const)simlarId
{
    switch ([self.linphoneHandler getLinphoneHandlerStatus]) {
        case SMLRLinphoneHandlerStatusDestroyed:
        case SMLRLinphoneHandlerStatusNone:
            self.calleeSimlarId = simlarId;
            [self initLibLinphone];
            break;
        case SMLRLinphoneHandlerStatusGoingDown:
        case SMLRLinphoneHandlerStatusInitializing:
            self.calleeSimlarId = simlarId;
            break;
        case SMLRLinphoneHandlerStatusFailedToConnectToSipServer:
            break;
        case SMLRLinphoneHandlerStatusConnectedToSipServer:
            self.calleeSimlarId = nil;
            if (![_linphoneHandler hasIncomingCall]) {
                [_linphoneHandler call:simlarId];
            } else {
                SMLRLogI(@"Skip calling %@ because of incoming call", simlarId);
                /// TODO think about
                //[self showIncomingCall];
            }
            break;
    }
}

- (void)onLinphoneHandlerStatusChanged:(SMLRLinphoneHandlerStatus)status
{
    SMLRLogI(@"onLinphoneHandlerStatusChanged: %@", nameForSMLRLinphoneHandlerStatus(status));

    if ([_calleeSimlarId length] > 0 || _initializeAgain) {
        switch (status) {
            case SMLRLinphoneHandlerStatusNone:
                SMLRLogI(@"ERROR onLinphoneHandlerStatusChanged: None");
                break;
            case SMLRLinphoneHandlerStatusGoingDown:
            case SMLRLinphoneHandlerStatusInitializing:
                break;
            case SMLRLinphoneHandlerStatusDestroyed:
                self.linphoneHandler = nil;
                [self initLibLinphone];
                break;
            case SMLRLinphoneHandlerStatusFailedToConnectToSipServer:
                self.calleeSimlarId = nil;
                self.initializeAgain = NO;
                break;
            case SMLRLinphoneHandlerStatusConnectedToSipServer:
            {
                self.initializeAgain = NO;
                if ([_calleeSimlarId length] > 0) {
                    NSString *const simlarId = _calleeSimlarId;
                    self.calleeSimlarId = nil;
                    [_linphoneHandler call:simlarId];
                }
                break;
            }
        }
    } else {
        switch (status) {
            case SMLRLinphoneHandlerStatusNone:
                SMLRLogI(@"ERROR onLinphoneHandlerStatusChanged: None");
                break;
            case SMLRLinphoneHandlerStatusGoingDown:
            case SMLRLinphoneHandlerStatusInitializing:
            case SMLRLinphoneHandlerStatusConnectedToSipServer:
            case SMLRLinphoneHandlerStatusFailedToConnectToSipServer:
                break;
            case SMLRLinphoneHandlerStatusDestroyed:
                self.linphoneHandler = nil;
                break;
        }
    }
}

- (void)onIncomingCall
{
    SMLRLogI(@"incoming call");

    if (!_rootViewControllerDelegate) {
        SMLRLogE(@"Error: incoming call but no root view controller delegate");
        return;
    }

    [_rootViewControllerDelegate onIncomingCall];
}

- (void)onCallEnded:(NSString *const)missedCaller
{
    SMLRLogFunc;

    if (!self.rootViewControllerDelegate) {
        SMLRLogE(@"Error: call ended but no root view controller delegate");
        return;
    }

    [_rootViewControllerDelegate onCallEnded:missedCaller];
}

- (SMLRCallStatus *)getCallStatus
{
    return [_linphoneHandler getCallStatus];
}

- (NSDate *)getCallStatusChangedDate
{
    return [_linphoneHandler getCallStatusChangedDate];
}

- (NSString *)getCurrentCallSimlarId
{
    return [_linphoneHandler getCurrentCallRemoteUser];
}

- (BOOL)hasIncomingCall
{
    return [_linphoneHandler hasIncomingCall];
}

- (enum SMLRNetworkQuality)getCallNetworkQuality
{
    return [_linphoneHandler getCallNetworkQuality];
}

@end

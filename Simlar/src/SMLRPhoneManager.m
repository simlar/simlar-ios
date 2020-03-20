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

#import <CallKit/CallKit.h>

@interface SMLRPhoneManager () <SMLRLinphoneHandlerDelegate>

@property (weak, nonatomic) id<SMLRPhoneManagerRootViewControllerDelegate> rootViewControllerDelegate;
@property (weak, nonatomic) id<SMLRPhoneManagerDelegate> phoneManagerDelegate;
@property (nonatomic) SMLRLinphoneHandler *linphoneHandler;
@property (nonatomic) NSString *calleeSimlarId;
@property (nonatomic) BOOL initializeAgain;
@property (nonatomic) CXCallController *callController;
@property (nonatomic) NSUUID *callUuid;

@end

@implementation SMLRPhoneManager

- (instancetype)init
{
    SMLRLogFunc;
    self = [super init];
    if (self == nil) {
        SMLRLogE(@"unable to create SMLRPhoneManager");
        return nil;
    }

    _callController = [[CXCallController alloc] initWithQueue:dispatch_get_main_queue()];

    return self;
}

- (void)setDelegate:(id<SMLRPhoneManagerDelegate>)delegate
{
    if (_linphoneHandler == nil) {
        self.phoneManagerDelegate = delegate;
    } else {
        _linphoneHandler.phoneManagerDelegate = delegate;
    }
}

- (void)setCallStatusDelegate:(id<SMLRPhoneManagerCallStatusDelegate>)callStatusDelegate
{
    _linphoneHandler.phoneManagerCallStatusDelegate = callStatusDelegate;
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
        SMLRLogW(@"liblinphone already initialized");
        return;
    }

    SMLRLogI(@"initializing liblinphone");
    self.linphoneHandler = [[SMLRLinphoneHandler alloc] init];

    _linphoneHandler.delegate = self;
    if (_phoneManagerDelegate != nil) {
        _linphoneHandler.phoneManagerDelegate = _phoneManagerDelegate;
        self.phoneManagerDelegate = nil;
    }

    [_linphoneHandler initLibLinphone];
    SMLRLogI(@"initialized liblinphone");
}

- (void)setCallWithUuid:(NSUUID *const)uuid pause:(const BOOL)pause
{
    if (pause) {
        [_linphoneHandler setCurrentCallPause:YES];
    } else {
        if (uuid != nil && [uuid isEqual:_callUuid]) {
            [_linphoneHandler setCurrentCallPause:NO];
        }
    }
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

- (void)toggleMicrophoneMuted
{
    [_linphoneHandler toggleMicrophoneMuted];
}

+ (void)toggleExternalSpeaker
{
    [SMLRLinphoneHandler toggleExternalSpeaker];
}

- (NSUUID *)newCallUuid
{
    if (_callUuid != nil) {
        SMLRLogW(@"already set callUuid=%@", _callUuid);
    }

    _callUuid = [NSUUID UUID];

    return _callUuid;
}

- (NSUUID *)getCallUuid
{
    return _callUuid;
}

- (void)endCallkitCall
{
    SMLRLogFunc;

    CXEndCallAction *const action = [[CXEndCallAction alloc] initWithCallUUID:_callUuid];
    CXTransaction *const transaction = [[CXTransaction alloc] initWithAction:action];

    [_callController requestTransaction:transaction completion:^(NSError *const _Nullable error) {
        if (error != nil) {
            SMLRLogE(@"requesting call transaction failed: %@", error);
        } else {
            SMLRLogI(@"requesting call transaction success");
        }
    }];
}

- (void)requestCallWithSimlarId:(NSString *const)simlarId guiTelephoneNumber:(NSString *const)guiTelephoneNumber completion:(void (^)(NSError *error))completion
{
    [self newCallUuid];

    CXHandle *const handle = [[CXHandle alloc] initWithType:CXHandleTypeGeneric value:guiTelephoneNumber];
    CXStartCallAction *const action = [[CXStartCallAction alloc] initWithCallUUID:_callUuid handle:handle];
    action.contactIdentifier = simlarId;
    CXTransaction *const transaction = [[CXTransaction alloc] initWithAction:action];

    [_callController requestTransaction:transaction completion:^(NSError *const _Nullable error) {
        completion(error);
    }];
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
                SMLRLogE(@"onLinphoneHandlerStatusChanged: None");
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
                SMLRLogE(@"onLinphoneHandlerStatusChanged: None");
                break;
            case SMLRLinphoneHandlerStatusGoingDown:
            case SMLRLinphoneHandlerStatusInitializing:
            case SMLRLinphoneHandlerStatusConnectedToSipServer:
            case SMLRLinphoneHandlerStatusFailedToConnectToSipServer:
                break;
            case SMLRLinphoneHandlerStatusDestroyed:
                self.linphoneHandler = nil;
                [self endCallkitCall];
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

    if (!_rootViewControllerDelegate) {
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

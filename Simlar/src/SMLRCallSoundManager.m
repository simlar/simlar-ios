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

#import "SMLRCallSoundManager.h"

#import "SMLRCallStatus.h"
#import "SMLRLog.h"

#import <AVFoundation/AVFoundation.h>

@interface SMLRCallSoundManager ()

@property (nonatomic) AVAudioPlayer *player;

@end


@implementation SMLRCallSoundManager

- (void)onCallStatusChanged:(SMLRCallStatus *const)callStatus
{
    [self stopPlaying];

    switch (callStatus.enumValue) {
        case SMLRCallStatusNone: break;
        case SMLRCallStatusConnectingToServer: break;
        case SMLRCallStatusWaitingForContact:
            [self playFile:@"waiting_for_contact.wav"];
            break;
        case SMLRCallStatusRemoteRinging: break;
        case SMLRCallStatusIncomingCall:
            if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
                [self playFile:@"ringtone.wav"];
            }
            break;
        case SMLRCallStatusEncrypting:
            [self playFile:@"encryption_handshake.wav"];
            break;
        case SMLRCallStatusTalking: break;
        case SMLRCallStatusEnded: break;
    }
}

- (void)stopPlaying
{
    if (_player && [_player isPlaying]) {
        SMLRLogI(@"stop playing sound");
        [_player stop];
        self.player = nil;
    }
}

- (void)playFile:(NSString *const)file
{
    SMLRLogI(@"start playing sound: %@", file);
    NSURL *const url = [[NSBundle mainBundle] URLForResource:file withExtension:nil];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    if (_player == nil) {
        SMLRLogE(@"unable to create audio player with file: %@", file);
        return;
    }
    [_player setNumberOfLoops:-1]; // infinite repeat
    [_player play];
}

@end

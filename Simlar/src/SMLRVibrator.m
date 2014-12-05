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

#import "SMLRVibrator.h"

#import "SMLRLog.h"

#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>

@interface SMLRVibrator ()

@property (nonatomic) NSTimer *timer;
@property (nonatomic) AVAudioSessionCategoryOptions audioOptions;

@end


@implementation SMLRVibrator

static const NSTimeInterval kVibrationInterval = 1.0;

- (void)start
{
    SMLRLogFunc;

    if (_timer != nil) {
        SMLRLogE(@"ERROR: vibrator already vibrating");
        return;
    }

    /// make sure we are able to vibrate while recording
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    self.audioOptions = [[AVAudioSession sharedInstance] categoryOptions];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback
                                     withOptions:_audioOptions | AVAudioSessionCategoryOptionMixWithOthers
                                           error:nil];

    [self vibrate];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:kVibrationInterval
                                                  target:self
                                                selector:@selector(vibrate)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)stop
{
    SMLRLogFunc;

    if (_timer == nil) {
        SMLRLogI(@"vibrator not running");
        return;
    }

    [_timer invalidate];
    self.timer = nil;

    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback
                                     withOptions:_audioOptions
                                           error:nil];
}

- (void)vibrate
{
    SMLRLogFunc;
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end

/**
 * Copyright (C) 2016 The Simlar Authors.
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

#import <AudioToolbox/AudioToolbox.h>

@interface SMLRVibrator ()

@property (nonatomic) NSTimer *timer;

@end

@implementation SMLRVibrator

static const NSTimeInterval kDisconnectCheckerInterval = 2.0;

- (void)vibrate
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void)start
{
    if (_timer) {
        SMLRLogI(@"vibrator already running");
        return;
    }

    self.timer = [NSTimer scheduledTimerWithTimeInterval:kDisconnectCheckerInterval
                                                              target:self
                                                            selector:@selector(vibrate)
                                                            userInfo:nil
                                                             repeats:YES];
}

- (void)stop
{
    if (!_timer) {
        SMLRLogI(@"vibrator timer not running");
        return;
    }

    [_timer invalidate];
    self.timer = nil;
}

@end

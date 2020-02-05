//
//  Vibrate.c
//  PodzTest
//
//  Created by Jerson Perpetua on 2020-01-14.
//  Copyright © 2020 Crunchfish. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>

#import "Vibrate.h"

void AudioServicesPlaySystemSoundWithVibration(SystemSoundID inSystemSoundID,
                                               _Nullable id arg,
                                               NSDictionary<NSString *, id> * _Nonnull vibratePattern);

void vibrate(NSTimeInterval duration) {
  AudioServicesPlaySystemSoundWithVibration(
    kSystemSoundID_Vibrate,
    nil,
    @{@"VibePattern": @[@YES, @(duration * 1000)], @"Intensity": @1.0}
  );
}

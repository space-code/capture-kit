//
//  NVCaptureConfiguration.m
//  CaptureKit
//
//  Created by Никита Васильев on 09.10.2023.
//  Copyright © 2023 space-code. All rights reserved.
//

#import "NVCaptureConfiguration.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@implementation NVCaptureConfiguration

#pragma mark - Initialization

- (nullable instancetype)initWithFPS:(NSUInteger)fps
                     isCursorVisible:(BOOL)isCursorVisible
                 isCaptureMouseClick:(BOOL)isCaptureMouseClick
                      captureQuality:(NVCaptureQuality)captureQuality {
  self = [super init];

  if (self) {
    _fps = fps;
    _capturesCursor = isCursorVisible;
    _capturesMouseClicks = isCaptureMouseClick;
    _captureQuality = captureQuality;
  }

  return self;
}

#pragma mark - Class Methods

+ (NVCaptureConfiguration *)default {
  return [[NVCaptureConfiguration alloc] initWithFPS:60
                                     isCursorVisible:YES
                                 isCaptureMouseClick:NO
                                      captureQuality:High];
}

@end

NS_ASSUME_NONNULL_END

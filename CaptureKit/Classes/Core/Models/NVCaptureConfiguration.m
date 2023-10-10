//
// CaptureKit
// Copyright © 2023 Space Code. All rights reserved.
//

#import "NVCaptureConfiguration.h"
#import <Foundation/Foundation.h>

@implementation NVCaptureConfiguration

#pragma mark - Initialization

- (instancetype)init {
  return nil;
}

- (nullable instancetype)initWithFPS:(NSUInteger)fps
                      capturesCursor:(BOOL)capturesCursor
                 capturesMouseClicks:(BOOL)capturesMouseClicks
                      captureQuality:(NVCaptureQuality)captureQuality {
  self = [super init];

  if (self) {
    _fps = fps;
    _capturesCursor = capturesCursor;
    _capturesMouseClicks = capturesMouseClicks;
    _captureQuality = captureQuality;
  }

  return self;
}

#pragma mark - Class Methods

+ (NVCaptureConfiguration *)default {
  return [[NVCaptureConfiguration alloc] initWithFPS:60
                                      capturesCursor:YES
                                 capturesMouseClicks:NO
                                      captureQuality:High];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  return self;
}

@end

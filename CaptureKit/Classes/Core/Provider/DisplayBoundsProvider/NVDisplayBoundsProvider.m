//
//  NVDisplayBoundsProvider.m
//  CaptureKit
//
//  Created by Никита Васильев on 10.10.2023.
//  Copyright © 2023 space-code. All rights reserved.
//

#import "NVDisplayBoundsProvider.h"

@implementation NVDisplayBoundsProvider

+ (nullable instancetype)sharedInstance {
  static dispatch_once_t onceToken = 0;

  __strong static id _sharedObject = nil;

  dispatch_once(&onceToken, ^{
    _sharedObject = [[self alloc] init];
  });

  return _sharedObject;
}

- (CGRect)boundsForDisplayWithID:(CGDirectDisplayID)displayID {
  CGRect rect = CGDisplayBounds(displayID);
  return rect;
}

@end

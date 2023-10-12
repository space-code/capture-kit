//
// CaptureKit
// Copyright © 2023 Space Code. All rights reserved.
//

#import "NVMediaDeviceProvider.h"

#import "NVIMediaProvider.h"

@interface NVMediaDeviceProvider ()

@end

@implementation NVMediaDeviceProvider

- (NSArray<AVCaptureDevice *> *)devicesWithMediaType:(AVMediaType)type {
  return [AVCaptureDevice devicesWithMediaType:type];
}

@end

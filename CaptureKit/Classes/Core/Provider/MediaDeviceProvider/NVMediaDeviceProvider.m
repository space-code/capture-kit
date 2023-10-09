//
// CaptureKit
// Copyright © 2023 Space Code. All rights reserved.
//

#import "NVMediaDeviceProvider.h"

#import "NVIMediaProvider.h"

@interface NVMediaDeviceProvider ()

@property(nonatomic, strong) AVCaptureDevice *captureDevice;

@end

@implementation NVMediaDeviceProvider

- (id)initWithCaptureDevice:(AVCaptureDevice *)device {
  if (self = [super init]) {
    self.captureDevice = device;
  }
  return self;
}

- (NSArray<AVCaptureDevice *> *)devicesWithMediaType:(AVMediaType)type {
  return [AVCaptureDevice devicesWithMediaType:type];
}

@end

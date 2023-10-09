//
// CaptureKit
// Copyright © 2023 Space Code. All rights reserved.
//

#import "NVAudioService.h"

@interface NVAudioService ()

@property(nonatomic, strong) id<NVIMediaProvider> mediaDeviceProvider;

@end

@implementation NVAudioService

- (id)initWithMediaDeviceProvider:(id<NVIMediaProvider>)mediaDeviceProvider {
  if (self = [super init]) {
    self.mediaDeviceProvider = mediaDeviceProvider;
  }
  return self;
}

- (NSArray *)getAudioDevicesIDs:(NSArray<AVCaptureDevice *> *)devices {
  if (devices == nil || devices.count == 0) {
    return nil;
  }

  NSInteger numberOfDevices = devices.count;
  NSMutableArray *devicesIDs = [[NSMutableArray alloc] init];

  for (int i = 0; i < numberOfDevices; ++i) {
    devicesIDs[i] = devices[i].uniqueID;
  }

  return devicesIDs;
}

- (BOOL)isAudioDeviceConnected:(NSString *)uniqueID {
  NSArray<AVCaptureDevice *> *audioDevices =
      [self.mediaDeviceProvider devicesWithMediaType:AVMediaTypeAudio];
  NSArray *devicesIDs = [self getAudioDevicesIDs:audioDevices];

  return [devicesIDs containsObject:uniqueID];
}

@end

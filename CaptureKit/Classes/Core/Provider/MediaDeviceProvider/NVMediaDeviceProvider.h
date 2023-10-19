//
// CaptureKit
// Copyright © 2023 Space Code. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

#import "NVIMediaProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVMediaDeviceProvider : NSObject <NVIMediaProvider>

/// Retrieves an array of media devices of the specified media type.
///
/// @param type The media type for which you want to retrieve devices. Use constants like
/// `AVMediaTypeAudio` or `AVMediaTypeVideo` to specify the type.
/// @return An array of AVCaptureDevice instances representing the available media devices of the
/// specified type.
- (NSArray<AVCaptureDevice *> *)devicesWithMediaType:(AVMediaType)type;

@end

NS_ASSUME_NONNULL_END

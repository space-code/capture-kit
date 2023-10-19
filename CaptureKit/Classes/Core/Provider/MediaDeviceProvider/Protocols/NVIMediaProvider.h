//
// CaptureKit
// Copyright © 2023 Space Code. All rights reserved.
//

#ifndef NVIMediaProvider_h
#define NVIMediaProvider_h

#import <AVFoundation/AVFoundation.h>

/// The `NVIMediaProvider` protocol defines methods for retrieving media-related information and
/// devices.
///
/// The conforming classes should implement the methods defined in this protocol to provide access
/// to media devices and related functionalities.
///
/// @note This protocol assumes that the conforming classes will provide non-null values for the
/// return type and that the `type` parameter should be valid.
@protocol NVIMediaProvider <NSObject>

/// Retrieves an array of media devices of the specified media type.
///
/// @param type The media type for which you want to retrieve devices. Use constants like
/// `AVMediaTypeAudio` or `AVMediaTypeVideo` to specify the type.
/// @return An array of AVCaptureDevice instances representing the available media devices of the
/// specified type.
- (NSArray<AVCaptureDevice *> *)devicesWithMediaType:(AVMediaType)type;

@end

#endif /* NVIMediaProvider_h */

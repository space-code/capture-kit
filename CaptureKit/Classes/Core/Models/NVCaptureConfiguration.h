//
// CaptureKit
// Copyright © 2023 Space Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVCaptureQuality.h"

NS_ASSUME_NONNULL_BEGIN

/// NVCaptureConfiguration is a class that represents a configuration for capturing video.
@interface NVCaptureConfiguration : NSObject <NSCopying>
/// This initializer is unavailable and should not be used.
- (instancetype)init NS_UNAVAILABLE;

/// Creates an `NVCaptureConfiguration` object with specified settings.
///
/// - Parameters:
///   - fps: The frames per second (FPS) for video capture.
///   - capturesCursor: A Boolean indicating whether the cursor should be captured in the video.
///   - capturesMouseClicks: A Boolean indicating whether mouse clicks should be captured.
///   - captureQuality: The quality setting for video capture.
- (nullable instancetype)initWithFPS:(NSUInteger)fps
                      capturesCursor:(BOOL)capturesCursor
                 capturesMouseClicks:(BOOL)capturesMouseClicks
                      captureQuality:(NVCaptureQuality)captureQuality;

/// The frames per second (FPS) for video capture.
@property(nonatomic, readonly, assign) NSUInteger fps;
/// A Boolean indicating whether the cursor should be captured in the video.
@property(nonatomic, readonly, assign) BOOL capturesCursor;
/// A Boolean indicating whether mouse clicks should be captured.
@property(nonatomic, readonly, assign) BOOL capturesMouseClicks;
/// The quality setting for video capture.
@property(nonatomic, readonly, assign) NVCaptureQuality captureQuality;

/// An NVCaptureConfiguration object with default settings.
+ (NVCaptureConfiguration *)default;

@end

NS_ASSUME_NONNULL_END

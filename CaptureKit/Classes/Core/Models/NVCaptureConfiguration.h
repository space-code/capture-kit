//
// CaptureKit
// Copyright © 2023 Space Code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVCaptureQuality.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVCaptureConfiguration : NSObject <NSCopying>
- (instancetype)init NS_UNAVAILABLE;

- (nullable instancetype)initWithFPS:(NSUInteger)fps
                      capturesCursor:(BOOL)capturesCursor
                 capturesMouseClicks:(BOOL)capturesMouseClicks
                      captureQuality:(NVCaptureQuality)captureQuality;

@property(nonatomic, readonly, assign) NSUInteger fps;
@property(nonatomic, readonly, assign) BOOL capturesCursor;
@property(nonatomic, readonly, assign) BOOL capturesMouseClicks;
@property(nonatomic, readonly, assign) NVCaptureQuality captureQuality;

+ (NVCaptureConfiguration *)default;

@end

NS_ASSUME_NONNULL_END

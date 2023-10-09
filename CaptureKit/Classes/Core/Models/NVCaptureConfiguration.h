//
//  NVCaptureConfiguration.h
//  CaptureKit
//
//  Created by Никита Васильев on 09.10.2023.
//  Copyright © 2023 space-code. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVCaptureQuality.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVCaptureConfiguration : NSObject <NSCopying>
- (instancetype)init NS_UNAVAILABLE;

- (nullable instancetype)initWithFPS:(NSUInteger)fps
                     isCursorVisible:(BOOL)isCursorVisible
                 isCaptureMouseClick:(BOOL)isCaptureMouseClick
                      captureQuality:(NVCaptureQuality)captureQuality;

@property(nonatomic, readonly, assign) NSUInteger fps;
@property(nonatomic, readonly, assign) BOOL capturesCursor;
@property(nonatomic, readonly, assign) BOOL capturesMouseClicks;
@property(nonatomic, readonly, assign) NVCaptureQuality captureQuality;

+ (NVCaptureConfiguration *)default;

@end

NS_ASSUME_NONNULL_END

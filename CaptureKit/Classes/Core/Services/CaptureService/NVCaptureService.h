//
//  NVCaptureService.h
//  CaptureKit
//
//  Created by Никита Васильев on 09.10.2023.
//  Copyright © 2023 space-code. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

#import "NVCaptureConfiguration.h"
#import "NVCaptureServiceDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface NVCaptureService : NSObject <AVCaptureFileOutputRecordingDelegate>

@property(nonatomic, weak) id<NVCaptureServiceDelegate> delegate;

@property(nonatomic, strong, readonly) AVCaptureSession *captureSession;
@property(nonatomic, strong, readonly) AVCaptureMovieFileOutput *fileOutput;

- (void)startRecordingWithAudioDeviceID:(NSString *)uniqueID
                                   rect:(CGRect)rect
                        directDisplayID:(CGDirectDisplayID)displayID
                          outputFileURL:(NSURL *)outputFileURL;

- (void)startRecordingWithConfiguration:(NVCaptureConfiguration *)configuration
                               deviceID:(NSString *)uniqueID
                                   rect:(CGRect)rect
                        directDisplayID:(CGDirectDisplayID)displayID
                          outputFileURL:(NSURL *)outputFileURL;

- (void)stop;
- (void)pause;
- (void)resume;

@end

NS_ASSUME_NONNULL_END

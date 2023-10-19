//
// CaptureKit
// Copyright © 2023 Space Code. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

#import "NVCaptureConfiguration.h"
#import "NVCaptureServiceDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/// A class responsible for managing video capture and recording using AVCaptureSession.
@interface NVCaptureService : NSObject <AVCaptureFileOutputRecordingDelegate>

/// The delegate will receive notifications about recording events and errors.
@property(nonatomic, weak) id<NVCaptureServiceDelegate> delegate;

/// A read-only property that provides access to the AVCaptureSession used for video capture.
@property(nonatomic, strong, readonly) AVCaptureSession *captureSession;
/// A read-only property that provides access to the AVCaptureMovieFileOutput used for recording
/// video.
@property(nonatomic, strong, readonly) AVCaptureMovieFileOutput *fileOutput;

/// Starts video recording with specified configuration.
///
/// - Parameters:
///   - uniqueID: The unique identifier of the audio device to be used for recording.
///   - rect: The CGRect specifying the capture area.
///   - displayID: The CGDirectDisplayID of the display to be captured.
///   - outputFileURL: The NSURL specifying the output file URL where the recording will be saved.
- (void)startRecordingWithAudioDeviceID:(NSString *)uniqueID
                                   rect:(CGRect)rect
                        directDisplayID:(CGDirectDisplayID)displayID
                          outputFileURL:(NSURL *)outputFileURL;

/// Starts video recording with a configuration object and specified parameters.
///
/// - Parameters:
///   - configuration: An NVCaptureConfiguration object that specifies capture settings.
///   - uniqueID: The unique identifier of the audio device to be used for recording.
///   - rect: The CGRect specifying the capture area.
///   - displayID: The CGDirectDisplayID of the display to be captured.
///   - outputFileURL: The NSURL specifying the output file URL where the recording will be saved.
- (void)startRecordingWithConfiguration:(NVCaptureConfiguration *)configuration
                               deviceID:(NSString *)uniqueID
                                   rect:(CGRect)rect
                        directDisplayID:(CGDirectDisplayID)displayID
                          outputFileURL:(NSURL *)outputFileURL;

/// Stops the current video recording session.
- (void)stop;

/// Pauses the current video recording session.
- (void)pause;

/// Resumes a paused video recording session.
- (void)resume;

@end

NS_ASSUME_NONNULL_END

//
//  NVCaptureServiceDelegate.h
//  CaptureKit
//
//  Created by Никита Васильев on 09.10.2023.
//  Copyright © 2023 space-code. All rights reserved.
//

#ifndef NVCaptureServiceDelegate_h
#define NVCaptureServiceDelegate_h

/// A protocol for delegates of a capture service to receive recording-related events.
@protocol NVCaptureServiceDelegate <NSObject>

/// Notifies the delegate that recording to a specific output file has finished.
///
/// - Parameters:
///   - output: The AVCaptureFileOutput instance responsible for the recording.
///   - outputFileURL: The URL where the recording was saved.
///   - connections: An array of AVCaptureConnection objects associated with the recording.
///   - error: An optional error that occurred during recording (or nil if there was no error).
- (void)captureService:(AVCaptureFileOutput *)output
    didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL
                        fromConnections:(NSArray *)connections
                                  error:(NSError *)error;

/// Notifies the delegate that recording to a specific output file has started.
///
/// - Parameters:
///   - output: The AVCaptureFileOutput instance responsible for the recording.
///   - fileURL: The URL where the recording was saved.
///   - connections: An array of AVCaptureConnection objects associated with the recording.
- (void)captureService:(AVCaptureFileOutput *)output
    didStartRecordingToOutputFileAtURL:(NSURL *)fileURL
                       fromConnections:(NSArray<AVCaptureConnection *> *)connections;

/// Notifies the delegate that recording to a specific output file has resumed after being paused.
///
/// - Parameters:
///   - output: The AVCaptureFileOutput instance responsible for the recording.
///   - fileURL: The URL where the recording was saved.
///   - connections: An array of AVCaptureConnection objects associated with the recording.
- (void)captureService:(AVCaptureFileOutput *)output
    didResumeRecordingToOutputFileAtURL:(NSURL *)fileURL
                        fromConnections:(NSArray<AVCaptureConnection *> *)connections;

/// Notifies the delegate that recording to a specific output file has been paused.
///
/// - Parameters:
///   - output: The AVCaptureFileOutput instance responsible for the recording.
///   - fileURL: The URL where the recording was saved.
///   - connections: An array of AVCaptureConnection objects associated with the recording.
- (void)captureService:(AVCaptureFileOutput *)output
    didPauseRecordingToOutputFileAtURL:(NSURL *)fileURL
                       fromConnections:(NSArray<AVCaptureConnection *> *)connections;

@end

#endif /* NVCaptureServiceDelegate_h */

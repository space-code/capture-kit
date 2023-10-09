//
//  NVCaptureServiceDelegate.h
//  CaptureKit
//
//  Created by Никита Васильев on 09.10.2023.
//  Copyright © 2023 space-code. All rights reserved.
//

#ifndef NVCaptureServiceDelegate_h
#define NVCaptureServiceDelegate_h

@protocol NVCaptureServiceDelegate <NSObject>

- (void)captureService:(AVCaptureFileOutput *)output
    didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL
                        fromConnections:(NSArray *)connections
                                  error:(NSError *)error;
- (void)captureService:(AVCaptureFileOutput *)output
    didStartRecordingToOutputFileAtURL:(NSURL *)fileURL
                       fromConnections:(NSArray<AVCaptureConnection *> *)connections;
- (void)captureService:(AVCaptureFileOutput *)output
    didResumeRecordingToOutputFileAtURL:(NSURL *)fileURL
                        fromConnections:(NSArray<AVCaptureConnection *> *)connections;
- (void)captureService:(AVCaptureFileOutput *)output
    didPauseRecordingToOutputFileAtURL:(NSURL *)fileURL
                       fromConnections:(NSArray<AVCaptureConnection *> *)connections;

@end

#endif /* NVCaptureServiceDelegate_h */

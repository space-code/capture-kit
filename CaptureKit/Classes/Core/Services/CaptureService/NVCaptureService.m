//
// CaptureKit
// Copyright © 2023 Space Code. All rights reserved.
//

#import "NVCaptureService.h"
#import "NVDisplayBoundsProvider.h"

@interface NVCaptureService ()

@property(nonatomic, strong) NVCaptureConfiguration *configuration;

@end

@implementation NVCaptureService

#pragma mark - Initialization

- (instancetype)init {
  if (self = [super init]) {
    _configuration = [NVCaptureConfiguration default];
  }
  return self;
}

#pragma mark - Public

- (void)startRecordingWithAudioDeviceID:(NSString *)uniqueID
                                   rect:(CGRect)rect
                        directDisplayID:(CGDirectDisplayID)displayID
                          outputFileURL:(NSURL *)outputFileURL {
  [self startRecordingWithConfiguration:[NVCaptureConfiguration default]
                               deviceID:uniqueID
                                   rect:rect
                        directDisplayID:displayID
                          outputFileURL:outputFileURL];
}

- (void)startRecordingWithConfiguration:(NVCaptureConfiguration *)configuration
                               deviceID:(NSString *)uniqueID
                                   rect:(CGRect)rect
                        directDisplayID:(CGDirectDisplayID)displayID
                          outputFileURL:(NSURL *)outputFileURL {
  [self setupWithRect:rect directDisplayID:displayID];
  [self setCaptureDeviceWithDeviceID:uniqueID rect:rect];
  [self startCapturingToOutputFileURL:outputFileURL];
}

- (void)stop {
  if ([_fileOutput isRecording]) {
    [_fileOutput stopRecording];
    [_captureSession stopRunning];
    _captureSession = nil;
  }
}

- (void)pause {
  if ([_fileOutput isRecording]) {
    [_fileOutput pauseRecording];
  }
}

- (void)resume {
  if ([_fileOutput isRecording]) {
    [_fileOutput resumeRecording];
  }
}

#pragma mark - Private

- (void)setupWithRect:(CGRect)rect directDisplayID:(CGDirectDisplayID)displayID {
  _captureSession = [[AVCaptureSession alloc] init];

  [self setSessionPresetWithQuality:_configuration.captureQuality];

  CGDirectDisplayID currentID = displayID;

  CGDirectDisplayID id;
  CGDisplayCount count;
  CGDisplayErr err = CGGetDisplaysWithPoint(rect.origin, 1, &id, &count);

  if (err == kCGErrorSuccess) {
    currentID = id;
  }

  [self setCaptureScreenInputWithDisplayID:currentID rect:rect];
}

- (void)setCaptureScreenInputWithDisplayID:(CGDirectDisplayID)displayID rect:(CGRect)rect {
  AVCaptureScreenInput *input = [[AVCaptureScreenInput alloc] initWithDisplayID:displayID];

  CMTime minimumFrameDuration = CMTimeMake(1, (int32_t)_configuration.fps);
  [input setMinFrameDuration:minimumFrameDuration];

  CGRect displayBounds =
      [[NVDisplayBoundsProvider sharedInstance] boundsForDisplayWithID:displayID];

  input.cropRect = CGRectMake(
      rect.origin.x - displayBounds.origin.x,
      displayBounds.size.height - displayBounds.origin.y - rect.origin.y - rect.size.height,
      rect.size.width,
      rect.size.height);

  input.capturesCursor = _configuration.capturesCursor;
  input.capturesMouseClicks = _configuration.capturesMouseClicks;

  if (!input) {
    _captureSession = nil;
  } else if ([_captureSession canAddInput:input]) {
    [_captureSession addInput:input];
  }
}

- (void)setCaptureDeviceWithDeviceID:(NSString *)uniqueID rect:(CGRect)rect {
  if (uniqueID != nil) {
    AVCaptureDevice *audioDevice = [AVCaptureDevice deviceWithUniqueID:uniqueID];
    AVCaptureDeviceInput *audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice
                                                                             error:nil];
    if ([_captureSession canAddInput:audioInput]) {
      [_captureSession addInput:audioInput];
    }
  }
}

- (void)setSessionPresetWithQuality:(NVCaptureQuality)quality {
  switch (quality) {
    case High:
      _captureSession.sessionPreset = AVCaptureSessionPresetHigh;
      break;
    case Medium:
      _captureSession.sessionPreset = AVCaptureSessionPresetMedium;
      break;
    case Low:
      _captureSession.sessionPreset = AVCaptureSessionPresetLow;
      break;
  }
}

- (void)startCapturingToOutputFileURL:(NSURL *)outputFileURL {
  _fileOutput = [[AVCaptureMovieFileOutput alloc] init];
  if ([_captureSession canAddOutput:_fileOutput]) [_captureSession addOutput:_fileOutput];

  [_captureSession startRunning];
  if ([[NSFileManager defaultManager] fileExistsAtPath:[outputFileURL path]]) {
    NSError *err;

    if (![[NSFileManager defaultManager] removeItemAtPath:[outputFileURL path] error:&err]) {
      NSLog(@"Error deleting existing movie %@", [err localizedDescription]);
    }
  }

  [_fileOutput startRecordingToOutputFileURL:outputFileURL recordingDelegate:self];
}

#pragma mark - AVCaptureFileOutputRecordingDelegate

- (void)captureOutput:(AVCaptureFileOutput *)output
    didStartRecordingToOutputFileAtURL:(NSURL *)fileURL
                       fromConnections:(NSArray<AVCaptureConnection *> *)connections {
  [_delegate captureService:output
      didStartRecordingToOutputFileAtURL:fileURL
                         fromConnections:connections];
}

- (void)captureOutput:(AVCaptureFileOutput *)output
    didResumeRecordingToOutputFileAtURL:(NSURL *)fileURL
                        fromConnections:(NSArray<AVCaptureConnection *> *)connections {
  [_delegate captureService:output
      didResumeRecordingToOutputFileAtURL:fileURL
                          fromConnections:connections];
}

- (void)captureOutput:(AVCaptureFileOutput *)output
    didPauseRecordingToOutputFileAtURL:(NSURL *)fileURL
                       fromConnections:(NSArray<AVCaptureConnection *> *)connections {
  [_delegate captureService:output
      didPauseRecordingToOutputFileAtURL:fileURL
                         fromConnections:connections];
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput
    didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL
                        fromConnections:(NSArray *)connections
                                  error:(NSError *)error {
  [_delegate captureService:captureOutput
      didFinishRecordingToOutputFileAtURL:outputFileURL
                          fromConnections:connections
                                    error:error];
  _fileOutput = nil;
}

@end

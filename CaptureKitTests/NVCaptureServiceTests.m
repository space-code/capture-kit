//
// CaptureKitTests
// Copyright © 2023 Space Code. All rights reserved.
//

#import <OCMock/OCMock.h>
#import <XCTest/XCTest.h>
#import "NVCaptureService.h"
#import "NVCaptureServiceDelegate.h"
#import "NVDisplayBoundsProvider.h"

static NSString *const kAudioID = @"audio-id";

@interface NVCaptureServiceTests : XCTestCase

@property(nonatomic, strong) NVCaptureService *captureService;
@property(nonatomic, strong) id captureSessionMock;
@property(nonatomic, strong) id screenInputMock;
@property(nonatomic, strong) id fileOutputMock;
@property(nonatomic, strong) id delegateMock;

@property(nonatomic, strong) NSURL *sampleURL;
@property(nonatomic, assign) CGRect sampleRect;

@end

@implementation NVCaptureServiceTests

#pragma mark - XCTestCase

- (void)setUp {
  [super setUp];
  _sampleRect = CGRectMake(0, 0, 100, 100);
  _sampleURL = [[NSURL alloc] initWithString:@""];
  _captureService = [[NVCaptureService alloc] init];
  [self setupCaptureSessionMock];
  [self setupAudioMock];
  [self setupFileOutputMock];
}

- (void)tearDown {
  _sampleURL = nil;
  _captureService = nil;
  [_captureSessionMock stopMocking];
  [_screenInputMock stopMocking];
  [_fileOutputMock stopMocking];
  [super tearDown];
}

#pragma mark - Tests

- (void)testThatCaptureServiceStartsRecordingWithAudioID {
  // given
  [[_captureSessionMock expect] startRunning];
  [[_fileOutputMock expect] startRecordingToOutputFileURL:_sampleURL
                                        recordingDelegate:[OCMArg any]];

  // when
  [_captureService startRecordingWithAudioDeviceID:kAudioID
                                              rect:_sampleRect
                                   directDisplayID:kCGDirectMainDisplay
                                     outputFileURL:_sampleURL];

  // then
  [_captureSessionMock verify];
  [_fileOutputMock verify];
}

- (void)testThatCaptureServiceSetsConfigurationParameters {
  // given
  OCMExpect([_screenInputMock setCapturesCursor:YES]);
  OCMExpect([_screenInputMock setCapturesMouseClicks:NO]);

  // when
  [_captureService startRecordingWithAudioDeviceID:kAudioID
                                              rect:_sampleRect
                                   directDisplayID:kCGDirectMainDisplay
                                     outputFileURL:_sampleURL];

  // when
  [_screenInputMock verify];
}

- (void)testThatCaptureServiceSetsRightRect {
  // given
  NSRect rect = CGRectMake(0, 0, 1200, 1800);
  id boundsProviderMock = OCMClassMock([NVDisplayBoundsProvider class]);

  OCMStub(ClassMethod([boundsProviderMock sharedInstance])).andReturn(boundsProviderMock);
  OCMStub([boundsProviderMock boundsForDisplayWithID:kCGDirectMainDisplay]).andReturn(rect);

  OCMExpect([_screenInputMock setCropRect:CGRectMake(0, 1700, 100, 100)]);

  // when
  [_captureService startRecordingWithAudioDeviceID:kAudioID
                                              rect:_sampleRect
                                   directDisplayID:kCGDirectMainDisplay
                                     outputFileURL:_sampleURL];

  // when
  [_screenInputMock verify];
}

- (void)testThatCaptureServiceTriggersDelegateWhenRecordingDidStart {
  // given
  id delegateMock = OCMProtocolMock(@protocol(NVCaptureServiceDelegate));
  [_captureService setDelegate:delegateMock];

  OCMExpect([delegateMock captureService:[OCMArg any]
      didStartRecordingToOutputFileAtURL:[OCMArg any]
                         fromConnections:[OCMArg any]]);

  // when
  [_captureService captureOutput:_fileOutputMock
      didStartRecordingToOutputFileAtURL:_sampleURL
                         fromConnections:[NSArray new]];

  // then
  [delegateMock verify];
}

- (void)testThatCaptureServiceTriggersDelegateWhenRecordingDidFinish {
  // given
  id delegateMock = OCMProtocolMock(@protocol(NVCaptureServiceDelegate));
  [_captureService setDelegate:delegateMock];

  OCMExpect([delegateMock captureService:[OCMArg any]
      didFinishRecordingToOutputFileAtURL:[OCMArg any]
                          fromConnections:[OCMArg any]
                                    error:[OCMArg any]]);

  // when
  [_captureService captureOutput:_fileOutputMock
      didFinishRecordingToOutputFileAtURL:_sampleURL
                          fromConnections:[NSArray new]
                                    error:nil];

  // then
  [delegateMock verify];
}

- (void)testThatCaptureServiceTriggersDelegateWhenRecordingDidResume {
  // given
  id delegateMock = OCMProtocolMock(@protocol(NVCaptureServiceDelegate));
  [_captureService setDelegate:delegateMock];

  OCMExpect([delegateMock captureService:[OCMArg any]
      didResumeRecordingToOutputFileAtURL:[OCMArg any]
                          fromConnections:[OCMArg any]]);

  // when
  [_captureService captureOutput:_fileOutputMock
      didResumeRecordingToOutputFileAtURL:_sampleURL
                          fromConnections:[NSArray new]];

  // then
  [delegateMock verify];
}

- (void)testThatCaptureServiceTriggersDelegateWhenRecordingDidPause {
  // given
  id delegateMock = OCMProtocolMock(@protocol(NVCaptureServiceDelegate));
  [_captureService setDelegate:delegateMock];

  OCMExpect([delegateMock captureService:[OCMArg any]
      didPauseRecordingToOutputFileAtURL:[OCMArg any]
                         fromConnections:[OCMArg any]]);

  // when
  [_captureService captureOutput:_fileOutputMock
      didPauseRecordingToOutputFileAtURL:_sampleURL
                         fromConnections:[NSArray new]];

  // then
  [delegateMock verify];
}

- (void)testThatCaptureServiceStopsRecordingWhenRecordingIsActive {
  // given
  OCMStub([_fileOutputMock isRecording]).andReturn(YES);

  OCMExpect([_fileOutputMock stopRecording]);
  OCMExpect(([_captureSessionMock stopRunning]));

  // when
  [_captureService startRecordingWithAudioDeviceID:kAudioID
                                              rect:_sampleRect
                                   directDisplayID:kCGDirectMainDisplay
                                     outputFileURL:_sampleURL];
  [_captureService stop];

  // then
  [_captureSessionMock verify];
  [_fileOutputMock verify];
}

- (void)testThatCaptureServicePausesRecordingWhenRecordingIsActive {
  // given
  OCMStub([_fileOutputMock isRecording]).andReturn(YES);

  OCMExpect([_fileOutputMock pauseRecording]);

  // when
  [_captureService startRecordingWithAudioDeviceID:kAudioID
                                              rect:_sampleRect
                                   directDisplayID:kCGDirectMainDisplay
                                     outputFileURL:_sampleURL];
  [_captureService pause];

  // then
  [_fileOutputMock verify];
}

- (void)testThatCaptureServiceResumesRecordingWhenRecordingIsActive {
  // given
  OCMStub([_fileOutputMock isRecording]).andReturn(YES);

  OCMExpect([_fileOutputMock resumeRecording]);

  // when
  [_captureService startRecordingWithAudioDeviceID:kAudioID
                                              rect:_sampleRect
                                   directDisplayID:kCGDirectMainDisplay
                                     outputFileURL:_sampleURL];
  [_captureService resume];

  // then
  [_fileOutputMock verify];
}

#pragma mark - Private

- (void)setupCaptureSessionMock {
  id captureSessionMock = OCMClassMock([AVCaptureSession class]);
  OCMStub([captureSessionMock alloc]).andReturn(captureSessionMock);
  _captureSessionMock = captureSessionMock;
}

- (void)setupAudioMock {
  id screenInputMock = OCMClassMock([AVCaptureScreenInput class]);
  OCMStub([screenInputMock alloc]).andReturn(screenInputMock);
  OCMStub([screenInputMock initWithDisplayID:kCGDirectMainDisplay]).andReturn(screenInputMock);
  _screenInputMock = screenInputMock;
}

- (void)setupFileOutputMock {
  id fileOutputMock = OCMClassMock([AVCaptureMovieFileOutput class]);
  OCMStub([fileOutputMock alloc]).andReturn(fileOutputMock);
  _fileOutputMock = fileOutputMock;
}

@end

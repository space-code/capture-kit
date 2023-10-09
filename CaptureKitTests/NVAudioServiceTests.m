//
// CaptureKitTests
// Copyright © 2023 Space Code. All rights reserved.
//

#import <OCMock/OCMock.h>
#import <XCTest/XCTest.h>

#import "NVAudioService.h"

static NSString *const kDeviceID = @"device-id";

@interface NVAudioServiceTests : XCTestCase

@property(nonatomic, readwrite, strong) id mediaProvider;
@property(nonatomic, readwrite, strong) NVAudioService *audioService;

@end

@implementation NVAudioServiceTests

- (void)setUp {
  [super setUp];
  _mediaProvider = OCMProtocolMock(@protocol(NVIMediaProvider));
  _audioService = [[NVAudioService alloc] initWithMediaDeviceProvider:_mediaProvider];
}

- (void)tearDown {
  [_mediaProvider stopMocking];
  _audioService = nil;
  [super tearDown];
}

- (void)testThatAudioServiceReturnsNilWhenAudioDeviceAreNil {
  // when
  NSArray *IDs = [_audioService getAudioDevicesIDs:nil];

  // then
  XCTAssertNil(IDs);
}

- (void)testThatAudioServiceReturnsNilWhenAudioDeviceArrayIsEmpty {
  // when
  NSArray *IDs = [_audioService getAudioDevicesIDs:[[NSArray alloc] init]];

  // then
  XCTAssertNil(IDs);
}

- (void)testThatAudioServiceReturnsAudioDeviceIDsWhenAudioDeviceArrayIsNotEmpty {
  // given
  id device = OCMClassMock([AVCaptureDevice class]);
  NSArray *array = [[NSMutableArray alloc] initWithObjects:device, nil];

  OCMStub([(AVCaptureDevice *)device uniqueID]).andReturn(kDeviceID);

  // when
  NSArray *IDs = [_audioService getAudioDevicesIDs:array];

  // then
  XCTAssertEqual([IDs count], 1);
  XCTAssertEqual([IDs firstObject], kDeviceID);
}

- (void)testThatAudioDeviceIsNotConnectedWhenAudioDeviceDoesNotExist {
  // given
  OCMStub([self.mediaProvider devicesWithMediaType:[OCMArg any]]).andReturn(nil);

  // when
  BOOL isConnected = [self.audioService isAudioDeviceConnected:kDeviceID];

  // then
  XCTAssertFalse(isConnected);
}

- (void)testThatAudioDeviceIsConnectedWhenAudioDeviceExists {
  // given
  id device = OCMClassMock([AVCaptureDevice class]);
  NSArray *array = [[NSMutableArray alloc] initWithObjects:device, nil];

  OCMStub([self.mediaProvider devicesWithMediaType:[OCMArg any]]).andReturn(array);
  OCMStub([(AVCaptureDevice *)device uniqueID]).andReturn(kDeviceID);

  // when
  BOOL isConnected = [self.audioService isAudioDeviceConnected:kDeviceID];

  // then
  XCTAssertTrue(isConnected);
}

@end

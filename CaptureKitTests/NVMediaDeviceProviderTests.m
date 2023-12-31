//
// CaptureKitTests
// Copyright © 2023 Space Code. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <OCMock/OCMock.h>
#import <XCTest/XCTest.h>

#import "NVMediaDeviceProvider.h"

@interface NVMediaDeviceProviderTests : XCTestCase

@property(nonatomic, strong) id captureDevice;
@property(nonatomic, strong) NVMediaDeviceProvider *deviceProvider;

@end

@implementation NVMediaDeviceProviderTests

#pragma mark - Initialization

- (void)setUp {
  [super setUp];
  _captureDevice = OCMClassMock([AVCaptureDevice class]);
  _deviceProvider = [[NVMediaDeviceProvider alloc] init];
}

- (void)tearDown {
  _deviceProvider = nil;
  [_captureDevice stopMocking];
  [super tearDown];
}

#pragma mark - Tests

- (void)testThatMediaDeviceProviderProvidesDevicesWithGivenMediaType {
  // given
  id classMock = OCMClassMock([AVCaptureDevice class]);
  NSArray<AVCaptureDevice *> *devices = [[NSArray alloc] initWithObjects:_captureDevice, nil];
  OCMStub(ClassMethod([classMock devicesWithMediaType:[OCMArg any]])).andReturn(devices);

  // when
  NSArray<AVCaptureDevice *> *result = [_deviceProvider devicesWithMediaType:AVMediaTypeAudio];

  // then
  XCTAssertEqual(devices, result);
}

@end

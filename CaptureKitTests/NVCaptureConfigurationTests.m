//
// CaptureKitTests
// Copyright © 2023 Space Code. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NVCaptureConfiguration.h"

@interface NVCaptureConfigurationTests : XCTestCase

@end

@implementation NVCaptureConfigurationTests

#pragma mark - Tests

- (void)testThatConfigurationSetsUpDefaultValues {
  // when
  NVCaptureConfiguration *configration = [NVCaptureConfiguration default];

  // then
  XCTAssertEqual(configration.fps, 60);
  XCTAssertTrue(configration.capturesCursor);
  XCTAssertFalse(configration.capturesMouseClicks);
  XCTAssertEqual(configration.captureQuality, High);
}

- (void)testThatConfigurationReturnsTheSameInstanceWhenCopying {
  // given
  NVCaptureConfiguration *configration = [NVCaptureConfiguration default];

  // when
  NVCaptureConfiguration *copiedConfiguration = [configration copy];

  // then
  XCTAssertEqual(configration, copiedConfiguration);
}

@end

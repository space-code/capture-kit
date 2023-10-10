//
// CaptureKit
// Copyright © 2023 Space Code. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NVDisplayBoundsProvider : NSObject

/// Returns a shared instance of NVDisplayBoundsProvider
+ (nullable instancetype)sharedInstance;

/// Retrieves the bounds (CGRect) of the display with the specified display ID.
///
/// - Parameter displayID: The CGDirectDisplayID of the display whose bounds you want to retrieve.
///
/// - Returns: The bounds (CGRect) of the display identified by the provided CGDirectDisplayID.
- (CGRect)boundsForDisplayWithID:(CGDirectDisplayID)displayID;

@end

NS_ASSUME_NONNULL_END

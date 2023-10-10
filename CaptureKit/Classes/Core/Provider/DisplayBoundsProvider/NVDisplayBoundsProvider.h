//
//  NVDisplayBoundsProvider.h
//  CaptureKit
//
//  Created by Никита Васильев on 10.10.2023.
//  Copyright © 2023 space-code. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NVDisplayBoundsProvider : NSObject

+ (nullable instancetype)sharedInstance;

- (CGRect)boundsForDisplayWithID:(CGDirectDisplayID)displayID;

@end

NS_ASSUME_NONNULL_END

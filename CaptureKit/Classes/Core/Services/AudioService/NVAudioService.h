//
// CaptureKit
// Copyright © 2023 Space Code. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

#import "NVIMediaProvider.h"

NS_ASSUME_NONNULL_BEGIN

/// NVAudioService is a class responsible for managing audio devices and their connections.
@interface NVAudioService : NSObject

/// Initializes an instance of NVAudioService with a media device provider.
///
/// @param mediaDeviceProvider An object conforming to the NVIMediaProvider protocol that provides
/// media-related functionality.
/// @return An initialized NVAudioService instance.
- (id)initWithMediaDeviceProvider:(id<NVIMediaProvider>)mediaDeviceProvider;

/// Retrieves the unique identifiers of audio devices associated with the provided devices.
///
/// @param devices An array of devices for which you want to retrieve audio device identifiers.
/// @return An array of unique identifiers (NSString) of audio devices.
- (NSArray *)getAudioDevicesIDs:(NSArray *)devices;

/// Checks if an audio device with the specified unique identifier is currently connected.
///
/// @param uniqueID The unique identifier (NSString) of the audio device to check.
/// @return YES if the audio device is connected, NO otherwise.
- (BOOL)isAudioDeviceConnected:(NSString *)uniqueID;

@end

NS_ASSUME_NONNULL_END

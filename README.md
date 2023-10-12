![capture-kit: ](https://raw.githubusercontent.com/space-code/capture-kit/dev/Resources/capture-kit.png)

<h1 align="center" style="margin-top: 0px;">capture-kit</h1>

<p align="center">
<a href="https://github.com/space-code/validator/blob/main/LICENSE"><img alt="Liscence" src="https://img.shields.io/cocoapods/l/service-core.svg?style=flat"></a> 
<a href="https://github.com/space-code/capture-kit"><img alt="CI" src="https://github.com/space-code/capture-kit/actions/workflows/ci.yml/badge.svg?branch=main"></a>
</p>

## Description
`capture-kit` is a framework written in Objective-C that provides functions that can be used to capture the contents of a screen.

- [Usage](#usage)
- [Requirements](#requirements)
- [Communication](#communication)
- [Contributing](#contributing)
- [Author](#author)
- [License](#license)

## Usage

1. Create a new instance of `NVCaptureService` that encompasses screen capturing functionality.

```objc
NVCaptureService *captureService = [[NVCaptureService alloc] init];
```

2. Set a delegate to receive recording-related events:

```objc
captureService.delegate = self;
```

3. An optional step: If you want to capture microphone sound, you need to obtain a microphone ID. To do this, create a new instance of `NVAudioService` that provides a list of connected device IDs.

```objc
NVAudioService *audioService = [[NVAudioService alloc] initWithMediaDeviceProvider:[NVMediaDeviceProvider new]];
NSArray<NSString *> *ids = [audioService audioDevicesIDs];
```

You can also check whether an audio device is connected to the system like this:
```objc
BOOL isConnected = [audioService isAudioDeviceConnected:@"<device_id_here>"];
```

4. Start screen capture

```objc
NSRect sampleRect = CGRectMake(0, 0, 1200, 1800);
NSURL *sampleURL = [[NSURL alloc] initWithString:@"file_url"];

[_captureService startRecordingWithAudioDeviceID:@"<device_id_here>"
                                            rect:sampleRect
                                 directDisplayID:kCGDirectMainDisplay
                                   outputFileURL:sampleURL];
```

Also, you can pass a custom capture configuration using ```objc - (void)startRecordingWithConfiguration:deviceID:rect:directDisplayID:outputFileURL:```

5. For pausing, resuming, and cancelling, you can use the following methods:

```objc
- (void)pause
- (void)resume
- (void)stop
```

## Requirements
- macOS 11.0+
- Xcode 14.0

## Communication
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Contributing
Bootstrapping development environment

```
make bootstrap
```

Please feel free to help out with this project! If you see something that could be made better or want a new feature, open up an issue or send a Pull Request!

## Author
Nikita Vasilev, nv3212@gmail.com

## License
capture-kit is available under the MIT license. See the LICENSE file for more info.
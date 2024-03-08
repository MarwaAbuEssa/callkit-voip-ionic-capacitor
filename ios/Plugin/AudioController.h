/*
See LICENSE folder for this sample’s licensing information.

Abstract:
AudioController header.
*/

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioController : NSObject

@property (nonatomic, assign) BOOL muteAudio;
@property (nonatomic, assign, readonly) BOOL audioChainIsBeingReconstructed;

- (OSStatus)startIOUnit;
- (OSStatus)stopIOUnit;

@end

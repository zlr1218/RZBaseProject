//
//  RZPlayBackDelegate.h
//  RZPlayer
//
//  Created by 技术平台开发部 on 2021/4/13.
//

#import <Foundation/Foundation.h>

@class RZPlayManager;
NS_ASSUME_NONNULL_BEGIN

@protocol RZPlayBackDelegate <NSObject>

@required

@property (nonatomic) UIView *playView;

/// The player current play time.
@property (nonatomic, readonly) NSTimeInterval currentTime;

/// The player total time.
@property (nonatomic, readonly) NSTimeInterval totalTime;

/// The player buffer time.
@property (nonatomic, readonly) NSTimeInterval bufferTime;

/// The player seek time.
//@property (nonatomic) NSTimeInterval seekTime;

/// The player play state,playing or not playing.
@property (nonatomic, readonly) BOOL isPlaying;

/// 当前播放器可以播放
@property (nonatomic, readonly) BOOL isPreparedToPlay;

/// The player should auto play, default is YES.
@property (nonatomic) BOOL shouldAutoPlay;

/// The video size.
//@property (nonatomic) CGSize presentationSize;

///------------------------------------
/// If you don't appoint the controlView, you can called the following blocks.
/// If you appoint the controlView, The following block cannot be called outside, only for `ZFPlayerController` calls.
///------------------------------------

/// The block invoked when the player is Ready to play.
@property (nonatomic, copy, nullable) void(^playerReadyToPlay)(id<RZPlayBackDelegate> asset);

/// The block invoked when the player play progress changed.
@property (nonatomic, copy, nullable) void(^playerPlayTimeChanged)(id<RZPlayBackDelegate> asset, NSTimeInterval currentTime, NSTimeInterval duration);

/// The block invoked when the player play buffer changed.
@property (nonatomic, copy, nullable) void(^playerBufferTimeChanged)(id<RZPlayBackDelegate> asset, NSTimeInterval bufferTime);

/// The block invoked when the player play end.
@property (nonatomic, copy, nullable) void(^playerDidToEnd)(id<RZPlayBackDelegate> asset);

/// The block invoked when the player play failed.
@property (nonatomic, copy, nullable) void(^playerPlayFailed)(id<RZPlayBackDelegate> asset, id error);

///------------------------------------
/// end
///------------------------------------

/// Prepares the current queue for playback, interrupting any active (non-mixible) audio sessions.
- (void)prepareToPlay;

/// Play playback.
- (void)play;

/// Pauses playback.
- (void)pause;

/// Stop playback.
- (void)stop;

/// 拖到XX秒播放视频
-(void)seekToTime:(NSTimeInterval)time;

@end

NS_ASSUME_NONNULL_END

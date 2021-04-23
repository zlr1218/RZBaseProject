//
//  RZCCManager.m
//  RZPlayer
//
//  Created by 技术平台开发部 on 2021/4/15.
//

#import "RZCCManager.h"

static NSString *const kCCPlayerUserId = @"055AE5CC4411D5CB";
static NSString *const kCCPlayerKey    = @"BnPoazIUwhRa1Sk5AVBP7hk8dDk7a3Aw";

@interface RZCCManager ()<DWVideoPlayerDelegate>

@property (nonatomic, strong) DWPlayerView *ccPlayer;

@property (nonatomic, copy) NSString *curVideoId;    /**< 当前视频ID */

@end


@implementation RZCCManager

@synthesize playView           = _playView;
@synthesize currentTime        = _currentTime;
@synthesize totalTime          = _totalTime;
@synthesize bufferTime         = _bufferTime;
@synthesize isPlaying          = _isPlaying;
@synthesize isPreparedToPlay   = _isPreparedToPlay;
@synthesize shouldAutoPlay     = _shouldAutoPlay;

@synthesize playerReadyToPlay         = _playerReadyToPlay;
@synthesize playerPlayTimeChanged     = _playerPlayTimeChanged;
@synthesize playerBufferTimeChanged   = _playerBufferTimeChanged;
@synthesize playerDidToEnd            = _playerDidToEnd;
@synthesize playerPlayFailed          = _playerPlayFailed;

- (instancetype)init {
    if (self = [super init]) {
        [self setupCCPlayer];
        self->_shouldAutoPlay = YES;
    }
    return self;
}

#pragma mark - UI

- (void)setupCCPlayer {
    self.ccPlayer = [[DWPlayerView alloc] init];
    self.ccPlayer.delegate = self;
    [self.ccPlayer setPlayInBackground:NO];
    self.playView = self.ccPlayer;
}

- (void)setVideoID:(NSString *)videoID {
    _videoID = videoID;
    if (videoID && videoID.length > 0) {
        [self prepareToPlay];
    }
}

- (void)prepareToPlay {
    if (!self.videoID) return;
    
    DWPlayInfo *playInfo = [[DWPlayInfo alloc] initWithUserId:kCCPlayerUserId andVideoId:self.videoID key:kCCPlayerKey];
    playInfo.timeoutSeconds = 30;
    playInfo.mediatype = @"1";
    [playInfo setFinishBlock:^(DWVodVideoModel * _Nonnull vodVideo) {//成功回调
        [self.ccPlayer playVodViedo:vodVideo withCustomId:@""];
    }];
    [playInfo setErrorBlock:^(NSError * _Nonnull error) {//失败回调
        NSLog(@"%@", error);
    }];
    [playInfo start];
}

/// Play playback.
- (void)play {
    if (!_isPreparedToPlay) {
        [self prepareToPlay];
    } else {
        [self.ccPlayer play];
        self->_isPlaying = YES;
    }
}

/// Pauses playback.
- (void)pause {
    [self.ccPlayer pause];
    self->_isPlaying = NO;
}

/// Stop playback.
- (void)stop {
    [self.ccPlayer pause];
    [self.ccPlayer removeTimer];
    [self.ccPlayer resetPlayer];
    for (UIView *sub in self.ccPlayer.subviews) {
        [sub removeFromSuperview];
    }
    [self.playView removeFromSuperview];
    [self.ccPlayer removeFromSuperview];
}

- (void)seekToTime:(NSTimeInterval)time {
    [self.ccPlayer scrub:time];
}

/** 可播放
 @param playerView 自身对象
 */
-(void)videoPlayerIsReadyToPlayVideo:(DWPlayerView *)playerView {
    if (self.playerReadyToPlay) {
        self.playerReadyToPlay(self);
    }
    self->_totalTime = CMTimeGetSeconds(playerView.player.currentItem.duration);
    self->_isPreparedToPlay = YES;
    if (self.shouldAutoPlay) {
        [self play];
    }
}

/** 播放完毕
 @param playerView 自身对象
 */
-(void)videoPlayerDidReachEnd:(DWPlayerView *)playerView {
    if (self.playerDidToEnd) {
        self.playerDidToEnd(self);
    }
}

/** 获取播放进度
 @param playerView 自身对象
 @param time 当前播放时间
 */
-(void)videoPlayer:(DWPlayerView *)playerView timeDidChange:(float)time {
    if (self.playerPlayTimeChanged) {
        self.playerPlayTimeChanged(self, time, self.totalTime);
    }
    if (time < 0) {
        self->_currentTime = 0;
    } else {
        self->_currentTime = time;
    }
}

/** 获取缓冲进度
 @param playerView 自身对象
 @param duration 当前缓冲进度
 */
-(void)videoPlayer:(DWPlayerView *)playerView loadedTimeRangeDidChange:(float)duration {
    if (self.playerBufferTimeChanged) {
        self.playerBufferTimeChanged(self, duration);
    }
    if (duration < 0) {
        self->_bufferTime = 0;
    } else {
        self->_bufferTime = duration;
    }
}

/** 加载超时/scrub超时
 @param playerView 自身对象
 @param timeOut 超时类型
 */
-(void)videoPlayer:(DWPlayerView *)playerView receivedTimeOut:(DWPlayerViewTimeOut )timeOut {
    
}

/** 加载失败
 @param playerView 自身对象
 @param error 错误信息
 */
-(void)videoPlayer:(DWPlayerView *)playerView didFailWithError:(NSError *)error {
    RZLog(@"%@", error);
    if (self.playerPlayFailed) {
        self.playerPlayFailed(self, error);
    }
}

@end

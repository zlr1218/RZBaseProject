//
//  RZPlayerController.m
//  RZPlayer
//
//  Created by 技术平台开发部 on 2021/4/15.
//

#import "RZPlayerController.h"

@interface RZPlayerController ()

/// 竖屏控制器
@property (nonatomic, strong) RZVerticalControlView *controlView;
/// 横屏控制器
@property (nonatomic, strong) RZHorizontalControlView *FullControlView;

/// 是否全屏
@property (nonatomic, assign) BOOL isFullScreen;

@property (nonatomic, strong) UIView *fullView;

@end

@implementation RZPlayerController

- (void)dealloc {
    [self.curPlayerManager stop];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (instancetype)init {
    if (self = [super init]) {
        /// 接收屏幕方向改变通知,监听屏幕方向
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(orientationHandler)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
    }
    return self;
}

+ (instancetype)playerWithPlayerManager:(id<RZPlayBackDelegate>)playerManager containerView:(nonnull UIView *)containerView {
    RZPlayerController *player = [[self alloc] initWithPlayerManager:playerManager containerView:containerView];
    return player;
}

- (instancetype)initWithPlayerManager:(id<RZPlayBackDelegate>)playerManager containerView:(UIView *)containerView {
    RZPlayerController *player = [self init];
    player.containerView = containerView;
    player.curPlayerManager = playerManager;
    return player;
}

#pragma mark - seter 方法

- (void)setCurPlayerManager:(id<RZPlayBackDelegate>)curPlayerManager {
    _curPlayerManager = curPlayerManager;
    
    [self addControlView];
        
    [self playerManagerCallbcak];
    
    [self layoutPlayerSubViews];
}

- (void)setContainerView:(UIView *)containerView {
    if (!containerView) return;
    
    _containerView = containerView;
    containerView.userInteractionEnabled = YES;
    
    [self layoutPlayerSubViews];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.controlView.titleLabel.text = title;
    self.FullControlView.titleLabel.text = title;
}

- (void)setPlaceImage:(UIImage *)placeImage {
    _placeImage = placeImage;
    
    self.controlView.placeHolder.image = placeImage;
}

#pragma mark - 播放器回调

- (void)playerManagerCallbcak {
    kWeakSelf(self);
    // 可播放
    [self.curPlayerManager setPlayerReadyToPlay:^(id<RZPlayBackDelegate>  _Nonnull asset) {
        //kStrongSelf(self);
    }];
    // 播放进度
    [self.curPlayerManager setPlayerPlayTimeChanged:^(id<RZPlayBackDelegate>  _Nonnull asset, NSTimeInterval currentTime, NSTimeInterval duration) {
        kStrongSelf(self);
        [self.controlView playBtnSelectedState:asset.isPlaying];
        [self.FullControlView playBtnSelectedState:asset.isPlaying];
        if (asset.isPlaying) {
            self.controlView.placeHolder.hidden = YES;
        }
        [self.FullControlView sliderValueChanged:currentTime/duration currentTimeString:[self handleTime:currentTime]];
        self.FullControlView.totalTimeLabel.text = [self handleTime:duration];
        
        [self.controlView sliderValueChanged:currentTime/duration currentTimeString:[self handleTime:currentTime]];
        self.controlView.totalTimeLabel.text = [self handleTime:duration];
    }];
    // 缓冲进度
    [self.curPlayerManager setPlayerBufferTimeChanged:^(id<RZPlayBackDelegate>  _Nonnull asset, NSTimeInterval bufferTime) {
        kStrongSelf(self);
        if (asset.totalTime > 0) {
            self.controlView.slider.bufferValue = bufferTime/asset.totalTime;
            self.FullControlView.slider.bufferValue = bufferTime/asset.totalTime;
        }
    }];
    // 播放结束
    [self.curPlayerManager setPlayerDidToEnd:^(id<RZPlayBackDelegate>  _Nonnull asset) {
        kStrongSelf(self);
        [self.FullControlView sliderChangeEnded];
        [self.controlView sliderChangeEnded];
    }];
}

#pragma mark - 布局子控制器

- (void)layoutPlayerSubViews {
    if (self.containerView && self.curPlayerManager.playView) {
        if (self.isFullScreen) {
            [[self window] addSubview:self.fullView];
            self.fullView.frame = [UIScreen mainScreen].bounds;
            [_fullView addSubview:self.curPlayerManager.playView];
            
            self.controlView.hidden = YES;
            self.FullControlView.hidden = NO;
            self.curPlayerManager.playView.frame = [UIScreen mainScreen].bounds;
            [self.curPlayerManager.playView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsZero);
            }];
            self.curPlayerManager.playView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            self.FullControlView.frame = self.curPlayerManager.playView.bounds;
            self.FullControlView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            
        } else {
            [self.fullView removeFromSuperview];
            [self.containerView addSubview:self.curPlayerManager.playView];
            
            self.FullControlView.hidden = YES;
            self.controlView.hidden = NO;
            self.curPlayerManager.playView.frame = self.containerView.bounds;
            [self.curPlayerManager.playView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsZero);
            }];
            self.curPlayerManager.playView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            self.controlView.frame = self.curPlayerManager.playView.bounds;
            self.controlView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        }
    }
}

- (void)addControlView {
    [self.curPlayerManager.playView addSubview:self.controlView];
    self.controlView.player = self.curPlayerManager;
    self.controlView.hidden = NO;
    
    [self.curPlayerManager.playView addSubview:self.FullControlView];
    self.FullControlView.player = self.curPlayerManager;
    self.FullControlView.hidden = YES;
}

- (UIWindow *)window {
    id appDelegate = [UIApplication sharedApplication].delegate;
    if (appDelegate && [appDelegate respondsToSelector:@selector(window)]) {
        return [appDelegate window];
    }
    
    if (@available(iOS 13.0, *)) {
        NSArray *allObjects = [[[UIApplication sharedApplication] connectedScenes] allObjects];
        UIWindowScene *windowScene = allObjects.firstObject;
        UIWindow *mainWindow = [windowScene valueForKeyPath:@"delegate.window"];
        if (mainWindow) {
            return mainWindow;
        } else {
            NSArray *windows = [UIApplication sharedApplication].windows;
            if ([windows count] == 1) {
                return [windows firstObject];
            } else {
                for (UIWindow *window in windows) {
                    if (window.windowLevel == UIWindowLevelNormal) {
                        return window;
                    }
                }
            }
        }
    } else {
        NSArray *windows = [UIApplication sharedApplication].windows;
        if ([windows count] == 1) {
            return [windows firstObject];
        } else {
            for (UIWindow *window in windows) {
                if (window.windowLevel == UIWindowLevelNormal) {
                    return window;
                }
            }
        }
    }
    return nil;
}

#pragma mark - 屏幕旋转监控回调

- (void)orientationHandler {
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    self.fullView.frame = CGRectMake(0, 0, w, h);
    if (w > h) {
        self.isFullScreen = YES;
    } else {
        self.isFullScreen = NO;
    }
    [self layoutPlayerSubViews];
}

#pragma mark - 私有方法

- (NSString *)handleTime:(float)time {
    int intSeconds = (int)time;
    if (intSeconds >= 3600) {
        int h = (int)round((intSeconds%86400)/3600);
        int m = (int)round((intSeconds%3600)/60);
        int s = (int)round(intSeconds%60);
        NSString *hhmmss = [NSString stringWithFormat:@"%02d:%02d:%02d", h, m, s];
        return hhmmss;
    } else {
        int m = (int)round((intSeconds%3600)/60);
        int s = (int)round(intSeconds%60);
        NSString *mmss = [NSString stringWithFormat:@"%02d:%02d", m, s];
        return mmss;
    }
}


#pragma mark - 懒加载

- (UIView *)fullView {
    if (!_fullView) {
        _fullView = [[UIView alloc] initWithFrame:CGRectZero];
        _fullView.backgroundColor = UIColor.blackColor;
    }
    return _fullView;
}

- (RZVerticalControlView *)controlView {
    if (!_controlView) {
        _controlView = [[RZVerticalControlView alloc] init];
    }
    return _controlView;
}

- (RZHorizontalControlView *)FullControlView {
    if (!_FullControlView) {
        _FullControlView = [[RZHorizontalControlView alloc] init];
    }
    return _FullControlView;
}

@end

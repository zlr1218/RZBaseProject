//
//  RZHorizontalControlView.h
//  RZPlayer
//
//  Created by 技术平台开发部 on 2021/4/16.
//

#import <UIKit/UIKit.h>
#import "RZPlayBackDelegate.h"
#import "ZFSliderView.h"
#import "ZFPlayerGestureControl.h"
#import "RZMacros.h"

NS_ASSUME_NONNULL_BEGIN

@interface RZHorizontalControlView : UIView

/*********        UI        *******/
/// 底部工具栏
@property (nonatomic, strong, readonly) UIImageView *bottomToolView;

/// 顶部工具栏
@property (nonatomic, strong, readonly) UIImageView *topToolView;

/// 返回按钮
@property (nonatomic, strong, readonly) UIButton *backBtn;

/// 标题
@property (nonatomic, strong, readonly) UILabel *titleLabel;

/// 播放或暂停按钮
@property (nonatomic, strong, readonly) UIButton *playOrPauseBtn;

/// 播放的当前时间
@property (nonatomic, strong, readonly) UILabel *currentTimeLabel;

/// 滑杆
@property (nonatomic, strong, readonly) ZFSliderView *slider;

/// 视频总时间
@property (nonatomic, strong, readonly) UILabel *totalTimeLabel;

/// 快进快退View
@property (nonatomic, strong, readonly) UIView *fastView;

/// 快进快退进度progress
@property (nonatomic, strong, readonly) ZFSliderView *fastProgressView;

/// 快进快退时间
@property (nonatomic, strong, readonly) UILabel *fastTimeLabel;

/// 快进快退ImageView
@property (nonatomic, strong, readonly) UIImageView *fastImageView;

/***********           UI end             ********/

/// 返回按钮点击回调
@property (nonatomic, copy) void(^backBtnClickCallback)(void);

/// 播放器
@property (nonatomic, strong) id<RZPlayBackDelegate> player;

/// 如果是暂停状态，seek完是否播放，默认YES
@property (nonatomic, assign) BOOL seekToPlay;


/// 更新当前的播放状态
- (void)playBtnSelectedState:(BOOL)selected;

/// 调节播放进度slider和当前时间更新
- (void)sliderValueChanged:(CGFloat)value currentTimeString:(NSString *)timeString;
/// 滑杆结束滑动
- (void)sliderChangeEnded;


@end

NS_ASSUME_NONNULL_END

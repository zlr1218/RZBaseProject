//
//  RZVerticalControlView.h
//  CCDemo
//
//  Created by 技术平台开发部 on 2021/4/12.
//

#import <UIKit/UIKit.h>
#import "ZFSliderView.h"
#import "ZFPlayerGestureControl.h"
#import "RZMacros.h"
#import "RZPlayBackDelegate.h"


@interface RZVerticalControlView : UIView

/// 底部工具栏
@property (nonatomic, strong, readonly) UIImageView *bottomToolView;

/// 顶部工具栏
@property (nonatomic, strong, readonly) UIImageView *topToolView;

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

/// 全屏按钮
@property (nonatomic, strong, readonly) UIButton *fullScreenBtn;

/// 占位图
@property (nonatomic, strong, readonly) UIImageView *placeHolder;

/// 播放器
@property (nonatomic, strong) id<RZPlayBackDelegate> player;

/// 如果是暂停状态，seek完是否播放，默认YES
@property (nonatomic, assign) BOOL seekToPlay;

/// 隐藏控制层
- (void)hideControlViewWithAnimated:(BOOL)animated;

/// 显示控制层
- (void)showControlViewWithAnimated:(BOOL)animated;

/// 更新当前的播放状态
- (void)playBtnSelectedState:(BOOL)selected;

/// 调节播放进度slider和当前时间更新
- (void)sliderValueChanged:(CGFloat)value currentTimeString:(NSString *)timeString;

/// 滑杆结束滑动
- (void)sliderChangeEnded;

@end

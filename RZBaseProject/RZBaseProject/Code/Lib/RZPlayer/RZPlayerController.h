//
//  RZPlayerController.h
//  RZPlayer
//
//  Created by 技术平台开发部 on 2021/4/15.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RZPlayBackDelegate.h"
#import "RZVerticalControlView.h"
#import "RZHorizontalControlView.h"
#import "ZFPlayerGestureControl.h"

#import "RZMacros.h"


NS_ASSUME_NONNULL_BEGIN

@interface RZPlayerController : NSObject

/// 展示的容器
@property (nonatomic, strong) UIView *containerView;

/// 遵循 “RZPlayBackDelegate” 协议的播放管理器
@property (nonatomic, strong) id<RZPlayBackDelegate> curPlayerManager;

/// 视频标题
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIImage *placeImage;

/// 初始化方法
+ (instancetype)playerWithPlayerManager:(id<RZPlayBackDelegate>)playerManager containerView:(UIView *)containerView;
- (instancetype)initWithPlayerManager:(id<RZPlayBackDelegate>)playerManager containerView:(UIView *)containerView;

@end

NS_ASSUME_NONNULL_END

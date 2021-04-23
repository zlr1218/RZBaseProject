//
//  UIView+RZAlert.h
//  RZBaseProject
//
//  Created by 利基 on 2017/11/13.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^RZAlertCancleBlock)();
typedef void(^RZAlertSureBlock)();



@class RZAlertStyle;
@interface UIView (RZAlert)

/// 仅展示Message,默认为关闭按钮,无回调
- (void)showAlertMsg:(NSString *)msg;

/// 仅展示Message,自定义关闭按钮名称,有回调
- (void)showAlertMsg:(NSString *)msg closeName:(NSString *)closeName close:(RZAlertCancleBlock)close;

/// 展示标题,信息,默认“确定”“取消”,有回调
- (void)showAlertTitle:(NSString *)title msg:(NSString *)msg sure:(RZAlertSureBlock)sure;

/// 展示标题,信息,自定义确定按钮名称,有回调
- (void)showAlertTitle:(NSString *)title msg:(NSString *)msg sureName:(NSString *)sureName sure:(RZAlertSureBlock)sure;


/// 全部自定义
- (void)showAlertTitle:(NSString *)title
                   msg:(NSString *)msg
                 style:(RZAlertStyle *)style
             closeName:(NSString *)closeName
                 close:(RZAlertCancleBlock)close
              sureName:(NSString *)sureName
                  sure:(RZAlertSureBlock)sure;

@end

@interface RZAlertStyle: NSObject

/** title color */
@property (nonatomic, strong) UIColor *titleColor;

/** title font */
@property (nonatomic, strong) UIFont *titleFont;

/** title alignment */
@property (nonatomic, assign) NSTextAlignment titleAlignment;


/** message color */
@property (nonatomic, strong) UIColor *messageColor;

/** message fony */
@property (nonatomic, strong) UIFont *messageFont;

/** message alignment */
@property (nonatomic, assign) NSTextAlignment messageAlignment;


/** btnTitleColor */
@property (nonatomic, strong) UIColor *btnTitleColor;

/** btnTitleFont */
@property (nonatomic, strong) UIFont *btnTitleFont;



/** contentViewBGColor */
@property (nonatomic, strong) UIColor *contentViewBGColor;
/** CornerRadius */
@property (nonatomic, assign) CGFloat cornerRadius;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithDefaultSytle NS_DESIGNATED_INITIALIZER;

@end

@interface RZAlertManager: NSObject

/**
 setter, getter 方法
 */
+ (void)setSharedStyle:(RZAlertStyle *)sharedStyle;
+ (RZAlertStyle *)sharedStyle;

@end

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

/**
 仅展示Message，确定SureBlock
 */
- (void)makeAlert:(NSString *)message
        sureBlock:(RZAlertSureBlock)sureBlock;

/**
 展示Message、SureTitle、确定SureBlock
 */
- (void)makeAlert:(NSString *)message
            Title:(NSString *)title
        sureTitle:(NSString *)sureTitle
        sureBlock:(RZAlertSureBlock)sureBlock;


- (void)makeAlert:(NSString *)message
            title:(NSString *)title
            style:(RZAlertStyle *)style
      cancleTitle:(NSString *)cancleTitle
      cancleBlock:(RZAlertCancleBlock)cancleBlock
        sureTitle:(NSString *)sureTitle
        sureBlock:(RZAlertSureBlock)sureBlock;

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

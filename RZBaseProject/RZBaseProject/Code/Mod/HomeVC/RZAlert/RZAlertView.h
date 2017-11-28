//
//  RZAlertView.h
//  RZBaseProject
//
//  Created by 利基 on 2017/11/3.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RZAlertView;
@protocol RZAlertViewDelegate <NSObject>

@optional
- (void)alertView:(nullable RZAlertView *)alertView ClickedBtnAtIndex:(NSInteger)index;

@end

@interface RZAlertView : UIView

- (nonnull instancetype)initWithTitle:(nullable NSString *)title Message:(nonnull NSString *)message Delegate:(nullable id <RZAlertViewDelegate>)delegate CancleTitle:(nullable NSString *)cancleTitle OtherBtnTitles:(nullable NSArray<NSString *> *)otherBtnTitles;


- (void)addButtonKeyWithTitle:(nullable NSString *)title;


/** delegate */
@property (nonatomic, weak, nullable) id <RZAlertViewDelegate>delegate;

/** 消息排列 （靠左，居中，靠右） */
@property (nonatomic, assign) NSTextAlignment messageAlignment;

/** 能否点击蒙版 */
@property (nonatomic, assign) BOOL isClickMask;


@end

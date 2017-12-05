//
//  RZAlertController.h
//  RZBaseProject
//
//  Created by 利基 on 2017/11/13.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^alertLeftBlock)();
typedef void(^alertRightBlock)();

@interface RZAlertController : NSObject

/**
 一个Action（可以自定义）
 */
+ (void)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message actionLeftTitle:(nullable NSString *)leftTitle lefthandler:(_Nullable alertLeftBlock)leftHandler showVC:(nonnull UIViewController*)vc;


/**
 两个Action（可以自定义）
 */
+ (void)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message actionLeftTitle:(nullable NSString *)leftTitle lefthandler:(_Nullable alertLeftBlock)leftHandler actionRightTitle:(nullable NSString *)rightTitle righthandler:(_Nullable alertRightBlock)rightHandler showVC:(nonnull UIViewController*)vc;

@end

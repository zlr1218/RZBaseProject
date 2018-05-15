//
//  RZCustom.h
//  gold
//
//  Created by 利基 on 2017/3/27.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kidfvString [[[UIDevice currentDevice] systemVersion] floatValue]>=6.0000?[[[UIDevice currentDevice] identifierForVendor] UUIDString]:@""

@interface RZCustom : NSObject


/**
 获取当前显示的控制器

 @return 当前显示的控制器
 */
+ (UIViewController *)getCurrentVC;


/**
 判断密码设置是否合规

 @param str 密码
 @return YES Or NO
 */
+ (BOOL)judgeNumber:(NSString*)str;


/**
 对数组中的字符串元素进行自然排序
 */
+ (NSArray*)sortArray:(NSArray *)array;

/**
 判断手机号码格式是否正确

 @param mobile 手机号
 @return 是否正确
 */
+ (BOOL)valiMobile:(NSString *)mobile;


/**
 判断身份证格式是否正确

 @param identityString 身份证号码
 @return 判断是否正确
 */
+ (BOOL)verifyIDCardNumber:(NSString *)identityString;

+ (NSString *)strUTF8Encoding:(NSString *)str;

@end
//
//  RZMacros.h
//  RZBaseProject
//
//  Created by 利基 on 2017/12/5.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#ifndef RZMacros_h
#define RZMacros_h

//弱引用/强引用
#define kWeakSelf(type)   __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

// 适配iOS11
#define kAdjustmentBehavior(VC, view) if (@available(iOS 11.0, *)) {                \
    view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;  \
} else {                                                                            \
    VC.automaticallyAdjustsScrollViewInsets = NO;                                   \
}                                                                                   \

// 判断iPhoneX系列
#define kRZ_iPhoneX_Series ({\
BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
    isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);\
})\

// 状态栏高度
#define kRZStatusBarHeight (kRZ_iPhoneX_Series ? 44 : 20)
// 导航栏高度+状态栏高度
#define kRZTopHeight (kRZ_iPhoneX_Series ? 88 : 64)
// 底部安全距离
#define kRZBottomHeight (kRZ_iPhoneX_Series ? 34 : 0)
// Tab高度
#define kRZTabHeight (kRZ_iPhoneX_Series ? (49+34) : 34)

// 屏幕宽度
#define kScreeWith [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define kScreeHeight [UIScreen mainScreen].bounds.size.height

//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG

#define RZLog(FORMAT, ...) do {                                             \
fprintf(stderr,"\n♨ File:%s line:%d Func:%s ♨\n☞ %s ☜\n",                \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__,                                                                   \
__PRETTY_FUNCTION__,                                                        \
[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);            \
} while (0)

#else
#define RZLog(FORMAT, ...) nil
#endif

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys.count == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

#endif /* RZMacros_h */

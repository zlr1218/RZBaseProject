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

/*
 
 一、nil

 当一个对象置为nil时，这个对象的内存地址就会被系统收回。置空之后是不能进行retain，copy等跟引用计数有关的任何操作的。

 二、Nil

 nil完全等同于Nil，只不过由于编程习惯，人们一般把对象置空用nil，把类置空用Nil。

 三、NULL

 这个是从C语言继承来的，就是一个简单的空指针

 四、[NSNull null]

 这个才是重点：[NSNull null]和nil的区别在于，nil是一个空对象，已经完全从内存中消失了，而如果我们想表达“我们需要有这样一个容器，但这个容器里什么也没有”的观念时，我们就用到[NSNull null]，它就是为“值为空的对象”。如果你查阅开发文档你会发现NSNull这个类是继承NSObject，并且只有一个“+ (NSNull *) null；”类方法。这就说明NSNull对象拥有一个有效的内存地址，所以在程序中对它的任何引用都是不会导致程序崩溃的。
 
 */

//字符串是否为空
#define kStrEmpty(str) ( kObjEmpty(str) || [str length] < 1 || [str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] )
//数组是否为空
#define kArrEmpty(arr) ( !kObjEmpty(arr) && [NSArray isKindOfClass:[arr class]] && arr.count > 0 ) ? NO : YES
//字典是否为空
#define kDicEmpty(dic) ( kObjEmpty(dic) || dic.count == 0 )
//是否是空对象
#define kObjEmpty(obj) ( obj == nil || [obj isEqual:[NSNull null]] || [obj isKindOfClass:[NSNull class]] )

#endif /* RZMacros_h */

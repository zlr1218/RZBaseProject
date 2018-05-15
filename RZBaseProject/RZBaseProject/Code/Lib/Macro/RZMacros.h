//
//  RZMacros.h
//  RZBaseProject
//
//  Created by 利基 on 2017/12/5.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#ifndef RZMacros_h
#define RZMacros_h


#define LMJWeak(type)  __weak typeof(type) weak##type = type



#define kScreeWith [UIScreen mainScreen].bounds.size.width
#define kScreeHeight [UIScreen mainScreen].bounds.size.height

#define SCREEN_SCALE  (kScreeWith/320.f)
#define FontNum(x)   x*SCREEN_SCALE

#define LAB_FONT(x) [UIFont systemFontOfSize:x*SCREEN_SCALE]

//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG

#define RZLog(FORMAT, ...) do {                                     \
fprintf(stderr,"\nfunction:%s \nline:%d content: -> %s\n",          \
__FUNCTION__,                                                       \
__LINE__,                                                           \
[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);    \
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

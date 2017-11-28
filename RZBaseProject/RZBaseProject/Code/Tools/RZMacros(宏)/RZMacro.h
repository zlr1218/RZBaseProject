//
//  RZMacro.h
//  RZBaseProject
//
//  Created by 赵林瑞 on 16/10/25.
//  Copyright © 2016年 RZOL. All rights reserved.
//

#ifndef RZMacro_h
#define RZMacro_h

#define kScreeWith [UIScreen mainScreen].bounds.size.width
#define kScreeHeight [UIScreen mainScreen].bounds.size.height

#define SCREEN_SCALE  (kScreeWith/320.f)
#define FontNum(x)   x*SCREEN_SCALE

#define LAB_FONT(x) [UIFont systemFontOfSize:x*SCREEN_SCALE]

//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define RZ_Log(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content: -> %s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define RZ_Log(FORMAT, ...) nil
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

#endif /* RZMacro_h */

//
//  NSString+RZContains.m
//  RZBaseProject
//
//  Created by os on 2019/5/15.
//  Copyright © 2019 RZOL. All rights reserved.
//

#import "NSString+RZContains.h"

@implementation NSString (RZContains)

/**
 *  @brief  判断URL中是否包含中文
 *
 *  @return 是否包含中文
 */
- (BOOL)rz_ContainChinese
{
    NSUInteger length = [self length];
    for (NSUInteger i = 0; i < length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [self substringWithRange:range];
        const char *cString = [subString UTF8String];
        if (strlen(cString) == 3) {
            return YES;
        }
    }
    return NO;
}

/**
 *  @brief  是否包含空格
 *
 *  @return 是否包含空格
 */
- (BOOL)rz_ContainBlank
{
    NSRange range = [self rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

/**
 *  @brief 是否包含字符串
 *
 *  @param string 字符串
 *
 *  @return YES, 包含; Otherwise
 */
- (BOOL)rz_containsaString:(NSString *)string
{
    NSRange rang = [self rangeOfString:string];
    if (rang.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

/**
 *  @brief 获取字符数量
 */
- (int)rz_wordsCount
{
    NSInteger n = self.length;
    int i;
    int l = 0, a = 0, b = 0;
    unichar c;
    for (i = 0; i < n; i++)
    {
        c = [self characterAtIndex:i];
        if (isblank(c)) {
            b++;
        } else if (isascii(c)) {
            a++;
        } else {
            l++;
        }
    }
    if (a == 0 && l == 0) {
        return 0;
    }
    return l + (int)ceilf((float)(a + b) / 2.0);
}

@end

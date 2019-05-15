//
//  NSString+RZContains.h
//  RZBaseProject
//
//  Created by os on 2019/5/15.
//  Copyright © 2019 RZOL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RZContains)

/**
 *  @brief  判断URL中是否包含中文
 *
 *  @return 是否包含中文
 */
- (BOOL)rz_ContainChinese;

/**
 *  @brief  是否包含空格
 *
 *  @return 是否包含空格
 */
- (BOOL)rz_ContainBlank;

/**
 *  @brief 是否包含字符串
 *
 *  @param string 字符串
 *
 *  @return YES, 包含;
 */
- (BOOL)rz_containsaString:(NSString *)string;

/**
 *  @brief 获取字符数量
 */
- (int)rz_wordsCount;

@end

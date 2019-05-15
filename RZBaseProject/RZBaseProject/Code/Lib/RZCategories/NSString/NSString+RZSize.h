//
//  NSString+RZSize.h
//  RZBaseProject
//
//  Created by os on 2019/5/15.
//  Copyright © 2019 RZOL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RZSize)

/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)rz_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize)rz_sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

@end

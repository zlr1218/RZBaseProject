//
//  UIView+RZShadow.m
//  RZBaseProject
//
//  Created by Apple on 2020/3/9.
//  Copyright © 2020 RZOL. All rights reserved.
//

#import "UIView+RZShadow.h"

@implementation UIView (RZShadow)

- (void)viewShadowPathWithColor:(UIColor *)shadowColor
                  shadowOpacity:(CGFloat)shadowOpacity
                   shadowRadius:(CGFloat)shadowRadius
                 shadowPathType:(RZShadowPathType)shadowPathType
                shadowPathWidth:(CGFloat)shadowPathWidth {
    
    self.layer.masksToBounds = NO;//必须要等于NO否则会把阴影切割隐藏掉
    self.layer.shadowColor = shadowColor.CGColor;// 阴影颜色
    self.layer.shadowOpacity = shadowOpacity;// 阴影透明度，默认0
    self.layer.shadowOffset = CGSizeZero;//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowRadius = shadowRadius;//阴影半径，默认3
    CGRect shadowRect = CGRectZero;
    CGFloat originX,originY,sizeWith,sizeHeight;
    originX = 0;
    originY = 0;
    sizeWith = self.bounds.size.width;
    sizeHeight = self.bounds.size.height;
    
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(-rad, -rad)];
//    //添加直线
//    [path addLineToPoint:CGPointMake(width + rad, -rad)];
//    [path addLineToPoint:CGPointMake(width + rad, width/2)];
//    [path addLineToPoint:CGPointMake(-rad, width/2)];
//    [path addLineToPoint:CGPointMake(-rad, -rad)];
    
    if (shadowPathType == RZShadowTop) {
        shadowRect = CGRectMake(originX, originY-shadowPathWidth/2, sizeWith, shadowPathWidth);
    }else if (shadowPathType == RZShadowBottom){
        shadowRect = CGRectMake(originY, sizeHeight-shadowPathWidth/2, sizeWith, shadowPathWidth);
    }else if (shadowPathType == RZShadowLeft){
        shadowRect = CGRectMake(originX-shadowPathWidth/2, originY, shadowPathWidth, sizeHeight);
    }else if (shadowPathType == RZShadowRight){
        shadowRect = CGRectMake(sizeWith-shadowPathWidth/2, originY, shadowPathWidth, sizeHeight);
    }else if (shadowPathType == RZShadowAround){
        shadowRect = CGRectMake(originX-shadowPathWidth/2, originY-shadowPathWidth/2, sizeWith+shadowPathWidth, sizeHeight+shadowPathWidth);
    }
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:shadowRect];
    self.layer.shadowPath = bezierPath.CGPath;//阴影路径
}

@end

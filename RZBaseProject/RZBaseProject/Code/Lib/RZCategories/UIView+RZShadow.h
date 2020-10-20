//
//  UIView+RZShadow.h
//  RZBaseProject
//
//  Created by Apple on 2020/3/9.
//  Copyright © 2020 RZOL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RZShadowPathType) {
    RZShadowTop,
    RZShadowBottom,
    RZShadowLeft,
    RZShadowRight,
    RZShadowAround,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIView (RZShadow)

@end

NS_ASSUME_NONNULL_END

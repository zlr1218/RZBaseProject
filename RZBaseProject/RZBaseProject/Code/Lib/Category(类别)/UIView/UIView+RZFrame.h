//
//  UIView+RZFrame.h
//  RZBaseProject
//
//  Created by os on 2018/11/1.
//  Copyright © 2018 RZOL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RZFrame)

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;


@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@end

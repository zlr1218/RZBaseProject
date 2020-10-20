//
//  ZYCornerRadius_DemoVC.m
//  RZBaseProject
//
//  Created by 利基 on 2017/12/6.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "ZYCornerRadius_DemoVC.h"
#import "UIImageView+CornerRadius.h"
#import "UIView+RoundedCorner.h"
#import "UIControl+RZLimitClick.h"

@interface ZYCornerRadius_DemoVC ()

@end

@implementation ZYCornerRadius_DemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreeWith, kScreeHeight-kRZTopHeight-kRZBottomHeight)];
//    view.backgroundColor = RZ_LightGray_Color;
//    view.contentSize = CGSizeMake(kScreeWith, kScreeHeight*10);
//    [self.view addSubview:view];
//
//    [view jm_setJMRadius:JMRadiusMake(7, 7, 7, 7) withBackgroundColor:nil];
//
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.left = 50;
//    btn.top = 15;
//    btn.width = 70;
//    btn.height = 70;
//    btn.clickLimitInterval = 2;
//    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:btn];
//
//    btn.layer.shadowColor = [UIColor orangeColor].CGColor;
//    btn.layer.shadowRadius = 20;
//
////    [btn jm_setCornerRadius:5.f withImage:[UIImage imageNamed:@"mac_dog"]];
//    [btn jm_setJMRadius:JMRadiusMake(0, 0, 0, 8) withImage:[UIImage imageNamed:@"mac_dog"]];
//
//
//    UIImageView *imageView = [[UIImageView alloc] initWithRoundingRectImageView];
//    [imageView setFrame:CGRectMake(50, 110, 150, 150)];
//    [view addSubview:imageView];
//
//
//    UIImageView *imageViewSecond = [[UIImageView alloc] initWithCornerRadiusAdvance:20.f rectCornerType:UIRectCornerBottomLeft | UIRectCornerTopRight];
//    [imageViewSecond setFrame:CGRectMake(130, 280, 150, 150)];
//    [view addSubview:imageViewSecond];
//
//
//    UIImageView *imageViewThird = [[UIImageView alloc] initWithFrame:CGRectMake(130, 480, 150, 150)];
//    [imageViewThird zy_cornerRadiusAdvance:20.f rectCornerType:UIRectCornerBottomRight | UIRectCornerTopLeft];
//    [imageViewThird zy_attachBorderWidth:5.f color:[UIColor blackColor]];
//    [view addSubview:imageViewThird];
//
//
//    imageView.image = [UIImage imageNamed:@"mac_dog"];
//    imageViewSecond.image = [UIImage imageNamed:@"mac_dog"];
//    imageViewThird.image = [UIImage imageNamed:@"mac_dog"];
    
    
//    UIView *view02 = [UIView new];
//    view02.backgroundColor = [UIColor orangeColor];
//    view02.frame = CGRectMake(100, 200, 100, 100);
//    [self.view addSubview:view02];
//
//    CGFloat cRad = 4;
//    view02.layer.cornerRadius = cRad;
//
//    //路径阴影
//    CGFloat rad = 20;
//    CGFloat width = 100;
    
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path moveToPoint:CGPointMake(-rad, -rad)];
//    //添加直线
//    [path addLineToPoint:CGPointMake(width + rad, -rad)];
//    [path addLineToPoint:CGPointMake(width + rad, width/2)];
//    [path addLineToPoint:CGPointMake(-rad, width/2)];
//    [path addLineToPoint:CGPointMake(-rad, -rad)];
    
//    CGRect shadowRect = CGRectMake(-rad, -rad, width+rad*2, width+rad*2);
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:shadowRect cornerRadius:4.0];
    
//    [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:0.2]
    //设置阴影路径
//    view02.layer.shadowPath = path.CGPath;
//    view02.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:44/255.0 blue:138/255.0 alpha:0.5].CGColor;
//    view02.layer.shadowOffset = CGSizeMake(0,0);
//    view02.layer.shadowOpacity = 1;
//    view02.layer.shadowRadius = 20;
    
}



- (void)addShadowToView:(UIView *)view path:(UIBezierPath *)path shadowWidth:(CGFloat)sWid cornerRadius:(CGFloat)cRad color:(UIColor *)color {
    view.layer.cornerRadius = cRad;
    //设置阴影路径
    view.layer.shadowPath = path.CGPath;
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOffset = CGSizeMake(0,0);
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = cRad;
}

- (void)addShadowToView:(UIView *)theView color:(UIColor *)theColor radius:(CGFloat)rad {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);
    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
    theView.layer.shadowRadius = rad;
}

- (void)click {
    RZLog(@"%s", __func__);
}

@end

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
    
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreeWith, kScreeHeight-kRZTopHeight-kRZBottomHeight)];
    view.backgroundColor = RZ_LightGray_Color;
    view.contentSize = CGSizeMake(kScreeWith, kScreeHeight*10);
    [self.view addSubview:view];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.left = 50;
    btn.top = 15;
    btn.width = 70;
    btn.height = 70;
    btn.clickLimitInterval = 2;
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
//    [btn jm_setCornerRadius:5.f withImage:[UIImage imageNamed:@"mac_dog"]];
    [btn jm_setJMRadius:JMRadiusMake(0, 0, 0, 8) withImage:[UIImage imageNamed:@"mac_dog"]];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithRoundingRectImageView];
    [imageView setFrame:CGRectMake(130, 80, 150, 150)];
    [view addSubview:imageView];
    
    
    UIImageView *imageViewSecond = [[UIImageView alloc] initWithCornerRadiusAdvance:20.f rectCornerType:UIRectCornerBottomLeft | UIRectCornerTopRight];
    [imageViewSecond setFrame:CGRectMake(130, 280, 150, 150)];
    [view addSubview:imageViewSecond];
    
    
    UIImageView *imageViewThird = [[UIImageView alloc] initWithFrame:CGRectMake(130, 480, 150, 150)];
    [imageViewThird zy_cornerRadiusAdvance:20.f rectCornerType:UIRectCornerBottomRight | UIRectCornerTopLeft];
    [imageViewThird zy_attachBorderWidth:5.f color:[UIColor blackColor]];
    [view addSubview:imageViewThird];
    
    
    imageView.image = [UIImage imageNamed:@"mac_dog"];
    imageViewSecond.image = [UIImage imageNamed:@"mac_dog"];
    imageViewThird.image = [UIImage imageNamed:@"mac_dog"];
}

- (void)click {
    RZLog(@"%s", __func__);
}

@end

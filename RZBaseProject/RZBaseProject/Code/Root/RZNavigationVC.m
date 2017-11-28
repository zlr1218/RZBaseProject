//
//  RZNavigationVC.m
//  RZBaseProject
//
//  Created by 利基 on 2017/6/2.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZNavigationVC.h"

@interface RZNavigationVC ()

@end

@implementation RZNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[RZNavigationVC createImageWithColor:[UIColor orangeColor]] forBarMetrics:UIBarMetricsDefault];
    
    // 设置阴影
    [bar setShadowImage:[UIImage imageNamed:@"touying"]];
    
    // title 字体大小，颜色
    NSDictionary *dic = @{
                          NSFontAttributeName: [UIFont boldSystemFontOfSize:16],
                          NSForegroundColorAttributeName: [UIColor whiteColor]
                          };
    bar.titleTextAttributes =dic;
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        // 第二级修改返回按钮样式
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setImage:[[UIImage imageNamed:@"fanhuiicon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:RZ_White_Color forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 70, 30);
        // 按钮内部的所有内容 左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        /**
         width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和  边界间距为5pix，所以width设为-5时，间距正好调整为0；width为正数 时，正好相反，相当于往左移动width数值个像素
         */
        spacer.width = -5;
        
        viewController.navigationItem.leftBarButtonItems = @[spacer,leftItem];
        
        //第二级则隐藏底部Tab
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

+ (UIImage*) createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end

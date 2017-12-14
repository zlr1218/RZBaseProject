//
//  RZTabBarVC.m
//  RZBaseProject
//
//  Created by 利基 on 2017/6/2.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZTabBarVC.h"
#import "RZNavigationVC.h"
#import "RZHomeVC.h"
#import "RZMineVC.h"
#import "RZDemoVC.h"

@interface RZTabBarVC ()<UITabBarControllerDelegate>

@end

@implementation RZTabBarVC

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupTabBarController];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)setupTabBarController {
    // 1. 首页
    RZHomeVC *homeVC = [[RZHomeVC alloc] init];
    [self addViewController:homeVC title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    // 2. 订单页
    RZDemoVC *demoVC = [[RZDemoVC alloc] init];
    [self addViewController:demoVC title:@"演示" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    // 3. 还款页
    RZMineVC *mineVC = [[RZMineVC alloc] init];
    [self addViewController:mineVC title:@"我的" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    // 默认显示第几个界面
    self.selectedViewController = [self.viewControllers objectAtIndex:2];
    
    
    //去除 TabBar 自带的顶部阴影
    // 图片翻转
    UIImage *img = [UIImage imageWithCGImage:[[UIImage imageNamed:@"touying"] CGImage] scale:1 orientation:UIImageOrientationDown];
    [[UITabBar appearance] setShadowImage:img];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
}

- (void)addViewController:(UIViewController *)vc
                    title:(NSString *)title
                    image:(NSString *)image
            selectedImage:(NSString *)seletedImage {
    
    // 1. 设置标题
    vc.title = title;
    
    // 2. 做导航视图控制器
    RZNavigationVC *nav = [[RZNavigationVC alloc] initWithRootViewController:vc];
    
    UIImage *imageNormal = [UIImage imageNamed:image];
    imageNormal = [self originalImage:imageNormal];
    
    UIImage *imageSeleted = [UIImage imageNamed:seletedImage];
    imageSeleted = [self originalImage:imageSeleted];
    
    // 3.
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:imageNormal selectedImage:imageSeleted];
    
    // 4.
    [self addChildViewController:nav];
    
    // 1.设置tabbar选中颜色，未选中为默认灰色
    self.tabBar.tintColor = RZ_Them_greenColor;
    
    /*
     // 2.设置选中和未选中
     [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateNormal];
     [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} forState:UIControlStateSelected];
     */
    
    [[UITabBar appearance] setBackgroundColor:RZ_White_Color];
    
    self.delegate = self;
}
//禁止tab多次点击
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    UIViewController *tbselect=tabBarController.selectedViewController;
    if([tbselect isEqual:viewController]){
        return NO;
    }
    return YES;
}

#pragma mark ------originalImage------
- (UIImage *)originalImage:(UIImage *)image {
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return image;
}



@end

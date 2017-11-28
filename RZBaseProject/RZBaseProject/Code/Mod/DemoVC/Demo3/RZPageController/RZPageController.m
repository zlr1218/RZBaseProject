//
//  RZPageController.m
//  RZBaseProject
//
//  Created by 赵林瑞 on 16/11/4.
//  Copyright © 2016年 RZOL. All rights reserved.
//

#import "RZPageController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface RZPageController ()

@end

@implementation RZPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    
    self.view.backgroundColor = RZ_Orange_Color;
    
}

@end

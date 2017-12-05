//
//  RZDemoVC.m
//  RZBaseProject
//
//  Created by 利基 on 2017/6/2.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZDemoVC.h"
#import "RZDemo3VC.h"

#import "UIView+RoundedCorner.h"

@interface RZDemoVC ()

@end

@implementation RZDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView *view01 = [[UIView alloc] initWithFrame:CGRectMake(20, 200, 40, 40)];
    [view01 jm_setCornerRadius:13 withBorderColor:[UIColor orangeColor] borderWidth:2];
    [self.view addSubview:view01];
}

- (IBAction)PushToPageControllerAction:(id)sender {
    [self.navigationController pushViewController:[RZDemo3VC new] animated:YES];
}

@end

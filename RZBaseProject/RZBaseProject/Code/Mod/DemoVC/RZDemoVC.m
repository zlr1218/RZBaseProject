//
//  RZDemoVC.m
//  RZBaseProject
//
//  Created by 利基 on 2017/6/2.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZDemoVC.h"
#import "RZDemo3VC.h"

@interface RZDemoVC ()

@end

@implementation RZDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)PushToPageControllerAction:(id)sender {
    [self.navigationController pushViewController:[RZDemo3VC new] animated:YES];
}

@end

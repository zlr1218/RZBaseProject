//
//  RZInterviewVC.m
//  RZBaseProject
//
//  Created by Apple on 2020/11/3.
//  Copyright © 2020 RZOL. All rights reserved.
//

#import "RZInterviewVC.h"

@interface RZInterviewVC ()

@end

@implementation RZInterviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - 本地存储

- (void)storeAction {
    // NSUserDefaults
    [[NSUserDefaults standardUserDefaults] setValue:@"我是要成为海贼王的男人" forKey:@"key1"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //
}

@end

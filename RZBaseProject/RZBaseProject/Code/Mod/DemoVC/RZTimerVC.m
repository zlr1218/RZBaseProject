//
//  RZTimerVC.m
//  RZBaseProject
//
//  Created by 技术平台开发部 on 2021/4/2.
//  Copyright © 2021 RZOL. All rights reserved.
//

#import "RZTimerVC.h"

@interface RZTimerVC ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation RZTimerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTimer];
}

- (void)setupTimer {
    // 创建并自动开启
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timerAction1) userInfo:nil repeats:NO];
}
- (void)timerAction1 {
    NSLog(@"1111111");
}

@end

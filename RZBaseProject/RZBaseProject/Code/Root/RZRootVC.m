//
//  RZRootVC.m
//  RZBaseProject
//
//  Created by 利基 on 2017/6/2.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZRootVC.h"

@interface RZRootVC ()

@end

@implementation RZRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (dispatch_group_t)threadGroup {
    if (!_threadGroup) {
        _threadGroup = dispatch_group_create();
    }
    return _threadGroup;
}

@end

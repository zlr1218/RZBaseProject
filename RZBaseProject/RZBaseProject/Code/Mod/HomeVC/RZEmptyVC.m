//
//  RZEmptyVC.m
//  RZBaseProject
//
//  Created by Apple on 2020/4/11.
//  Copyright © 2020 RZOL. All rights reserved.
//

#import "RZEmptyVC.h"

@interface RZEmptyVC ()

@end

@implementation RZEmptyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)other {
    RZLog(@"执行了other方法");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(test)) {
        Method m = class_getInstanceMethod(self, @selector(other));
        class_addMethod(self, sel, method_getImplementation(m), method_getTypeEncoding(m));
    }
    return [super resolveInstanceMethod:sel];
}

@end

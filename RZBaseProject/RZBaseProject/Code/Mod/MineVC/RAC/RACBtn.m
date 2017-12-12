//
//  RACBtn.m
//  RZBaseProject
//
//  Created by 利基 on 2017/12/11.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RACBtn.h"

@interface RACBtn ()

/** btn */
@property (nonatomic, strong) UIButton *btn;

@end

@implementation RACBtn

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.btn];
    }
    return self;
}

- (void)btnAction {
    [_btnSignal sendNext:@"click the btn"];
}

- (RACSubject *)btnSignal {
    if (!_btnSignal) {
        _btnSignal = [RACSubject subject];
    }
    return _btnSignal;
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(10, 10, 70, 30);
        [_btn setTitle:@"点我啊" forState:UIControlStateNormal];
        [_btn setBackgroundColor:[UIColor orangeColor]];
        [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

@end

//
//  RZLoginViewModel.m
//  RZBaseProject
//
//  Created by 利基 on 2017/12/12.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZLoginViewModel.h"

@implementation RZLoginViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup {
    // 处理登录点击的信号
    _loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self, account), RACObserve(self, pwd)] reduce:^id (NSString *account, NSString *pwd){
        return @(account.length && pwd.length);
    }];
    
    //
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            // 发送数据
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:[NSString stringWithFormat:@"%@ +++ %@", _account, _pwd]];
                [subscriber sendCompleted];
            });
            
            return nil;
        }];
    }];
    
    // 获取命令中的信号源
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        RZLog(@"%@", x);
    }];
    
    // 监听命令执行过程
    // 一开始就执行了一次，需要跳过一次
    [[_loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue] == YES) {
            // 正在执行
            RZLog(@"正在执行");
        }else{
            // 没有执行/执行完成
            RZLog(@"执行完成");
        }
    }];
}

@end

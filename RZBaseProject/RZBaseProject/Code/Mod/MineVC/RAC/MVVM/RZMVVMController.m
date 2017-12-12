//
//  RZMVVMController.m
//  RZBaseProject
//
//  Created by 利基 on 2017/12/12.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZMVVMController.h"
#import "ReactiveObjC.h"

#import "RZLoginViewModel.h"

@interface RZMVVMController ()

@property (weak, nonatomic) IBOutlet UITextField *accountFiled;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

/** viewModel */
@property (nonatomic, strong) RZLoginViewModel *loginVM;

@end

@implementation RZMVVMController

- (RZLoginViewModel *)loginVM {
    if (!_loginVM) {
        _loginVM = [[RZLoginViewModel alloc] init];
    }
    return _loginVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     MVVM 模型
     */
    
    [self signalAction];
}

- (void)signalAction {
    RACSignal *loginEnableSignal = [RACSignal combineLatest:@[_accountFiled.rac_textSignal, _pwdField.rac_textSignal] reduce:^id(NSString *account, NSString *pwd) {
        return @(account.length && pwd.length);
    }];
    
    // 设置登录按钮是否可用
    RAC(_loginBtn, enabled) = loginEnableSignal;
    
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            // 发送数据
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@"请求登录的数据"];
                [subscriber sendCompleted];
            });
            
            return nil;
        }];
    }];
    
    // 获取命令中的信号源
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        RZLog(@"%@", x);
    }];
    
    // 监听命令执行过程
    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue] == YES) {
            // 正在执行
            RZLog(@"正在执行");
        }else{
            // 执行完成
            RZLog(@"执行完成");
        }
    }];
    
    // 监听登录按钮点击
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        RZLog(@"点击了登录按钮");
        
        // 处理登录事件
        [command execute:nil];
    }];
}

@end

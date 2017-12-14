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
#import "RZRequestViewModel.h"

@interface RZMVVMController ()

@property (weak, nonatomic) IBOutlet UITextField *accountFiled;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

/** viewModel */
@property (nonatomic, strong) RZLoginViewModel *loginVM;

/** requestVM */
@property (nonatomic, strong) RZRequestViewModel *requestVM;

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
    
    [self MVVM_Request];
    
    // MVVM 模型
//    [self MVVM];
    
    // RAC + 登录的处理
//    [self signalAction];
}

#pragma mark - MVVM 网络请求

- (void)MVVM_Request {
    self.requestVM = [[RZRequestViewModel alloc] init];
    RACSignal *signal = [self.requestVM.requestCommand execute:nil];
    [signal subscribeNext:^(id  _Nullable x) {
        RZLog(@"%@", x[@"books"][0]);
    }];
}

#pragma mark - MVVM 模型

- (void)MVVM {
    // 每一个控制器 都对应 一个VM模型
    // VM模型 最好不要包含 视图
    
    [self bindViewModel];
    [self loginEvent];
}

- (void)bindViewModel {
    // 绑定信号
    RAC(self.loginVM, account)  = _accountFiled.rac_textSignal;
    RAC(self.loginVM, pwd) = _pwdField.rac_textSignal;
}

- (void)loginEvent {
    RAC(_loginBtn, enabled) = self.loginVM.loginEnableSignal;
    
    // 监听登录按钮点击
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        RZLog(@"点击了登录按钮");
        
        // 处理登录事件
        [self.loginVM.loginCommand execute:nil];
    }];
}

#pragma mark - RAC + 登录的处理

- (void)signalAction {
    // combineLatest 将多个信号合并起来，并且拿到每个信号的最新值，才会出发合并的信号
    RACSignal *loginEnableSignal = [RACSignal combineLatest:@[_accountFiled.rac_textSignal, _pwdField.rac_textSignal] reduce:^id (NSString *account, NSString *pwd){
        return @(account.length && pwd.length);
    }];
    
    // 设置登录按钮是否可用
    RAC(_loginBtn, enabled) = loginEnableSignal;
    
    
    // 监听按钮的点击
    
    
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            // 发送数据
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:[NSString stringWithFormat:@"%@ +++ %@", _accountFiled.text, _pwdField.text]];
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
    // 一开始就执行了一次，需要跳过一次
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue] == YES) {
            // 正在执行
            RZLog(@"正在执行");
        }else{
            // 没有执行/执行完成
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

//
//  RACViewController.m
//  RZBaseProject
//
//  Created by 利基 on 2017/12/11.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RACViewController.h"

#import "ReactiveObjC.h"
#import "NSObject+RACKVOWrapper.h"

#import "RACBtn.h"
#import "UIView+Toast.h"

@interface RACViewController ()

/** subscribe */
@property (nonatomic, strong) id<RACSubscriber> subscriber;

/** disposable */
@property (nonatomic, strong) RACDisposable *disposable;

/** btnView */
@property (nonatomic, strong) RACBtn *btnView;

@end

@implementation RACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
//    [self makeSignal];
    
//    [self makeSignal02];
    
//    [self makeSignal03];
    
//    [self makeSignal04];
    
    [self RAC_Replace_Delegate];
}


#pragma mark - RAC 替换 代理
- (void)RAC_Replace_Delegate {
    RACBtn *BtnView = [[RACBtn alloc] initWithFrame:CGRectMake(50, 200, 100, 100)];
    [self.view addSubview:BtnView];
    [BtnView.btnSignal subscribeNext:^(id  _Nullable x) {
        [self.view makeRZToast:x];
    }];
}

#pragma mark - RACReplaySubject
- (void)makeSignal04 {
    // 可以先发送信号，在订阅信号
    // 创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    // 订阅信号
    [replaySubject subscribeNext:^(id  _Nullable x) {
        [self.view makeRZToast:x];
    }];
    
    // 发送信号
    [replaySubject sendNext:@"data"];
}

#pragma mark - RACSubject
- (void)makeSignal03 {
    // 1 创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 2 订阅信号
    /**
     不同的信号，订阅信号处理信号的方式是不一样的
     
     RACCompoundDisposable *disposable = [RACCompoundDisposable compoundDisposable];
     subscriber = [[RACPassthroughSubscriber alloc] initWithSubscriber:subscriber signal:self disposable:disposable];
     
     NSMutableArray *subscribers = self.subscribers;
     @synchronized (subscribers) {
     [subscribers addObject:subscriber];
     }
     
     
     */
    [subject subscribeNext:^(id  _Nullable x) {
        [self.view makeRZToast:x];
    }];
    
    // 3 发送信号
    /**
     
     - (void)enumerateSubscribersUsingBlock:(void (^)(id<RACSubscriber> subscriber))block {
     NSArray *subscribers;
     @synchronized (self.subscribers) {
     subscribers = [self.subscribers copy];
     }
     
     for (id<RACSubscriber> subscriber in subscribers) {
     block(subscriber);
     }
     }
     
     
     */
    [subject sendNext:@"data"];
}

#pragma mark - 取消订阅信号 RACDisposable
- (void)makeSignal02 {
    // 1 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 对subscriber强引用（主要用来模拟，手动取消订阅）
        _subscriber = subscriber;
        
        // 3 发送信号
        [subscriber sendNext:@"data"];
        
        return [RACDisposable disposableWithBlock:^{
            // 默认只要信号发送数据完毕就会自动取消订阅
            // 只要取消订阅就执行这个block
            // 清空资源
            [self.view makeRZToast:@"信号被取消订阅了"];
        }];
    }];
    
    // 2 订阅信号
    self.disposable = [signal subscribeNext:^(id  _Nullable x) {
        RZLog(@"%@", x);
        [self.view makeRZToast:x];
    }];
}

#pragma mark - RACSignal
- (void)makeSignal {
    /**
     RAC中常用的类
     1、RACSignal
     使用步骤：创建信号、订阅信号、发送信号
     
     底层理解：
     1、创建一个signal，并绑定一个didSubscribe的block代码块，不过这个时候并没有执行这个block
     RACDynamicSignal *signal = [[self alloc] init];
     signal->_didSubscribe = [didSubscribe copy];
     
     2、订阅信号本质是 创建一个指向signal的RACSubscriber，并且给这个subscriber绑定一个叫nextBlock的代码块，也暂时没有执行
     RACSubscriber *o = [RACSubscriber subscriberWithNext:nextBlock error:NULL completed:NULL];
     return [self subscribe:o];
     
     3、signal执行didSubscribe这个block， == [RACDynamicSignal subscribe:o];
     
     4、拿到subscriber并调用绑定的nextBlock
     */
    
    // 1、创建信号（冷信号）
    RACDisposable * (^didSubscribe)(id<RACSubscriber>  _Nonnull subscriber) = ^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // didSubscribe调用：只要信号被订阅就会调用这个block，
        // 作用：发送信号
        // 3、发送信号
        [subscriber sendNext:@"Data"];
        
        return nil;
    };
    
    RACSignal *signal = [RACSignal createSignal:didSubscribe];
    
    // 2、订阅信号（热信号）
    [signal subscribeNext:^(id  _Nullable x) {
        // 只要订阅者发送信号，就会执行这个BLock
        RZLog(@"%@", x);
    }];
}

- (void)setupUI {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 50, 100, 100);
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    [btn setTitle:@"touch me" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(touchEvent) forControlEvents:UIControlEventTouchUpInside];
}
- (void)touchEvent {
    // 手动取消订阅
    [self.disposable dispose];
}

@end

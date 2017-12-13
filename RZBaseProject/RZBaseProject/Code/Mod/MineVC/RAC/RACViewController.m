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

#import "RACObject.h"

@interface RACViewController ()

/** subscribe */
@property (nonatomic, strong) id<RACSubscriber> subscriber;

/** disposable */
@property (nonatomic, strong) RACDisposable *disposable;

/** btnView */
@property (nonatomic, strong) RACBtn *btnView;

/** btn */
@property (nonatomic, strong) UIButton *btn;

/** field */
@property (nonatomic, strong) UITextField *field;

/** signal */
@property (nonatomic, strong) RACSignal *signal;

@end

@implementation RACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
//    [self makeSignal];
    
//    [self makeSignal02];
    
//    [self makeSignal03];
    
//    [self makeSignal04];
    
//    [self RAC_Replace_Delegate];
    
//    [self RAC_Replace_KVO];
    
//    [self monitorEvent];
    
//    [self replaceNotification];
    
//    [self RACSequenceAction];
    
//    [self lifeSelectorEvent];
    
//    [self customMacro];
    
//    [self RACMulticastConnectionEvent];
    
//    [self RACCommandEvent];
    
    [self bindMethod];
}

#pragma mark - bind signal

- (void)bindMethod {
    RACSubject *subject = [RACSubject subject];
    
}

#pragma mark - RACCommand

- (void)RACCommandEvent {
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        // input: command执行命令传入的数据
        RZLog(@"%@", input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            // 发送数据
            [subscriber sendNext:@"执行命令产生的数据"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    // 这里又两种方式订阅信号
    // 方式一：
//    // 执行命令
//    RACSignal *signal = [command execute:@"data"];
//
//    // 订阅信号
//    [signal subscribeNext:^(id  _Nullable x) {
//        RZLog(@"%@", x);
//    }];
    
    // 方式二：
    // switchToLatest 获取信号中的发送的最新信号
//    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        RZLog(@"%@", x);
//    }];
    
    /**
     订阅信号 executionSignals: 信号源，信号中信号，signalOfSignals：信号：发送数据就是信号
     
     [command.executionSignals subscribeNext:^(RACSignal * x) {
     
     [x subscribeNext:^(id  _Nullable x) {
     RZLog(@"%@", x);
     }];
     
     }];
     
     */
    
    
    // 监听事件有没有完成
    [command.executing subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue] == YES) {
            RZLog(@"执行完成");
        }
    }];
    
    // 执行命令
    [command execute:@"data"];
}

#pragma mark - RACMulticastConnection

- (void)RACMulticastConnectionEvent {
    /**
     
     RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
     
     // 请求数据
     RZLog(@"请求数据");
     
     // 发送数据
     [subscriber sendNext:@"hotData"];
     
     return nil;
     }];
     
     [signal subscribeNext:^(id  _Nullable x) {
     RZLog(@"订阅者一：%@", x);
     }];
     
     [signal subscribeNext:^(id  _Nullable x) {
     RZLog(@"订阅者二：%@", x);
     }];
     
     */
    
    
    // 每次订阅都会请求一次数据，这样没必要，只需要请求一次数据就OK了
    
    // 不管订阅多少次，就会请求一次
    // RACMulticastConnection
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 请求数据
        RZLog(@"请求数据");
        
        // 发送数据
        [subscriber sendNext:@"hotData"];
        
        return nil;
    }];
    
    // 把信号连接起来
    RACMulticastConnection *connection = [signal publish];
    
    // 订阅信号
    [connection.signal subscribeNext:^(id  _Nullable x) {
        RZLog(@"订阅者一：%@", x);
    }];
    
    [connection.signal subscribeNext:^(id  _Nullable x) {
        RZLog(@"订阅者二：%@", x);
    }];
    
    // 连接
    [connection connect];
}

#pragma mark - RAC中常用的宏

- (void)customMacro {
    RACBtn *BtnView = [[RACBtn alloc] initWithFrame:CGRectMake(50, 200, 100, 100)];
    [self.view addSubview:BtnView];
    _btnView = BtnView;
    
//    [_field.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
//        [_btn setTitle:x forState:UIControlStateNormal];
//    }];
    
//    RAC(_btn, titleLabel.text) = _field.rac_textSignal;
    
    // 监听_btnView的frame变化
    [RACObserve(self.btnView, frame) subscribeNext:^(id  _Nullable x) {
        RZLog(@"%@", x);
    }];
    
    // 如果不把self指针弱化，就会造成循环引用，不会调用dealoc方法
//    @weakify(self);
//    RACSignal *signal =[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        @strongify(self);
//        RZLog(@"%@", self);
//        return nil;
//    }];
//    _signal = signal;
//    [signal subscribeNext:^(id  _Nullable x) {
//
//    }];
}

#pragma mark - lifeSelector

- (void)lifeSelectorEvent {
    RACSignal *hotSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 请求数据
        [subscriber sendNext:@"hotData"];
        return nil;
    }];
    
    RACSignal *newSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 请求数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"newData"];
        });
        return nil;
    }];
    
    // 当数组中的所有信号都发送数据的时候，才会执行Selector
    // 方法的参数：必须跟数组的信号一一对应
    [self rac_liftSelector:@selector(updateUI:newData:) withSignalsFromArray:@[hotSignal, newSignal]];
}

- (void)updateUI:(NSString *)hotData newData:(NSString *)newData {
    RZLog(@"更新UI：%@ -- %@", hotData, newData);
}

#pragma mark - 代替 通知
- (void)replaceNotification {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        [self.view makeRZToast:@"键盘已经显示"];
    }];
    
    [_field.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        RZLog(@"%@", x);
    }];
}

#pragma mark - 监听事件
- (void)monitorEvent {
    [[_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self.view makeRZToast:@"点击了当前界面的 touch me 按钮"];
    }];
}

#pragma mark - 代替 KVO
- (void)RAC_Replace_KVO {
    RACBtn *BtnView = [[RACBtn alloc] initWithFrame:CGRectMake(50, 200, 100, 100)];
    [self.view addSubview:BtnView];
    self.btnView = BtnView;
    
//    [BtnView rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionNew observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
//        RZLog(@"%@", value);
//    }];
    
    [[BtnView rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id  _Nullable x) {
        RZLog(@"%@", x);
    }];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.btnView.frame = CGRectMake(50, 350, 100, 100);
}

#pragma mark - RAC中的集合类
- (void)RACSequenceAction {
    // 元组 类似NSArray 用来包装值
//    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"123", @"33", @7]];
//    NSLog(@"%@", tuple[1]);
    
    /**
     
     // RACSequence 集合
     NSArray *arr = @[@"123", @"33", @7];
     RACSequence *sequence = arr.rac_sequence;
     
     // 把集合转成信号
     RACSignal *signal = sequence.signal;
     
     // 订阅集合信号，内部会自动遍历所有的元素
     [signal subscribeNext:^(id  _Nullable x) {
     RZLog(@"%@", x);
     }];
     
     
     
     
     
     
     NSArray *arr = @[@"123", @"33", @7];
     // 遍历数组
     [arr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
     RZLog(@"%@", x);
     }];
     
     */
    
    
    
    
    /**
     NSDictionary *dict = @{@"account":@"222", @"name":@"luffy"};
     // 遍历字典
     [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
     // 以下这两种方式都可以
     RZLog(@"%@ - %@", x[0], x[1]);
     
     // 宏里面的参数：需要解析出来的变量名
     // = 右边：需要解析的元组
     RACTupleUnpack(NSString *key, NSString *value) = x;
     RZLog(@"%@ - %@", key, value);
     }];
     */
    
    
    // 高级用法
    NSArray *arr02 = @[@{@"account":@"222", @"name":@"luffy"}, @{@"account":@"666", @"name":@"namy"}];
    NSArray *arr03 = [[arr02.rac_sequence map:^id _Nullable(id  _Nullable value) {
        return [RACObject objectWithDict:value];
    }] array];
    [arr03.rac_sequence.signal subscribeNext:^(RACObject * x) {
        RZLog(@"%@", x.account);
    }];
}

#pragma mark - RAC 替换 代理
- (void)RAC_Replace_Delegate {
    RACBtn *BtnView = [[RACBtn alloc] initWithFrame:CGRectMake(50, 200, 100, 100)];
    [self.view addSubview:BtnView];
    
    /**
     [BtnView.btnSignal subscribeNext:^(id  _Nullable x) {
     [self.view makeRZToast:x];
     }];
     */
    
//    [[self rac_signalForSelector:@selector(didReceiveMemoryWarning)] subscribeNext:^(RACTuple * _Nullable x) {
//        RZLog(@"控制器调用了didReceiveMemoryWarning");
//    }];
    
    [[BtnView rac_signalForSelector:@selector(btnAction)] subscribeNext:^(RACTuple * _Nullable x) {
        RZLog(@"控制器知道按钮被点击");
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
    _btn = btn;
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(200, 50, 100, 45)];
    [self.view addSubview:field];
    field.borderStyle = UITextBorderStyleLine;
    field.placeholder = @"请输入";
    _field = field;
}
- (void)touchEvent {
    // 手动取消订阅
    [self.disposable dispose];
    
    _btnView.frame = CGRectMake(50, 350, 100, 100);
}

- (void)dealloc {
    RZLog(@"%s", __func__);
}

@end

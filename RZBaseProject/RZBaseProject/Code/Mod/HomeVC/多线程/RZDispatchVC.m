//
//  RZDispatchVC.m
//  RZBaseProject
//
//  Created by 瑞仔 on 2018/7/8.
//  Copyright © 2018年 RZOL. All rights reserved.
//

#import "RZDispatchVC.h"

@interface RZDispatchVC ()

@end

@implementation RZDispatchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"iOS多线程";
    
    
    UIButton *btn01 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn01 setFrame:CGRectMake(50, 150, 220, 50)];
    [self.view addSubview:btn01];
    [btn01 setBackgroundColor:RZ_Orange_Color];
    [btn01 setTitle:@"线程间的通信" forState:UIControlStateNormal];
    [btn01 addTarget:self action:@selector(btnAction01) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn02 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn02 setFrame:CGRectMake(50, 50, 220, 50)];
    [self.view addSubview:btn02];
    [btn02 setBackgroundColor:RZ_Orange_Color];
    [btn02 setTitle:@"多线程之GCD" forState:UIControlStateNormal];
    [btn02 addTarget:self action:@selector(btnAction02) forControlEvents:UIControlEventTouchUpInside];
    
    
}

// 线程间的通信
- (void)btnAction01 {
    
}

/*
 在GCD中有两个非常重要的概念:任务(task) 队列(queue)
 
 任务: 就是操作,你想要干什么,也就是Block代码块。任务有两种知行方式：同步执行　和　异步执行，区别就是是否会阻塞当前线程。
 
 队列：用于存放任务，有两种队列，串行队列　和　并发队列
 
 结论：
 1、只有异步执行才具备开启新的线程的能力，任务加入串行队列会开启一条新的线程。
 2、同步执行函数不具备开启线程的能力，所以任务加入并发队列也是在当前线程串行执行
 */
- (void)btnAction02 {
    // 异步执行函数 + 串行队列
    //    [self asyncAndSerial];
    
    // 异步执行函数 + 并发队列
    //    [self asyncAndConcurrent];
    
    // 同步执行函数 + 串行队列
    //    [self syncAndSerial];
    
    // 同步执行函数 + 并发队列
    //    [self syncAndConcurrent];
    
    // 同步执行函数 + 主队列
    //    [self syncAndMainQueue];
    
    // 异步执行函数 + 主队列
    [self asyncAndMainQueue];
}

/*
 异步函数 + 串行队列
 运行结果：开启了一条新线程（number = 3），任务是串行的
 function:-[RZDispatchVC asyncAndSerial]_block_invoke
 line:59 content: -> 01 - <NSThread: 0x1700798c0>{number = 3, name = (null)}
 
 function:-[RZDispatchVC asyncAndSerial]_block_invoke_2
 line:63 content: -> 02 - <NSThread: 0x1700798c0>{number = 3, name = (null)}
 
 function:-[RZDispatchVC asyncAndSerial]_block_invoke_3
 line:67 content: -> 02 - <NSThread: 0x1700798c0>{number = 3, name = (null)}
 */
- (void)asyncAndSerial {
    // 串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.rzol.dispatch", DISPATCH_QUEUE_SERIAL);
    
    // 将异步任务加入串行队列
    dispatch_async(queue, ^{
        RZLog(@"01 - %@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        RZLog(@"02 - %@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        RZLog(@"02 - %@", [NSThread currentThread]);
    });
}

// 异步执行 + 并发队列
// 运行结果：同时开启多条线程，任务是并发（同时）执行的
- (void)asyncAndConcurrent {
    // 1、创建并发队列
    // 1.1、自己创建的并发队列
    //dispatch_queue_t queue_self = dispatch_queue_create("com.rzol.dispatch", DISPATCH_QUEUE_CONCURRENT);
    // 1.2、GCD默认提供了全局并发队列
    dispatch_queue_t queue_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 2、将异步执行的任务添加到并发队列中
    dispatch_async(queue_global, ^{
        for (NSInteger i = 0; i < 10; i++) {
            RZLog(@"01 -- %@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue_global, ^{
        for (NSInteger i = 0; i < 10; i++) {
            RZLog(@"02 -- %@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue_global, ^{
        for (NSInteger i = 0; i < 10; i++) {
            RZLog(@"03 -- %@", [NSThread currentThread]);
        }
    });
    
    RZLog(@"--- end ---");
}


// 同步执行函数 + 串行队列
/*
 运行结果：在主线程执行串行执行任务
 function:-[RZDispatchVC syncAndSerial]_block_invoke
 line:95 content: -> 01 -- <NSThread: 0x1740669c0>{number = 1, name = main}
 
 function:-[RZDispatchVC syncAndSerial]_block_invoke_2
 line:99 content: -> 02 -- <NSThread: 0x1740669c0>{number = 1, name = main}
 */
- (void)syncAndSerial {
    dispatch_queue_t queue = dispatch_queue_create("com.rzol.dispatch02", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
       RZLog(@"01 -- %@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        RZLog(@"02 -- %@", [NSThread currentThread]);
    });
}

// 同步执行函数 + 并发队列
/*
 运行结果：没有开启新的线程，只在主线程上执行任务，一个执行完在执行另一个
 function:-[RZDispatchVC syncAndConcurrent]_block_invoke
 line:123 content: -> 01 -- <NSThread: 0x170067a80>{number = 1, name = main}
 
 function:-[RZDispatchVC syncAndConcurrent]_block_invoke_2
 line:127 content: -> 02 -- <NSThread: 0x170067a80>{number = 1, name = main}
 
 function:-[RZDispatchVC syncAndConcurrent]_block_invoke_3
 line:131 content: -> 03 -- <NSThread: 0x170067a80>{number = 1, name = main}
 */
- (void)syncAndConcurrent {
    // 并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 同步执行任务
    dispatch_sync(queue, ^{
        RZLog(@"01 -- %@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        RZLog(@"02 -- %@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        RZLog(@"03 -- %@", [NSThread currentThread]);
    });
}

/*
 同步执行函数 + 主队列
 运行结果: 阻塞主线程直接崩溃，原因是产生死锁，
 主队列当前有两个任务：syncAndMainQueue；还有RZLog
 主队列正在执行syncAndMainQueue，执行syncAndMainQueue必须要执行RZLog；
 主队列现在要执行RZLog，因为是串行队列就要等syncAndMainQueue执行完成才可以执行RZLog，这样就产生了死锁
 */
- (void)syncAndMainQueue {
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        RZLog(@"01 -- %@", [NSThread currentThread]);
    });
}

/*
 异步执行函数 + 主队列
 运行结果：不会阻塞主线程，不会产生死锁
 */
- (void)asyncAndMainQueue {
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        RZLog(@"01 -- %@", [NSThread currentThread]);
    });
}

@end

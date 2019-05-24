//
//  RZRequestViewModel.m
//  RZBaseProject
//
//  Created by 利基 on 2017/12/14.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZRequestViewModel.h"
#import "RZNetManager.h"

@implementation RZRequestViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupRequestCommand];
    }
    return self;
}

- (void)setupRequestCommand {
    
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        // 执行命令时就会调用这个block
        RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSString *urlString = @"https://www.apiopen.top/journalismApi";
            
            [RZNetManager rz_requestWithType:RZHttpRequestTypeGet path:urlString parameters:nil success:^(id response) {
                
                [subscriber sendNext:response];
                [subscriber sendCompleted];
                
            } failed:^(NSError *error) {
                RZLog(@"%@", error);
                [subscriber sendNext:error];
                [subscriber sendCompleted];
            } progress:nil];
            
            return nil;
        }];
        
        
        return signal;
    }];
    
}

@end

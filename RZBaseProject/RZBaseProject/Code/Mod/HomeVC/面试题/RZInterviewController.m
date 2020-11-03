//
//  RZInterviewController.m
//  RZBaseProject
//
//  Created by Apple on 2020/11/3.
//  Copyright © 2020 RZOL. All rights reserved.
//

#import "RZInterviewController.h"
#import "RZMan.h"

@interface RZInterviewController ()

@end

@implementation RZInterviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((kScreeWith-200)/2.0, 200, 200, 48);
    [self.view addSubview:btn];
    [btn setTitle:@"点击添加10条数据" forState:UIControlStateNormal];
    [btn setTitleColor:RZ_Black_Color forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(BGFMDBAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)BGFMDBAction {
    
    BOOL ret = [NSArray bg_isExistForTableName:@"luffy"];
    if (ret) {
        RZMan *man = [[RZMan alloc] init];
        man.name = @"索隆";
        man.bg_tableName = @"luffy";
        [man bg_save];
    }
    RZLog(@"%@", [RZMan bg_findAll:@"luffy"]);
    
//    NSMutableArray *objs = [NSMutableArray array];
//    for (NSInteger i = 0; i < 10; i++) {
//        RZMan *man = [[RZMan alloc] init];
//        if (i == 3) {
//            man.name = @"张三";
//        } else {
//            man.name = @"李四";
//        }
//        [objs addObject:man];
//    }
//    [objs bg_saveArrayWithName:@"objs"];
    
//    [NSArray bg_drop:@"objs"];
    
    if ([NSArray bg_isExistForTableName:@"objs"]) {
        RZMan *man = [[RZMan alloc] init];
        man.name = @"索隆";
        [NSArray bg_addObjectWithName:@"objs" object:man];
    }
    NSArray *result = [NSArray bg_arrayWithName:@"objs"];
    RZLog(@"%@\n%@", result, [result.lastObject valueForKeyPath:@"name"]);
}

@end

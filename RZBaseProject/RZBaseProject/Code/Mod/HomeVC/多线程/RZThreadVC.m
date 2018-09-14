//
//  RZThreadVC.m
//  RZBaseProject
//
//  Created by os on 2018/8/3.
//  Copyright © 2018年 RZOL. All rights reserved.
//

#import "RZThreadVC.h"

@interface RZThreadVC ()<UITableViewDelegate, UITableViewDataSource>

/* threadTableView */
@property (nonatomic, strong) UITableView *threadTableView;

/* titleArray */
@property (nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation RZThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"多线程";
    [self.view addSubview:self.threadTableView];
    
    RZLog(@"%@", [NSThread currentThread]);
}

#pragma mark - Thread 多线程

- (void)createThread {
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(task:) object:@"value"];
//    [thread start];
    
//    [NSThread detachNewThreadSelector:@selector(task:) toTarget:self withObject:@"value"];
    
    [self performSelectorInBackground:@selector(task:) withObject:@"new thread"];
//    [self performSelectorOnMainThread:@selector(task:) withObject:@"new thread" waitUntilDone:YES];
}

- (void)task:(id)value {
    for (int i = 0; i < 100; i++) {
        RZLog(@"第 %d 次打印%@ -- %@", i, value, [NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    }
}

#pragma mark - 代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titleArray[section][@"arr"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = RZ_BGGrayColor;
    
    if (self.titleArray.count > 0) {
        cell.textLabel.text = self.titleArray[indexPath.section][@"arr"][indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreeWith, 50)];
    title.text = self.titleArray[section][@"title"];
    return title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            [self createThread];
        }
            break;

        default:
            break;
    }
}

#pragma mark - lazy load

- (UITableView *)threadTableView {
    if (!_threadTableView) {
        _threadTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreeWith, kScreeHeight) style:UITableViewStylePlain];
        _threadTableView.delegate = self;
        _threadTableView.dataSource = self;
        _threadTableView.tableFooterView = [UIView new];
    }
    return _threadTableView;
}

- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
        
        NSArray *arr01 = @[@"1、创建（init）启动（start）", @"2、detachNewThreadSelector", @"3、performSelectorInBackground", @"4、currentThread", @"5、performSelector:onThread:", @"6、强制退出线程：exit", @"7、 sleepForTimeInterval 阻塞线程"];
        [_titleArray addObject:@{@"title": @"Thread 多线程",
                                 @"arr": arr01}];
    }
    return _titleArray;
}

@end

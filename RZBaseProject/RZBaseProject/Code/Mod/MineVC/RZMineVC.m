//
//  RZMineVC.m
//  RZBaseProject
//
//  Created by 利基 on 2017/7/27.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZMineVC.h"
#import "RZDataSource.h"
#import "RZDelegate.h"
#import "UIView+Toast.h"

@interface RZMineVC ()
{
    UITableView *_tableView;
    RZDataSource *_dataSource;
    RZDelegate *_delegate;
}

@end

@implementation RZMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreeWith, kScreeHeight-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    NSArray *arr = @[@"海贼王，我当定了！", @"我是路飞，要成为海贼王的男人"];
    _dataSource = [[RZDataSource alloc] initWithItems:arr CellReuseIdentifier:@"cell" configureCellBlock:^(UITableViewCell *cell, NSString *title) {
        RZLog(@"%@", title);
    }];
    _delegate = [[RZDelegate alloc] initWithData:arr SelectBlock:^(NSInteger row) {
        [self.view makeRZToast:arr[row]];
    }];
    _tableView.dataSource = _dataSource;
    _tableView.delegate = _delegate;
    
    [_tableView reloadData];
}

@end

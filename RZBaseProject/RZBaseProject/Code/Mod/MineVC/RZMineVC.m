//
//  RZMineVC.m
//  RZBaseProject
//
//  Created by 利基 on 2017/7/27.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZMineVC.h"
#import "RZDataSource.h"
#import "RZMineModel.h"

@interface RZMineVC ()

/** tableView */
@property (nonatomic, strong) UITableView *mineTableView;

@end

@implementation RZMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    
}

@end

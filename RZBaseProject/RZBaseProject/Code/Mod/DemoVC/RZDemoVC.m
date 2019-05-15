//
//  RZDemoVC.m
//  RZBaseProject
//
//  Created by 利基 on 2017/6/2.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZDemoVC.h"
#import "NSDictionary+JKSafeAccess.h"
#import "RZPageVC.h"


static NSString *const recellID = @"demoCell";


@interface RZDemoVC ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *DemoTableView;
@property (nonatomic, strong) NSMutableDictionary *DictStoreDemoTitle;

@end

@implementation RZDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RZ_White_Color;
    _DemoTableView.tableFooterView = [UIView new];
}

#pragma mark - 设置TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr_Key = self.DictStoreDemoTitle.allKeys;
    return arr_Key.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *demoCell = [tableView dequeueReusableCellWithIdentifier:recellID];
    if (!demoCell) {
        demoCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recellID];
    }
    
    NSArray *arr_Key = self.DictStoreDemoTitle.allKeys;
    demoCell.textLabel.text = arr_Key[indexPath.row];
    demoCell.textLabel.textColor = [UIColor redColor];
    
    return demoCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arr_Key = self.DictStoreDemoTitle.allKeys;
    NSString *aClassName = [self.DictStoreDemoTitle jk_stringForKey:arr_Key[indexPath.row]];
    Class ViewController = NSClassFromString(aClassName);
    
    [self.navigationController pushViewController:[ViewController new] animated:YES];
}

#pragma mark - 懒加载

- (NSMutableDictionary *)DictStoreDemoTitle {
    if (!_DictStoreDemoTitle) {
        _DictStoreDemoTitle = [NSMutableDictionary dictionary];
        
        [_DictStoreDemoTitle jk_setString:@"ZYCornerRadius_DemoVC" forKey:@"一句代码，圆角风雨无阻_ZYCornerRadius"];
        [_DictStoreDemoTitle jk_setString:@"RZPageVC" forKey:@"PageControl"];
        [_DictStoreDemoTitle jk_setString:@"YYText_DemoVC" forKey:@"YYText"];
    }
    return _DictStoreDemoTitle;
}

@end

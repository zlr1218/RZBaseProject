//
//  RZHomeVC.m
//  RZBaseProject
//
//  Created by 利基 on 2017/6/2.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZHomeVC.h"

#import "RZCityList.h"
#import "RZFoldTableViewController.h"

#import "RZBase64ViewController.h"

#import "UIView+Toast.h"
#import "RZAlertView.h"
#import "RZAlertController.h"
#import "UIView+RZAlert.h"

@interface RZHomeVC ()<UITableViewDelegate, UITableViewDataSource, RZAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (weak, nonatomic) IBOutlet UIView *HomeHeaderView;
@property (nonatomic, strong) NSArray *titleArr;


@end

@implementation RZHomeVC

static NSString *const reCellID = @"HomeCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

- (void)setupTableView {
    // 设置headerview
    self.HomeHeaderView.height = kScreeWith*150.f/320.f;
}

#pragma mark - tableView的代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *str = [NSString stringWithFormat:@"%li、%@", indexPath.row + 1, self.titleArr[indexPath.row]];
    cell.textLabel.text = str;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.titleArr[indexPath.row] isEqualToString:@"table折叠示例"]) {
        RZFoldTableViewController *foldVC = [[RZFoldTableViewController alloc] init];
        [self.navigationController pushViewController:foldVC animated:YES];
    }
    
    if ([self.titleArr[indexPath.row] isEqualToString:@"城市列表选择"]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cityList" ofType:@"plist"];
        NSArray *cityData = [NSArray arrayWithContentsOfFile:path];
        RZCityList *list = [[RZCityList alloc] initWithData:cityData];
        [list setRZCityListBlock:^(NSArray *nameArr, NSArray *IDArr) {
            RZLog(@"%@\n%@", nameArr, IDArr);
        }];
    }
    
    if ([self.titleArr[indexPath.row] isEqualToString:@"UIView+Toast"]) {
        [self.view makeToast:@"This is toast 路飞是要成为海贼王的男人，他有一群值得付出生命去守护的伙伴，他们是一伙因为梦想而聚在一起的伙伴！" duration:2.0 position:CSToastPositionCenter];
    }
    
    if ([self.titleArr[indexPath.row] isEqualToString:@"iOS_base64加密"]) {
        RZBase64ViewController *base64VC = [[RZBase64ViewController alloc] init];
        [self.navigationController pushViewController:base64VC animated:YES];
        base64VC.navigationItem.title = @"base64加密";
    }
    
    if ([self.titleArr[indexPath.row] isEqualToString:@"RZAlert"]) {
        RZAlertView *alert02 = [[RZAlertView alloc] initWithTitle:nil Message:@"这是一个自定义的alertView，欢迎大家使用指导！" Delegate:self CancleTitle:nil OtherBtnTitles:nil];
        [self.view.window addSubview:alert02];
        alert02.isClickMask = YES;
    }
    
    if ([self.titleArr[indexPath.row] isEqualToString:@"UIView+RZAlert"]) {
        [self.tabBarController.view makeAlert:@"这是一个自定义的alertView，欢迎大家使用指导！" title:@"提示" style:nil cancleTitle:@"取消" cancleBlock:^{
            RZLog(@"cancle");
        } sureTitle:@"确定" sureBlock:^{
            RZLog(@"sure");
        }];
    }
    
    if ([self.titleArr[indexPath.row] isEqualToString:@"RZAlertController"]) {
        [RZAlertController alertWithTitle:@"提示" message:@"这是一个自定义的alertView，欢迎大家使用指导！" actionLeftTitle:@"确定" lefthandler:^{
            RZLog(@"确定");
        } showVC:self];
    }
}

- (void)alertView:(RZAlertView *)alertView ClickedBtnAtIndex:(NSInteger)index {
    RZLog(@"RZAlertView CancleButtonIndex: %li", index);
}

#pragma mark - 懒加载

- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"table折叠示例", @"城市列表选择", @"UIView+Toast", @"iOS_base64加密", @"RZAlert", @"RZAlertController", @"UIView+RZAlert"];
    }
    return _titleArr;
}

@end

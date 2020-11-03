//
//  RZHomeVC.m
//  RZBaseProject
//
//  Created by 利基 on 2017/6/2.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZHomeVC.h"
#import "RZBaseProject-Swift.h"
#import "RZTool.h"
#import <CoreLocation/CoreLocation.h>

#import "RZCityList.h"
#import "RZFoldTableViewController.h"

#import "RZBase64ViewController.h"

#import "UIView+Toast.h"
#import "RZAlertView.h"
#import "RZAlertController.h"
#import "UIView+RZAlert.h"
#import "UIView+RZActivityView.h"

#import "NSString+Size.h"
#import "NSDate+Extension.h"

#import "RZThreadVC.h"
#import "RZDispatchVC.h"
#import "RZGCDVC.h"
#import "RZEmptyVC.h"
#import "RZInterviewController.h"

#import "RZSort.h"

#import "RZUpdateLocationVC.h"

#import "RZBtn.h"

#import "NSDate+JKExtension.h"

@interface RZHomeVC ()<UITableViewDelegate, UITableViewDataSource, RZAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (weak, nonatomic) IBOutlet UIView *HomeHeaderView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *homeTableBottom;

@property (weak, nonatomic) IBOutlet RZBtn *customView;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) NSArray *sortArr;

@end

@implementation RZHomeVC

static NSString *const reCellID = @"HomeCell";

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 注意对scrollView及其子控件进行iOS11适配
    kAdjustmentBehavior(self, self.homeTableView);
    
    self.homeTableBottom.constant = kRZTabHeight;
    [self setupTableView];
    
    RZSwift *test = [[RZSwift alloc] init];
    // 调用swift代码时若有参数需要引入参数名称
    [test abcWithName:@"123"];
}

- (CGFloat)getCurHour {
    NSDate *now = [NSDate date];
    NSInteger hour = [NSDate jk_hour:now];
    NSInteger minute = [NSDate jk_minute:now];
    
    CGFloat curHour = 0;
    if (minute >= 0 && minute < 20) {
        curHour = hour + 0.5;
    } else if (minute >= 20 && minute < 50) {
        curHour = hour + 1;
    } else if (minute >= 50 && minute < 60) {
        curHour = hour + 1.5;
    }
    //RZLog(@"%li %li %lf", hour, minute, curHour);
    return curHour;
}

- (void)setupTableView {
    // 设置headerview
    self.HomeHeaderView.height = kScreeWith*150.f/320.f;
    
    // 隐藏指示器
    self.homeTableView.showsVerticalScrollIndicator = NO;
}

- (NSNumber*)num:(NSInteger)i {
    return [NSNumber numberWithInteger:i];
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
    
    NSString *str = [NSString stringWithFormat:@"%@、%@", [RZTool num:indexPath.row + 1], self.titleArr[indexPath.row]];
    cell.textLabel.text = str;
    cell.textLabel.textColor = [UIColor orangeColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.titleArr[indexPath.row];
    
    if ([title isEqualToString:@"table折叠示例"]) {
        RZFoldTableViewController *foldVC = [[RZFoldTableViewController alloc] init];
        [self.navigationController pushViewController:foldVC animated:YES];
    }
    
    if ([title isEqualToString:@"城市列表选择"]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cityList" ofType:@"plist"];
        NSArray *cityData = [NSArray arrayWithContentsOfFile:path];
        RZCityList *list = [[RZCityList alloc] initWithData:cityData];
        [list setRZCityListBlock:^(NSArray *nameArr, NSArray *IDArr) {
            RZLog(@"%@\n%@", nameArr, IDArr);
        }];
    }
    
    if ([title isEqualToString:@"UIView+Toast"]) {
        [self.view makeToast:@"This is toast 路飞是要成为海贼王的男人，他有一群值得付出生命去守护的伙伴，他们是一伙因为梦想而聚在一起的伙伴！" duration:2.0 position:CSToastPositionCenter];
    }
    
    if ([title isEqualToString:@"iOS_base64加密"]) {
        RZBase64ViewController *base64VC = [[RZBase64ViewController alloc] init];
        [self.navigationController pushViewController:base64VC animated:YES];
        base64VC.navigationItem.title = @"base64加密";
    }
    
    if ([title isEqualToString:@"RZAlert"]) {
        RZAlertView *alert02 = [[RZAlertView alloc] initWithTitle:nil Message:@"这是一个自定义的alertView，欢迎大家使用指导！" Delegate:self CancleTitle:nil OtherBtnTitles:nil];
        [self.view.window addSubview:alert02];
        alert02.isClickMask = YES;
    }
    
    if ([title isEqualToString:@"UIView+RZAlert"]) {
//        [self.tabBarController.view makeAlert:@"这是一个自定义的alertView，欢迎大家使用指导！" title:@"提示" style:nil cancleTitle:@"取消" cancleBlock:^{
//            RZLog(@"cancle");
//        } sureTitle:@"确定" sureBlock:^{
//            RZLog(@"sure");
//        }];
        
        [[RZTool window] makeActivity:nil];
    }
    
    if ([title isEqualToString:@"RZAlertController"]) {
        [RZAlertController alertWithTitle:@"提示" message:@"这是一个自定义的alertView，欢迎大家使用指导！" actionLeftTitle:@"确定" lefthandler:^{
            RZLog(@"确定");
        } showVC:self];
    }
    
    if ([title isEqualToString:@"NSString+Size"]) {
        NSString *string = @"这是一个自定义的alertView，欢迎大家使用指导！";
        CGFloat height = [string heightWithFont:[UIFont systemFontOfSize:15] constrainedToWidth:100.f];
        RZLog(@"%lf", height);
    }
    
    if ([title isEqualToString:@"NSDate+Extension"]) {
        NSDate *date = [NSDate date];
        [self.view makeRZToast:[NSString stringWithFormat:@"Today is %@ - %@", [date stringWithFormat:[date ymdFormat]], [date dayFromWeekday]]];
    }
    
    if ([title isEqualToString:@"多线程"]) {
        [self.navigationController pushViewController:[RZThreadVC new] animated:YES];
    }
    
    if ([title isEqualToString:@"GCD 多线程"]) {
        [self.navigationController pushViewController:[RZDispatchVC new] animated:YES];
    }
    
    if ([title isEqualToString:@"冒泡排序"]) {
//        RZLog(@"%@", [[RZSort bubbleSort3:arr] mj_JSONString]);// 冒泡
        RZLog(@"%@", [[RZSort bubbleSort:self.sortArr] mj_JSONString]);// 冒泡
    }
    if ([title isEqualToString:@"选择排序"]) {
        RZLog(@"%@", [[RZSort selectionSort:self.sortArr] mj_JSONString]);
    }
    if ([title isEqualToString:@"插入排序"]) {
        RZLog(@"%@", [[RZSort insertionSort:self.sortArr] mj_JSONString]);// 插入排序
    }
    if ([title isEqualToString:@"快排"]) {
        RZLog(@"%@", [[RZSort quickSork:self.sortArr] mj_JSONString]);// 快排
    }
    
    if ([title isEqualToString:@"定位"]) {
        [self.navigationController pushViewController:[RZUpdateLocationVC new] animated:YES];
    }
    
    if ([title isEqualToString:@"空白界面"]) {
        [self.navigationController pushViewController:[RZEmptyVC new] animated:YES];
    }
    
    if ([title isEqualToString:@"面试题"]) {
        [self.navigationController pushViewController:[RZInterviewController new] animated:YES];
    }
}

- (void)alertView:(RZAlertView *)alertView ClickedBtnAtIndex:(NSInteger)index {
    RZLog(@"RZAlertView CancleButtonIndex: %@", [NSNumber numberWithInteger:index]);
}

#pragma mark - 懒加载

- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"table折叠示例", @"面试题", @"城市列表选择", @"UIView+Toast", @"iOS_base64加密", @"RZAlert", @"RZAlertController", @"UIView+RZAlert", @"NSString+Size", @"NSDate+Extension", @"多线程", @"GCD 多线程", @"冒泡排序", @"选择排序", @"插入排序", @"快排", @"定位", @"空白界面", @"------"];
    }
    return _titleArr;
}

- (NSArray *)sortArr {
    if (!_sortArr) {
//        _sortArr = @[@34, @21, @6, @31, @43, @59, @8, @51, @51, @81, @52, @96, @80, @53, @34, @67, @37, @56, @27, @51, @11];
        NSMutableArray *marr = [NSMutableArray array];
        for (int i = 0; i < 1000; i++) {
            NSInteger n = arc4random() % 10000;
            [marr addObject:@(n)];
        }
        _sortArr = [NSArray arrayWithArray:marr];
        RZLog(@"%@", _sortArr.mj_JSONString);
    }
    return _sortArr;
}

@end

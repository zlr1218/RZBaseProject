//
//  RZDemo3VC.m
//  RZBaseProject
//
//  Created by 赵林瑞 on 16/11/18.
//  Copyright © 2016年 RZOL. All rights reserved.
//

#import "RZDemo3VC.h"

#import "RZPageTwoController.h"
#import "RZPageController.h"
#import "RZViewController.h"

#import "TYTabButtonPagerController.h"

@interface RZDemo3VC ()<TYPagerControllerDataSource>

@property (nonatomic, strong) TYTabButtonPagerController *pagerController;

@end

@implementation RZDemo3VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    _pagerController = [[TYTabButtonPagerController alloc] init];
    _pagerController.dataSource = self;
    _pagerController.adjustStatusBarHeight = YES;
    _pagerController.barStyle = TYPagerBarStyleProgressView;
    _pagerController.cellSpacing = 8;
    _pagerController.progressWidth = kScreeWith/3 -10;
    
    _pagerController.view.frame = self.view.bounds;
    [self addChildViewController:_pagerController];
    [self.view addSubview:_pagerController.view];
 
    [_pagerController reloadData];
    [_pagerController moveToControllerAtIndex:1 animated:NO];
}

#pragma mark - TYPagerControllerDataSource

- (NSInteger)numberOfControllersInPagerController {
    
    return 3;
}

- (NSString *)pagerController:(TYPagerController *)pagerController titleForIndex:(NSInteger)index {
    NSArray *arrayTitle = @[@"controller1",@"controller2",@"controller3"];
    return arrayTitle[index];
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index {
    
    if (index == 0) {
        RZViewController *VC = [[RZViewController alloc] init];
        return VC;
    } else if (index == 1) {
        RZPageController *VC = [[RZPageController alloc] init];
        return VC;
    } else {
        RZPageTwoController *VC = [[RZPageTwoController alloc] init];
        return VC;
    }
}

@end

//
//  RZPageVC.m
//  RZBaseProject
//
//  Created by os on 2018/8/30.
//  Copyright © 2018年 RZOL. All rights reserved.
//

#import "RZPageVC.h"
#import "JXCategoryView.h"
#import "RZListVC.h"


#define kTitleHeight 50.f
#define kContentHeight kScreeHeight-kRZBottomHeight-kRZTopHeight-50

@interface RZPageVC ()<UIScrollViewDelegate, JXCategoryViewDelegate>
{
    NSInteger _count;
}

/* titles */
@property (nonatomic, strong) NSArray *titles;

/* scrollView */
@property (nonatomic, strong) UIScrollView *scrollView;

/* currentIndex */
@property (nonatomic, assign) NSInteger currentIndex;

/* titleView */
@property (nonatomic, strong) JXCategoryTitleView *titleView;

@end

@implementation RZPageVC

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"螃蟹", @"麻辣小龙虾", @"苹果", @"营养胡萝卜", @"葡萄", @"美味西瓜", @"香蕉", @"香甜菠萝", @"鸡肉", @"鱼", @"海星"];
    }
    return _titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupUI02];
}

- (void)setupUI02 {
    
}

- (void)setupUI {
    // 初始化titleView
    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreeWith, kTitleHeight)];
    titleView.delegate = self;
    titleView.titleColorGradientEnabled = YES;
    titleView.titles = self.titles;
    [self.view addSubview:titleView];
    _titleView = titleView;
    
    // lineView
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineWidth = JXCategoryViewAutomaticDimension;
    titleView.indicators = @[lineView];
    
    _count = self.titles.count;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTitleHeight, kScreeWith, kContentHeight)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(kScreeWith*_count, kContentHeight);
    [self.view addSubview:self.scrollView];
    
    _titleView.contentScrollView = self.scrollView;
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    for (int i = 0; i < _count; i++) {
        RZListVC *listVC = [RZListVC new];
        [self addChildViewController:listVC];
        listVC.view.frame = CGRectMake(i*kScreeWith, 0, kScreeWith, kContentHeight);
        [self.scrollView addSubview:listVC.view];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat index = scrollView.contentOffset.x/kScreeWith;
    CGFloat absIndex = fabs(index - self.currentIndex);
    if (absIndex >= 1) {
        /*
         嵌套使用的时候，最外层的VC持有的scrollView在翻页之后，就断掉一次手势。
         解决快速滑动的时候，只响应最外层VC持有的scrollView。
         子VC持有的scrollView却没有响应
         */
        self.scrollView.panGestureRecognizer.enabled = NO;
        self.scrollView.panGestureRecognizer.enabled = YES;
        self.currentIndex = floor(index);
    }
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake(kScreeWith*index, 0) animated:YES];
}

@end

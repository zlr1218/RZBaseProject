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
    
    CGFloat titleViewHeight = 50;
    
    JXCategoryTitleView *titleView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreeWith, titleViewHeight)];
    titleView.delegate = self;
    titleView.titleColorGradientEnabled = YES;
    titleView.titles = self.titles;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineWidth = JXCategoryViewAutomaticDimension;
    titleView.indicators = @[lineView];
    [self.view addSubview:titleView];
    _titleView = titleView;
    
    _count = self.titles.count;
    
    CGFloat scrollWidth = kScreeWith;
    CGFloat scrollHeight = 300;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleViewHeight, scrollWidth, scrollHeight)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(scrollWidth*_count, scrollHeight);
    [self.view addSubview:self.scrollView];
    
    _titleView.contentScrollView = self.scrollView;
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    for (int i = 0; i < _count; i++) {
        RZListVC *listVC = [RZListVC new];
        [self addChildViewController:listVC];
        listVC.view.frame = CGRectMake(i*scrollWidth, 0, scrollWidth, scrollHeight);
        [self.scrollView addSubview:listVC.view];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat index = scrollView.contentOffset.x/kScreeWith;
    CGFloat absIndex = fabs(index - self.currentIndex);
    if (absIndex >= 1) {
        //嵌套使用的时候，最外层的VC持有的scrollView在翻页之后，就断掉一次手势。解决快速滑动的时候，只响应最外层VC持有的scrollView。子VC持有的scrollView却没有响应
        self.scrollView.panGestureRecognizer.enabled = NO;
        self.scrollView.panGestureRecognizer.enabled = YES;
        self.currentIndex = floor(index);
//        [self.titleView selectItemWithIndex:self.currentIndex];
    }
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake(kScreeWith*index, 0) animated:YES];
}

@end

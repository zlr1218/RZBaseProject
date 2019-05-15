//
//  UIView+RZActivityView.m
//  RZBaseProject
//
//  Created by os on 2019/3/22.
//  Copyright © 2019 RZOL. All rights reserved.
//

#import "UIView+RZActivityView.h"

@implementation UIView (RZActivityView)

- (void)makeActivity:(NSArray *)icons {
    UIView *activityView = [self activityViewWithIcons:@[@"1"]];
    [self addSubview:activityView];
}

- (UIView *)activityViewWithIcons:(NSArray *)icons {
    if (icons == nil || ![icons isKindOfClass:[NSArray class]] || icons.count == 0) return nil;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat contentWidth = screenWidth - 15*2;
    CGFloat contentHeight = contentWidth*9/16;
    
    CGFloat contentY = (screenHeight-contentHeight)/2.f;
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
    bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
//    UIView *contentView = [UIView new];
//    contentView.layer.backgroundColor = [UIColor whiteColor].CGColor;
//    [bgView addSubview:contentView];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, contentY, contentWidth, contentHeight)];
    scrollView.contentSize = CGSizeMake(contentWidth*3, contentHeight);
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.backgroundColor = [UIColor orangeColor];
    [bgView addSubview:scrollView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, contentWidth, contentHeight)];
    imgView.image = [UIImage imageNamed:@"mac_dog"];
    [scrollView addSubview:imgView];
    
    return bgView;
}

@end

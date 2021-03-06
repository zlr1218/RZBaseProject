//
//  YYText_DemoVC.m
//  RZBaseProject
//
//  Created by 利基 on 2017/12/7.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "YYText_DemoVC.h"
#import <YYText.h>
#import <NSString+YYAdd.h>

#define kYYTextHeight 35.f
#define kYYTextSpace 10.f

#define kYYTextAllSpace 45.f

@interface YYText_DemoVC ()

@end

@implementation YYText_DemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self attributedStringUse];
    [self basicUse];
    [self superUse];
}

- (void)attributedStringUse {
    UILabel *lab = [UILabel new];
    lab.frame = CGRectMake(13, kYYTextAllSpace*2, 200, kYYTextHeight);
    lab.textColor = RZ_Orange_Color;
    lab.font = [UIFont boldSystemFontOfSize:17];
    lab.text = @"富文本的使用";
    [self.view addSubview:lab];
    
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:@"富文本的使用"];
    [muStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:28] range:NSMakeRange(0, 1)];
    [muStr addAttribute:NSForegroundColorAttributeName value:RZ_Red_Color range:NSMakeRange(5, 1)];
    lab.attributedText = muStr;
}

- (void)basicUse {
    YYLabel *label = YYLabel.new;
    label.frame = CGRectMake(13, 10, kScreeWith-26, 35);
    label.textColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"这是基本用法";
    [self.view addSubview:label];
    
    YYTextView *textView = [YYTextView new];
    textView.frame = CGRectMake(13, 10+kYYTextAllSpace, 70, 35);
    textView.textColor = [UIColor orangeColor];
    textView.text = @"这是YYTextView的基本用法，和UITextView是一样的";
    [self.view addSubview:textView];
    
    
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:@"这是YYTextView的基本用法，和UITextView是一样的"];
    [muStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:28] range:NSMakeRange(0, 1)];
    [muStr addAttribute:NSForegroundColorAttributeName value:RZ_Red_Color range:NSMakeRange(5, 1)];
    textView.attributedText = muStr;
    
}

- (void)superUse {
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:@"文本布局计算"];
    CGSize size = CGSizeMake(70, CGFLOAT_MAX);
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:text];
    
    [layout lineIndexForPoint:CGPointMake(10, 10)];
    
    YYLabel *label = [YYLabel new];
    label.size = layout.textBoundingSize;
    label.textLayout = layout;
    [self.view addSubview:label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end

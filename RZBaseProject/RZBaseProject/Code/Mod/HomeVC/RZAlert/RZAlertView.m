//
//  RZAlertView.m
//  RZBaseProject
//
//  Created by 利基 on 2017/11/3.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZAlertView.h"


/** 1、视图的宽高 */
#define kRZAlert_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define kRZAlert_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define kRZAlert_ContentWidth 270
#define kRZAlert_ContentHeight 88

#define kRZAlert_MarginX 7
#define kRZAlert_MarginY 7
#define kRZAlert_MessageWidth (kRZAlert_ContentWidth - kRZAlert_MarginX*2)


@interface RZAlertView ()

/** 视图容器 */
@property (nonatomic, strong) UIView *contentView;
/** 标题视图 */
@property (nonatomic, strong) UITextView *titleView;
/** 内容视图 */
@property (nonatomic, strong) UITextView *messageView;


/** 数据 */
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *message;
@property (nonatomic, copy, nullable) NSString *cancleTitle;
@property (nonatomic, strong) NSMutableArray<NSString *> *otherBtnTitles;

@end

@implementation RZAlertView

- (instancetype)initWithTitle:(NSString *)title Message:(NSString *)message Delegate:(id<RZAlertViewDelegate>)delegate CancleTitle:(NSString *)cancleTitle OtherBtnTitles:(nullable NSArray<NSString *> *)otherBtnTitles {
    if (self = [super init]) {
        
        // 设置数据
        self.title = title;
        self.message = message;
        self.cancleTitle = cancleTitle;
        if (otherBtnTitles.count > 0 && otherBtnTitles != nil) {
            for (NSString *eachStr in otherBtnTitles) {
                [self.otherBtnTitles addObject:eachStr];
            }
        }
        
        self.delegate = delegate;
        
        // 初始化UI
        [self setupDefault];
    }
    return self;
}

- (void)setupDefault {
    self.frame = CGRectMake(0, 0, kRZAlert_ScreenWidth, kRZAlert_ScreenHeight);
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    // 添加视图容器
    [self addSubview:self.contentView];
    
    // 添加子视图
    [self.contentView addSubview:self.titleView];
    [self.contentView addSubview:self.messageView];
    [self addButtonKeyWithTitle:self.cancleTitle];
}

- (void)addButtonKeyWithTitle:(NSString *)title {
    if (title == nil || title.length == 0) {
        title = @"确定";
    }
    
    CGFloat btnY = CGRectGetMaxY(self.messageView.frame);
    int buttonCount = (int)self.otherBtnTitles.count;
    
    // 取消键（必须有）
    UIButton *cancleBtn = [self buttonWithFrame:CGRectMake(0, btnY, kRZAlert_ContentWidth, kRZAlert_ContentHeight/2.f) title:title target:self action:@selector(cancleAction)];
    [self.contentView addSubview:cancleBtn];
    // 其他键（非必须）
    if (buttonCount == 1) {
        UIButton *sureBtn = [self buttonWithFrame:CGRectMake(kRZAlert_ContentWidth/2.f, btnY, kRZAlert_ContentWidth/2.f, kRZAlert_ContentHeight/2.f) title:self.otherBtnTitles.firstObject target:self action:@selector(sureAction:)];
        sureBtn.tag = 711 + 1;
        [self.contentView addSubview:sureBtn];
        self.contentView.frame = CGRectMake(0, 0, kRZAlert_ContentWidth, CGRectGetMaxY(cancleBtn.frame));
        self.contentView.center = self.center;
    }else if (buttonCount > 1) {
        for (int i = 0; i < buttonCount; i++) {
            UIButton *Btn = [self buttonWithFrame:CGRectMake(0, btnY + kRZAlert_ContentHeight*(i+1)/2.f, kRZAlert_ContentWidth, kRZAlert_ContentHeight/2.f) title:self.otherBtnTitles[i] target:self action:@selector(sureAction:)];
            [self.contentView addSubview:Btn];
            
            Btn.tag = 711 + 1 + i;
        }
        self.contentView.frame = CGRectMake(0, 0, kRZAlert_ContentWidth, CGRectGetMaxY(cancleBtn.frame) + kRZAlert_ContentHeight*buttonCount/2.f);
        self.contentView.center = self.center;
    }else{
        self.contentView.frame = CGRectMake(0, 0, kRZAlert_ContentWidth, CGRectGetMaxY(cancleBtn.frame));
        self.contentView.center = self.center;
    }
}


#pragma mark - 点击事件

- (void)cancleAction {
    if ([self.delegate respondsToSelector:@selector(alertView:ClickedBtnAtIndex:)]) {
        [self.delegate alertView:self ClickedBtnAtIndex:0];
    }
    [self remove];
}

- (void)sureAction:(UIButton *)sender {
    NSInteger index = sender.tag - 711;
    if ([self.delegate respondsToSelector:@selector(alertView:ClickedBtnAtIndex:)]) {
        [self.delegate alertView:self ClickedBtnAtIndex:index];
    }
    [self remove];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.isClickMask) {
        [self remove];
    }
}

- (void)remove {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.contentView.alpha = 0;
    } completion:^(BOOL finished) {
        for (UIView *subView in self.subviews) {
            [subView removeFromSuperview];
        }
        [self removeFromSuperview];
    }];
}


#pragma mark - --- 4.private methods 私有方法 ---

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title target:(nullable id)target action:(nullable SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:(235.0/255) green:(235.0/255) blue:(235.0/255) alpha:1.0]] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:RZ_Orange_Color forState:UIControlStateNormal];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *lineUp = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
    lineUp.backgroundColor = [UIColor colorWithRed:(219.0/255) green:(219.0/255) blue:(219.0/255) alpha:1.0];
    
    UIView *lineRight = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width, 0, 0.5, frame.size.height)];
    lineRight.backgroundColor = [UIColor colorWithRed:(219.0/255) green:(219.0/255) blue:(219.0/255) alpha:1.0];
    
    [button addSubview:lineUp];
    [button addSubview:lineRight];
    return button;
}


#pragma mark - setter getter 方法

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleView.text = title;
    [self.titleView sizeToFit];
    
    CGFloat height = self.titleView.frame.size.height;
    if (height > kRZAlert_ScreenHeight/2) {
        height = kRZAlert_ScreenHeight/2;
    }
    if (title.length == 0 || title == nil) {
        height = 0;
        self.titleView.frame = CGRectMake(kRZAlert_MarginX, 0, kRZAlert_MessageWidth, height);
    }else{
        self.titleView.frame = CGRectMake(kRZAlert_MarginX, kRZAlert_MarginY, kRZAlert_MessageWidth, height);
    }
}
- (void)setMessage:(NSString *)message {
    _message = message;
    self.messageView.text = message;
    [self.messageView sizeToFit];
    
    CGFloat height = self.messageView.frame.size.height;
    if (height > kRZAlert_ScreenHeight/2) {
        height = kRZAlert_ScreenHeight/2;
    }
    if (message.length == 0 || message == nil) {
        height = kRZAlert_ContentHeight/2.f;
    }
    self.messageView.frame = CGRectMake(kRZAlert_MarginX, CGRectGetMaxY(self.titleView.frame), kRZAlert_MessageWidth, height);
}

- (void)setMessageAlignment:(NSTextAlignment)messageAlignment {
    _messageAlignment = messageAlignment;
    self.messageView.textAlignment = messageAlignment;
}


#pragma mark - 懒加载

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        _contentView.layer.cornerRadius = 7;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}

- (UITextView *)titleView {
    if (!_titleView) {
        _titleView = [[UITextView alloc] initWithFrame:CGRectMake(kRZAlert_MarginX, kRZAlert_MarginY, kRZAlert_MessageWidth, 0)];
        _titleView.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        _titleView.font = [UIFont boldSystemFontOfSize:16];
        _titleView.textAlignment = NSTextAlignmentCenter;
        [_titleView setEditable:NO];
        [_titleView setSelectable:NO];
    }
    return _titleView;
}

- (UITextView *)messageView {
    if (!_messageView) {
        _messageView = [[UITextView alloc] initWithFrame:CGRectMake(kRZAlert_MarginX, kRZAlert_MarginY, kRZAlert_MessageWidth, 0)];
        _messageView.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        _messageView.font = [UIFont systemFontOfSize:14];
        _messageView.textAlignment = NSTextAlignmentCenter;
        [_messageView setEditable:NO];
        [_messageView setSelectable:NO];
    }
    return _messageView;
}

- (NSMutableArray<NSString *> *)otherBtnTitles {
    if (!_otherBtnTitles) {
        _otherBtnTitles = [NSMutableArray array];
    }
    return _otherBtnTitles;
}

@end

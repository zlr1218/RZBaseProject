//
//  UIView+RZAlert.m
//  RZBaseProject
//
//  Created by 利基 on 2017/11/13.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "UIView+RZAlert.h"
#import <objc/runtime.h>


/** 视图的宽高 */
#define kRZAlert_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define kRZAlert_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define kRZAlert_ContentWidth 270
#define kRZAlert_ContentHeight 88

#define kRZAlert_MarginX 7
#define kRZAlert_MarginY 7
#define kRZAlert_MessageWidth (kRZAlert_ContentWidth - kRZAlert_MarginX*2)

// 私有 关联对象Key
static const NSString *RZAlertActiveKey             = @"RZAlertActiveKey";
static const NSString *RZAlertQueueKey              = @"RZAlertQueueKey";

static const NSString *RZAlertViewKey               = @"RZAlertViewKey";
static const NSString *RZAlertCancleBlockKey        = @"RZAlertCancleBlockKey";
static const NSString *RZAlertSureBlockKey          = @"RZAlertSureBlockKey";

@implementation UIView (RZAlert)

#pragma mark - Make Alert Methods

/// 仅展示Message,默认为关闭按钮,无回调
- (void)showAlertMsg:(NSString *)msg {
    UIView *alert = [self alertViewForMessage:msg title:nil style:nil cancleTitle:nil sureTitle:nil];
    [self showAlert:alert];
    objc_setAssociatedObject(self, &RZAlertViewKey, alert, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 仅展示Message,自定义关闭按钮名称,有回调
- (void)showAlertMsg:(NSString *)msg closeName:(NSString *)closeName close:(RZAlertCancleBlock)close {
    UIView *alert = [self alertViewForMessage:msg title:nil style:nil cancleTitle:closeName sureTitle:nil];
    [self showAlert:alert];
    objc_setAssociatedObject(self, &RZAlertViewKey, alert, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &RZAlertCancleBlockKey, close, OBJC_ASSOCIATION_COPY);
}

/// 展示标题,信息,默认“确定”“取消”,有回调
- (void)showAlertTitle:(NSString *)title msg:(NSString *)msg sure:(RZAlertSureBlock)sure {
    UIView *alert = [self alertViewForMessage:msg title:title style:nil cancleTitle:@"取消" sureTitle:@"确定"];
    [self showAlert:alert];
    objc_setAssociatedObject(self, &RZAlertViewKey, alert, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &RZAlertSureBlockKey, sure, OBJC_ASSOCIATION_COPY);
}

/// 展示标题,信息,自定义确定按钮名称,有回调
- (void)showAlertTitle:(NSString *)title msg:(NSString *)msg sureName:(NSString *)sureName sure:(RZAlertSureBlock)sure {
    UIView *alert = [self alertViewForMessage:msg title:title style:nil cancleTitle:@"取消" sureTitle:sureName];
    [self showAlert:alert];
    objc_setAssociatedObject(self, &RZAlertViewKey, alert, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &RZAlertSureBlockKey, sure, OBJC_ASSOCIATION_COPY);
}



/// 全部自定义
- (void)showAlertTitle:(NSString *)title
                   msg:(NSString *)msg
                 style:(RZAlertStyle *)style
             closeName:(NSString *)closeName
                 close:(RZAlertCancleBlock)close
              sureName:(NSString *)sureName
                  sure:(RZAlertSureBlock)sure
{
    UIView *alert = [self alertViewForMessage:msg title:title style:style cancleTitle:closeName sureTitle:sureName];
    [self showAlert:alert];
    objc_setAssociatedObject(self, &RZAlertViewKey, alert, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &RZAlertCancleBlockKey, close, OBJC_ASSOCIATION_COPY);
    objc_setAssociatedObject(self, &RZAlertSureBlockKey, sure, OBJC_ASSOCIATION_COPY);
}

#pragma mark - UI搭建

- (UIView *)alertViewForMessage:(NSString *)message title:(NSString *)title style:(RZAlertStyle *)style cancleTitle:(NSString *)cancleTitle sureTitle:(NSString *)sureTitle {
    if ((message == nil || message.length == 0) &&
        (title == nil || title.length == 0) &&
        (cancleTitle == nil || cancleTitle.length == 0) &&
        (sureTitle == nil || sureTitle.length == 0)) return nil;
    
    if (style == nil) {
        style = [RZAlertManager sharedStyle];
    }
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self addSubview:backgroundView];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kRZAlert_ContentWidth, kRZAlert_ContentHeight)];
    contentView.layer.backgroundColor = style.contentViewBGColor.CGColor;
    contentView.layer.cornerRadius = style.cornerRadius;
    contentView.layer.masksToBounds = YES;
    [backgroundView addSubview:contentView];
    
    UITextView *titleView;
    if (title != nil && title.length != 0) {
        titleView = [[UITextView alloc] initWithFrame:CGRectMake(kRZAlert_MarginX, kRZAlert_MarginY, kRZAlert_MessageWidth, 0)];
        titleView.textColor = style.titleColor;
        titleView.font = style.titleFont;
        titleView.textAlignment = style.titleAlignment;
        titleView.editable = NO;
        titleView.selectable = NO;
        titleView.showsVerticalScrollIndicator = NO;
        titleView.scrollEnabled = NO;
        
        titleView.text = title;
        [titleView sizeToFit];
        
        CGFloat titleHeight = titleView.frame.size.height;
        if (titleHeight > kRZAlert_ScreenHeight/2.f) {
            titleHeight = kRZAlert_ScreenHeight/2.f;
        }
        
        titleView.frame = CGRectMake(kRZAlert_MarginX, kRZAlert_MarginY, kRZAlert_MessageWidth, titleHeight);
        
        [contentView addSubview:titleView];
    }
    
    UITextView *messageView;
    if (message != nil && message.length != 0) {
        messageView = [[UITextView alloc] initWithFrame:CGRectMake(kRZAlert_MarginX, kRZAlert_MarginY, kRZAlert_MessageWidth, 0)];
        messageView.textColor = style.messageColor;
        messageView.font = style.messageFont;
        messageView.textAlignment = style.messageAlignment;
        messageView.editable = NO;
        messageView.selectable = NO;
        
        messageView.text = message;
        [messageView sizeToFit];
        
        CGFloat messageHeight = messageView.frame.size.height;
        if (messageHeight > kRZAlert_ScreenHeight/2.f) {
            messageHeight = kRZAlert_ScreenHeight/2.f;
        }
        
        if (title != nil && title.length != 0) {
            messageView.frame = CGRectMake(kRZAlert_MarginX, CGRectGetMaxY(titleView.frame), kRZAlert_MessageWidth, messageHeight);
        }else{
            messageView.frame = CGRectMake(kRZAlert_MarginX, kRZAlert_MarginY, kRZAlert_MessageWidth, messageHeight+kRZAlert_MarginY);
        }
        
        [contentView addSubview:messageView];
    }
    
    // cancle按钮
    UIButton *cancleBtn;
    CGFloat btnY = CGRectGetMaxY(messageView.frame);
    CGFloat btnWidth = kRZAlert_ContentWidth;
    CGFloat btnHeight = kRZAlert_ContentHeight/2.f;
    if (cancleTitle == nil || cancleTitle.length == 0) {
        cancleTitle = @"确定";
    }
    
    // sure按钮
    UIButton *sureBtn;
    if (sureTitle != nil && sureTitle.length != 0) {
        btnWidth = kRZAlert_ContentWidth/2.f;
        sureBtn = [self buttonWithFrame:CGRectMake(btnWidth, btnY, btnWidth, btnHeight) title:sureTitle target:self action:@selector(sureAction)];
        [contentView addSubview:sureBtn];
    }
    
    cancleBtn = [self buttonWithFrame:CGRectMake(0, btnY, btnWidth, btnHeight) title:cancleTitle target:self action:@selector(cancleAction)];
    [contentView addSubview:cancleBtn];
    
    contentView.frame = CGRectMake(0, 0, kRZAlert_ContentWidth, CGRectGetMaxY(cancleBtn.frame));
    contentView.center = self.center;
    
    return backgroundView;
}

- (void)cancleAction {
    RZAlertCancleBlock cancleBlock = objc_getAssociatedObject(self, &RZAlertCancleBlockKey);
    if (cancleBlock) {
        cancleBlock();
    }
    // 默认点击取消 隐藏alert
    UIView *titleView = objc_getAssociatedObject(self, &RZAlertViewKey);
    [self rz_hideAlert:titleView];
}

- (void)sureAction {
    RZAlertSureBlock sureBlock = objc_getAssociatedObject(self, &RZAlertSureBlockKey);
    if (sureBlock) {
        sureBlock();
    }
    // 默认点击取消 隐藏alert
    UIView *titleView = objc_getAssociatedObject(self, &RZAlertViewKey);
    [self rz_hideAlert:titleView];
}

#pragma mark - show Alert Methods

- (void)showAlert:(UIView *)alert {
    if (alert == nil) return;
    
    if ([self.rz_activeAlerts count] > 0) {
        [self.rz_alertQueue addObject:alert];
    }else{
        [self rz_showAlert:alert];
    }
}

#pragma mark - Private Show/Hide Alert Methods

- (void)rz_showAlert:(UIView *)alert {
    alert.center = CGPointMake(self.bounds.size.width/2.f, self.bounds.size.height/2.f);
    alert.alpha = 0.0;
    
    [self.rz_activeAlerts addObject:alert];
    [self addSubview:alert];
    
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         alert.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {}];
}

- (void)rz_hideAlert:(UIView *)alert {
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         alert.alpha = 0.0;
                     }
                     completion:^(BOOL finished) {
                         for (UIView *view in alert.subviews) {
                             [view removeFromSuperview];
                         }
                         [alert removeFromSuperview];
                         
                         [[self rz_activeAlerts] removeObject:alert];
                         
                         if ([[self rz_alertQueue] count] > 0) {
                             UIView *nextAlert = [[self rz_alertQueue] firstObject];
                             [[self rz_alertQueue] removeObjectAtIndex:0];
                             
                             [self rz_showAlert:nextAlert];
                         }
                     }];
}

#pragma mark - private methods 私有方法

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
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:20/255.f green:106/255.f blue:254/255.f alpha:1.f] forState:UIControlStateNormal];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    [button setBackgroundImage:[self imageWithColor:[UIColor colorWithRed:(235.0/255) green:(235.0/255) blue:(235.0/255) alpha:1.0]] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *lineUp = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
    lineUp.backgroundColor = [UIColor colorWithRed:(219.0/255) green:(219.0/255) blue:(219.0/255) alpha:1.0];
    
    UIView *lineRight = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width, 0, 0.5, frame.size.height)];
    lineRight.backgroundColor = [UIColor colorWithRed:(219.0/255) green:(219.0/255) blue:(219.0/255) alpha:1.0];
    
    [button addSubview:lineUp];
    [button addSubview:lineRight];
    return button;
}

#pragma mark - storeArr

- (NSMutableArray *)rz_activeAlerts {
    NSMutableArray *rz_activeAlerts = objc_getAssociatedObject(self, &RZAlertActiveKey);
    if (rz_activeAlerts == nil) {
        rz_activeAlerts = [NSMutableArray array];
        objc_setAssociatedObject(self, &RZAlertActiveKey, rz_activeAlerts, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return rz_activeAlerts;
}

- (NSMutableArray *)rz_alertQueue {
    NSMutableArray *rz_alertQueue = objc_getAssociatedObject(self, &RZAlertQueueKey);
    if (rz_alertQueue == nil) {
        rz_alertQueue = [NSMutableArray array];
        objc_setAssociatedObject(self, &RZAlertQueueKey, rz_alertQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return rz_alertQueue;
}

@end


@implementation RZAlertStyle

- (instancetype)initWithDefaultSytle {
    self = [super init];
    if (self) {
        self.titleColor = [[UIColor blackColor] colorWithAlphaComponent:1.f];
        self.titleFont = [UIFont boldSystemFontOfSize:16];
        self.titleAlignment = NSTextAlignmentCenter;
        
        self.messageColor = [[UIColor blackColor] colorWithAlphaComponent:1.f];
        self.messageFont = [UIFont systemFontOfSize:15];
        self.messageAlignment = NSTextAlignmentCenter;
        
        self.btnTitleColor = [[UIColor blueColor] colorWithAlphaComponent:1.f];
        self.btnTitleFont = [UIFont systemFontOfSize:15];
        
        self.contentViewBGColor = [UIColor whiteColor];
        self.cornerRadius = 13.f;
    }
    return self;
}

- (instancetype)init NS_UNAVAILABLE {
    return nil;
}

@end


@interface RZAlertManager ()

@property (nonatomic, strong) RZAlertStyle *sharedStyle;

@end

@implementation RZAlertManager

+ (instancetype)sharedManager {
    static RZAlertManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sharedStyle = [[RZAlertStyle alloc] initWithDefaultSytle];
    }
    return self;
}

+ (void)setSharedStyle:(RZAlertStyle *)sharedStyle {
    [[self sharedManager] setSharedStyle:sharedStyle];
}

+ (RZAlertStyle *)sharedStyle {
    return [[self sharedManager] sharedStyle];
}

@end

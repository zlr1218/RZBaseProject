//
//  UIControl+RZLimitClick.m
//  RZBaseProject
//
//  Created by os on 2018/11/15.
//  Copyright © 2018 RZOL. All rights reserved.
//

#import "UIControl+RZLimitClick.h"
#import <objc/runtime.h>


static NSString *const RZLimitClickKey = @"RZLimitClickKey";
static NSString *const RZLastTouchDate = @"RZLastTouchDate";

@interface UIControl ()

@property (nonatomic, assign) NSTimeInterval rz_lastTouchDate;    /**< 上一次点击时间 */

@end

@implementation UIControl (RZLimitClick)

- (void)setClickLimitInterval:(NSTimeInterval)clickLimitInterval {
    objc_setAssociatedObject(self, &RZLimitClickKey, @(clickLimitInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSTimeInterval)clickLimitInterval {
    return [objc_getAssociatedObject(self, &RZLimitClickKey) doubleValue];
}

- (void)setRz_lastTouchDate:(NSTimeInterval)rz_lastTouchDate {
    objc_setAssociatedObject(self, &RZLastTouchDate, @(rz_lastTouchDate), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSTimeInterval)rz_lastTouchDate {
    return [objc_getAssociatedObject(self, &RZLastTouchDate) doubleValue];
}


+ (void)load {
    NSString *className = NSStringFromClass(self.class);
    NSLog(@"classname %@", className);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //要特别注意你替换的方法到底是哪个性质的方法
        // When swizzling a Instance method, use the following:
        
        Class class = [self class];
        
        // When swizzling a class method, use the following:
        //        Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzledSelector = @selector(rz_sendAction:to:forEvent:);
        
        Method originalMethod = class_getInstanceMethod(self, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class,
                                            originalSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
}

- (void)rz_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    // 点击时间差 > 控制时间
    if (NSDate.date.timeIntervalSince1970 - self.rz_lastTouchDate >= self.clickLimitInterval) {
        [self rz_sendAction:action to:target forEvent:event];
    }
    if (self.clickLimitInterval > 0) {
        self.rz_lastTouchDate = NSDate.date.timeIntervalSince1970;
    }
}

@end

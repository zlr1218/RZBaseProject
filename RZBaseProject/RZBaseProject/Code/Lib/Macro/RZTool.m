//
//  RZTool.m
//  RZBaseProject
//
//  Created by os on 2019/3/25.
//  Copyright © 2019 RZOL. All rights reserved.
//

#import "RZTool.h"

@implementation RZTool

+ (UIWindow *)window {
    id appDelegate = [UIApplication sharedApplication].delegate;
    if (appDelegate && [appDelegate respondsToSelector:@selector(window)]) {
        return [appDelegate window];
    }
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    if ([windows count] == 1) {
        return [windows firstObject];
    } else {
        for (UIWindow *window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                return window;
            }
        }
    }
    
    return nil;
}

@end

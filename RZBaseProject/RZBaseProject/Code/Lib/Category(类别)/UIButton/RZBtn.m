//
//  RZBtn.m
//  RZBaseProject
//
//  Created by os on 2019/6/4.
//  Copyright © 2019 RZOL. All rights reserved.
//

#import "RZBtn.h"

@implementation RZBtn

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

@end

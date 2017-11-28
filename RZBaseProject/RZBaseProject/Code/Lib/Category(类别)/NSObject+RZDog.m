//
//  NSObject+RZDog.m
//  RZBaseProject
//
//  Created by 瑞仔 on 17/1/19.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "NSObject+RZDog.h"
#import <objc/runtime.h>

@implementation NSObject (RZDog)

static const  char *key = "name";

- (void)setName:(NSString *)name {
    return objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, key);
}

@end

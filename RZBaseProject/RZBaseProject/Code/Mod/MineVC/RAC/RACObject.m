//
//  RACObject.m
//  RZBaseProject
//
//  Created by 利基 on 2017/12/13.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RACObject.h"

@implementation RACObject

+ (instancetype)objectWithDict:(NSDictionary *)dict {
    RACObject *obj = [[RACObject alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}

@end

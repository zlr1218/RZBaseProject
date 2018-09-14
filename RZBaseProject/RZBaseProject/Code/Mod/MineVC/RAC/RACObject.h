//
//  RACObject.h
//  RZBaseProject
//
//  Created by 利基 on 2017/12/13.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RACObject : NSObject

/** account */
@property (nonatomic, copy) NSString *account;

/** name */
@property (nonatomic, copy) NSString *name;

+ (instancetype)objectWithDict:(NSDictionary *)dict;

@end

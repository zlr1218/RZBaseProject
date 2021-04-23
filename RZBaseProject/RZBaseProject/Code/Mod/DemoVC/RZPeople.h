//
//  RZPeople.h
//  RZBaseProject
//
//  Created by 技术平台开发部 on 2021/4/20.
//  Copyright © 2021 RZOL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RZPeople : NSObject

@property(nonatomic,  copy) NSString* name;
@property(nonatomic,strong) NSNumber* num;
@property(nonatomic,assign) int age;
@property(nonatomic,strong) NSArray* students;
@property(nonatomic,strong) NSDictionary* infoDic;

@end

NS_ASSUME_NONNULL_END

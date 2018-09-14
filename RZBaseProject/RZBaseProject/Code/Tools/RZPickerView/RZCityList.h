//
//  RZCityList.h
//  fengYouBaoTest02
//
//  Created by 利基 on 2017/6/23.
//  Copyright © 2017年 YS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZCityList : UIView

@property (nonatomic, copy) void(^RZCityListBlock)(NSArray *nameArr, NSArray *IDArr);

- (instancetype)initWithData:(NSArray *)dataArr;

@end

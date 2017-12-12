//
//  RZLoginViewModel.h
//  RZBaseProject
//
//  Created by 利基 on 2017/12/12.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"

@interface RZLoginViewModel : NSObject

/** 处理登录按钮是否可以点击 */
@property (nonatomic, assign) RACSignal *loginEnableSignal;

@end

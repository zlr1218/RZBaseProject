//
//  RZRequestViewModel.h
//  RZBaseProject
//
//  Created by 利基 on 2017/12/14.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"

@interface RZRequestViewModel : NSObject

/** 请求命令 */
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@end

//
//  RACBtn.h
//  RZBaseProject
//
//  Created by 利基 on 2017/12/11.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ReactiveObjC.h"

@interface RACBtn : UIView

/** signal */
@property (nonatomic, strong) RACSubject *btnSignal;

@end

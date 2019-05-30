//
//  RZBtn.h
//  RZBaseProject
//
//  Created by os on 2019/5/30.
//  Copyright © 2019 RZOL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RZBtn : UIView

@property (nonatomic, copy) NSString *title;    /**< 标题名称 */

@property (nonatomic, copy) void(^clickBlock)(void);    /**<    点击事件 */

@property (nonatomic, assign) NSInteger cornerRadius;    /**< 圆角 */

@end

NS_ASSUME_NONNULL_END

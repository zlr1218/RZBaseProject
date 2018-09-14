//
//  RZListPickerView.h
//  RZBaseProject
//
//  Created by 赵林瑞 on 16/11/2.
//  Copyright © 2016年 RZOL. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RZListPickerView : UIView

@property (nonatomic, copy) void(^RZPickerViewBlock)(NSArray*arr,NSArray*indexArr);

- (instancetype)initWithData:(NSArray *)dataArr;

@end

//
//  RZDelegate.h
//  RZBaseProject
//
//  Created by 利基 on 2017/12/8.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef void(^SelectRowBlock)(NSInteger row);

@interface RZDelegate : NSObject<UITableViewDelegate>

- (instancetype)initWithData:(NSArray *)arrStoreData SelectBlock:(SelectRowBlock)block;

@end

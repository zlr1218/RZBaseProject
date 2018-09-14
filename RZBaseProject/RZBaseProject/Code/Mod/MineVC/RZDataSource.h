//
//  RZDataSource.h
//  RZBaseProject
//
//  Created by 利基 on 2017/12/6.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



typedef void(^configureCell)(UITableViewCell *cell, NSString *title);

@interface RZDataSource : NSObject<UITableViewDataSource>

- (instancetype)initWithItems:(NSArray *)arrStoreModel
          CellReuseIdentifier:(NSString *)identifier
           configureCellBlock:(configureCell)block;

@end

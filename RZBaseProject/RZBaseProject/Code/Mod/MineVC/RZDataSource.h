//
//  RZDataSource.h
//  RZBaseProject
//
//  Created by 利基 on 2017/12/6.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RZMineModel.h"



typedef void(^configureCell)(UITableViewCell *, NSString *);

@interface RZDataSource : NSObject<UITableViewDataSource>

/** arrStoreModel */
@property (nonatomic, strong) NSArray *arrStoreModel;

/** reuseID */
@property (nonatomic, copy) NSString *cellID;

/** configureCell */
@property (nonatomic, copy) configureCell configureCellBlock;

- (id)initWithItems:(NSArray *)arrStoreModel
          CellReuseIdentifier:(NSString *)identifier
           configureCellBlock:(configureCell)block;

@end

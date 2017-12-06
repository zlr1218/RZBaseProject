//
//  RZDataSource.m
//  RZBaseProject
//
//  Created by 利基 on 2017/12/6.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZDataSource.h"

@implementation RZDataSource

- (id)initWithItems:(NSArray *)arrStoreModel
          CellReuseIdentifier:(NSString *)identifier
           configureCellBlock:(configureCell)block {
    self = [super init];
    if (self) {
        self.configureCellBlock = block;
        self.arrStoreModel = arrStoreModel;
        self.cellID = identifier;
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.arrStoreModel[indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrStoreModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellID];
    
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    
    return cell;
}

@end

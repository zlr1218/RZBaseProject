//
//  RZDelegate.m
//  RZBaseProject
//
//  Created by 利基 on 2017/12/8.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZDelegate.h"


@interface RZDelegate ()

/** data */
@property (nonatomic, strong) NSArray *ArrStoreData;
@property (nonatomic, copy) SelectRowBlock block;

@end

@implementation RZDelegate

- (instancetype)initWithData:(NSArray *)arrStoreData SelectBlock:(SelectRowBlock)block {
    self = [super init];
    if (self) {
        self.ArrStoreData = arrStoreData;
        self.block = block;
    }
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.block) {
        self.block(indexPath.row);
    }
}

@end

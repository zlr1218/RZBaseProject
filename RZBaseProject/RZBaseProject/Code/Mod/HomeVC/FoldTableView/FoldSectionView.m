//
//  FoldSectionView.m
//  RZBaseProject
//
//  Created by 利基 on 2017/7/26.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "FoldSectionView.h"

@implementation FoldSectionView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)sectionSelectAction:(id)sender {
    if (self.sectionSelectBlock) {
        self.sectionSelectBlock();
    }
}

@end

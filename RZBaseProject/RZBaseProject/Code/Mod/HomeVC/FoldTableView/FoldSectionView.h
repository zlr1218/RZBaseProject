//
//  FoldSectionView.h
//  RZBaseProject
//
//  Created by 利基 on 2017/7/26.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoldSectionView : UIView

@property (weak, nonatomic) IBOutlet UILabel *sectionTitle;
@property (weak, nonatomic) IBOutlet UIImageView *sectionIcon;
@property (weak, nonatomic) IBOutlet UIButton *sectionSelectBtn;

/** sectionSelectBlock */
@property (nonatomic, copy) void(^sectionSelectBlock)();

@end

//
//  RZAnswerCell.m
//  RZBaseProject
//
//  Created by 技术平台开发部 on 2021/3/10.
//  Copyright © 2021 RZOL. All rights reserved.
//

#import "RZAnswerCell.h"


@interface RZAnswerCell ()

@property (weak, nonatomic) IBOutlet UIView *optionBG;

@property (weak, nonatomic) IBOutlet UILabel *optionN;

@property (weak, nonatomic) IBOutlet UILabel *optionC;

@property (weak, nonatomic) IBOutlet UIImageView *optionIcon;

@end

@implementation RZAnswerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = RZ_COLOR(235, 239, 242, 1);
    self.optionBG.layer.cornerRadius = 8;
    self.optionBG.layer.borderColor = UIColor.darkGrayColor.CGColor;
}

- (void)setOptionNum:(NSString *)optionNum {
    _optionNum = optionNum;
    self.optionN.text = optionNum;
}

- (void)setOptionContent:(NSString *)optionContent {
    _optionContent = optionContent;
    self.optionC.text = optionContent;
}

- (void)setSelectNum:(NSInteger)selectNum {
    _selectNum = selectNum;
    
    if (selectNum > 0) {
        self.optionBG.layer.borderWidth = 0;
        self.optionBG.backgroundColor = RZ_White_Color;
        self.optionN.textColor = RZ_COLOR(60, 109, 255, 1);
        self.optionC.textColor = RZ_COLOR(60, 109, 255, 1);
        self.optionIcon.hidden = NO;
    } else {
        self.optionBG.backgroundColor = RZ_COLOR(235, 239, 242, 1);
        self.optionBG.layer.borderWidth = 0.5;
        self.optionN.textColor = UIColor.darkGrayColor;
        self.optionC.textColor = UIColor.darkGrayColor;
        self.optionIcon.hidden = YES;
    }
}

@end

//
//  RZBtn.m
//  RZBaseProject
//
//  Created by os on 2019/5/30.
//  Copyright © 2019 RZOL. All rights reserved.
//

#import "RZBtn.h"

@interface RZBtn ()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *lab;

@end

@implementation RZBtn

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [[NSBundle mainBundle] loadNibNamed:@"RZBtn" owner:self options:nil];
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSBundle mainBundle] loadNibNamed:@"RZBtn" owner:self options:nil];
    [self addSubview:self.contentView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.lab.text = title;
}

- (void)setCornerRadius:(NSInteger)cornerRadius {
    _cornerRadius = cornerRadius;
    
    self.contentView.layer.cornerRadius = cornerRadius;
    self.contentView.layer.masksToBounds = YES;
}

- (IBAction)clickAction:(id)sender {
    if (self.clickBlock) {
        self.clickBlock();
    }
}
@end

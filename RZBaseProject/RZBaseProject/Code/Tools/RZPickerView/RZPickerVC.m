//
//  RZPickerVC.m
//  RZBaseProject
//
//  Created by os on 2019/5/27.
//  Copyright © 2019 RZOL. All rights reserved.
//

#import "RZPickerVC.h"
#import "RZDatePickerView.h"

@interface RZPickerVC ()

@end

@implementation RZPickerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)clickAction:(id)sender {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, kScreeWith, 250)];
    [self.view addSubview:contentView];
    contentView.backgroundColor = RZ_Orange_Color;
    
    RZDatePickerView *pick = [[NSBundle mainBundle] loadNibNamed:@"RZDatePickerView" owner:nil options:nil].lastObject;
    pick.frame = contentView.bounds;
    [contentView addSubview:pick];
}

@end

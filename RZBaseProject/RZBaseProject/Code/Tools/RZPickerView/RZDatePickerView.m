//
//  RZDatePickerView.m
//  RZBaseProject
//
//  Created by os on 2019/5/27.
//  Copyright © 2019 RZOL. All rights reserved.
//

#import "RZDatePickerView.h"

@interface RZDatePickerView ()

@property (weak, nonatomic) IBOutlet UIPickerView *picker01;
@property (weak, nonatomic) IBOutlet UIPickerView *picker02;
@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation RZDatePickerView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = RZ_LightGray_Color;
    
    self.picker01.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth; //这里设置了就可以自定义高度
    self.picker02.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth; //这里设置了就可以自定义高度
    
    self.picker01.delegate = self;
    self.picker02.delegate = self;
    
    self.picker01.dataSource = self;
    self.picker02.dataSource = self;
}

- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@"1", @"22", @"333", @"44", @"5"];
    }
    return _dataArr;
}

#pragma mark - pickerView的代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {// 列
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {// 每列对应的行数
    return self.dataArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {// 每列每行对应的内容
    
    NSString *rowStr = self.dataArr[row];
    return rowStr;
}

@end

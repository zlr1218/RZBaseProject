//
//  RZCityList.m
//  fengYouBaoTest02
//
//  Created by 利基 on 2017/6/23.
//  Copyright © 2017年 YS. All rights reserved.
//

#import "RZCityList.h"


#define kRZPikerWidth [UIScreen mainScreen].bounds.size.width
#define kRZPikerHeight [UIScreen mainScreen].bounds.size.height
#define kRZPikerSCREEN_SCALE  (kRZPikerWidth/320.f)
#define kRZLAB_FONT(x) [UIFont systemFontOfSize:x*kRZPikerSCREEN_SCALE]

// 升降位置
#define pickerBGUpRect CGRectMake(0, kRZPikerHeight - 256, kRZPikerWidth, 256)
#define pickerBGDownRect CGRectMake(0, kRZPikerHeight, kRZPikerWidth, 256)
// 背景颜色
#define pickerBGColor [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3]

@interface RZCityList ()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    NSInteger _FirstIndex;
    NSInteger _SecondIndex;
}

@property (nonatomic, strong) UIView *pickerBgView;// 工具栏 pickerView的背景
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic,strong)UIToolbar *toolBarOne;

@property (nonatomic, strong) NSMutableArray *dataArr;// 原始数据
@property (nonatomic, strong) NSMutableArray *selectedData;// 初始选中数据
@property (nonatomic, strong) NSMutableArray *indexData;// 初始选中坐标

@end

@implementation RZCityList

#pragma mark - 懒加载
- (UIView *)pickerBgView {
    if (!_pickerBgView) {
        _pickerBgView = [[UIView alloc] initWithFrame:pickerBGDownRect];
        [_pickerBgView addSubview:self.toolBarOne];
        [_pickerBgView addSubview:self.pickerView];
    }
    return _pickerBgView;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.frame = CGRectMake(0, 40, kRZPikerWidth, 216);
        _pickerView.backgroundColor = [UIColor whiteColor];
        
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        
        // 选中的数据，选中的坐标
        self.selectedData = [NSMutableArray array];
        self.indexData = [NSMutableArray array];
        
        _FirstIndex = 0;
        _SecondIndex = 0;
        
        [_pickerView selectRow:_FirstIndex inComponent:_SecondIndex animated:YES];
        
        [self.selectedData addObject:self.dataArr[_FirstIndex][@"province"]];
        [self.selectedData addObject:self.dataArr[_FirstIndex][@"citys"][_SecondIndex][@"name"]];
        
        [self.indexData addObject:self.dataArr[_FirstIndex][@"code"]];
        [self.indexData addObject:self.dataArr[_FirstIndex][@"citys"][_SecondIndex][@"code"]];
    }
    return _pickerView;
}

- (UIToolbar *)toolBarOne {
    
    if (_toolBarOne == nil) {
        
        _toolBarOne = [self setToolbarStyle:@"" andCancel:@"取消" andSure:@"确定"];
    }
    
    return _toolBarOne;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (instancetype)initWithData:(NSArray *)dataArr {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kRZPikerWidth, kRZPikerHeight);
        if (dataArr != nil && dataArr.count > 0) {
            for (id obj in dataArr) {
                [self.dataArr addObject:obj];
            }
        }
        [self setupUI];
    }
    return self;
}

#pragma mark - UI
- (void)setupUI {
    [self addSubview:self.pickerBgView];
    UIWindow *currentWindows = [UIApplication sharedApplication].keyWindow;
    self.backgroundColor = pickerBGColor;
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerBgView.frame = pickerBGUpRect;
    }];
    [currentWindows addSubview:self];
}

-  (UIToolbar *)setToolbarStyle:(NSString *)titleString andCancel:(NSString *)cancelString andSure:(NSString *)sureString{
    
    UIToolbar *toolbar=[[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, kRZPikerWidth, 40);
    
//    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kRZPikerWidth , 40)];
//    lable.backgroundColor = [UIColor colorWithRed:255/255.0 green:205/255.0 blue:51/255.0 alpha:1.0];
//    lable.text = titleString;
//    lable.textAlignment = 1;
//    lable.textColor = [UIColor whiteColor];
//    lable.numberOfLines = 1;
//    lable.font = [UIFont systemFontOfSize:18];
//    [toolbar addSubview:lable];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.backgroundColor = [UIColor clearColor];
    cancelBtn.frame = CGRectMake(0, 5, 40, 35);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    cancelBtn.layer.cornerRadius = 2;
    cancelBtn.layer.masksToBounds = YES;
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn setTitle:cancelString forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(remove:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseBtn.backgroundColor = [UIColor clearColor];
    chooseBtn.frame = CGRectMake(0, 5, 40, 35);
    chooseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    chooseBtn.layer.cornerRadius = 2;
    chooseBtn.layer.masksToBounds = YES;
    [chooseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [chooseBtn setTitle:sureString forState:UIControlStateNormal];
    [chooseBtn addTarget:self action:@selector(doneItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    
    UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    centerSpace.width = 70;
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:chooseBtn];
    
    toolbar.items=@[leftItem,centerSpace,rightItem];
    toolbar.backgroundColor = [UIColor whiteColor];
    
    return toolbar;
}
//点击取消按钮
- (void)remove:(UIButton *) btn {
    [self animationWithBackgroud];
}
//点击确定按钮
- (void)doneItemClick:(UIButton *) btn {
    [self animationWithBackgroud];
    
    if (self.RZCityListBlock) {
        self.RZCityListBlock(self.selectedData, self.indexData);
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self animationWithBackgroud];
}
- (void)animationWithBackgroud {
    [UIView animateWithDuration:0.3 animations:^{
        self.pickerBgView.frame = pickerBGDownRect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - pickerView的代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {// 列
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {// 每列对应的行数
    if (component == 0) {
        return self.dataArr.count;
    }else{
        return [[self.dataArr[_FirstIndex] objectForKey:@"citys"] count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {// 每列每行对应的内容
    if (component == 0) {
        return self.dataArr[row][@"province"];
    }
    return self.dataArr[_FirstIndex][@"citys"][row][@"name"];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {// 点击返回的数据与坐标
    if (component == 0) {
        _FirstIndex = row;
        _SecondIndex = 0;
        [self.pickerView reloadComponent:1];
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
    }
    if (component == 1) {
        _SecondIndex = row;
    }
    
    self.selectedData[0] = self.dataArr[_FirstIndex][@"province"];
    self.selectedData[1] = self.dataArr[_FirstIndex][@"citys"][_SecondIndex][@"name"];
    
    self.indexData[0] = self.dataArr[_FirstIndex][@"code"];
    self.indexData[1] = self.dataArr[_FirstIndex][@"citys"][_SecondIndex][@"code"];
    
    //RZLog(@"%zi - %zi", _FirstIndex, _SecondIndex);
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        //[pickerLabel setFont:[UIFont systemFontOfSize:15]];
        [pickerLabel setFont:kRZLAB_FONT(15)];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

@end

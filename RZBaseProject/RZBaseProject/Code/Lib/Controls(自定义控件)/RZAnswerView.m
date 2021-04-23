//
//  RZAnswerView.m
//  RZBaseProject
//
//  Created by 技术平台开发部 on 2021/3/10.
//  Copyright © 2021 RZOL. All rights reserved.
//

#import "RZAnswerView.h"
#import "RZAnswerCell.h"


@interface RZAnswerView ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *listTable;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSArray *questionArr;

@property (nonatomic, assign) CGFloat sHeight;
@property (nonatomic, assign) CGFloat sWidth;

@end

@implementation RZAnswerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.sWidth  = CGRectGetWidth(frame);
        self.sHeight = CGRectGetHeight(frame);
        [self setupUIWithFrame:frame];
        
        for (NSDictionary *obj in self.questionArr[0][@"options"]) {
            [self.dataArr addObject:obj];
        }
        [self.listTable reloadData];
    }
    return self;
}

- (void)setupUIWithFrame:(CGRect)frame {
    self.backgroundColor = RZ_COLOR(235, 239, 242, 1);
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.sWidth, self.sHeight) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [table registerNib:[UINib nibWithNibName:@"RZAnswerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"RZAnswerCell"];
    table.tableFooterView = [UIView new];
    table.backgroundColor = RZ_COLOR(235, 239, 242, 1);
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:table];
    self.listTable = table;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RZAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RZAnswerCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"RZAnswerCell" owner:self options:nil].lastObject;
    }
    
    NSDictionary *dict = self.dataArr[indexPath.row];
    cell.selectNum = [dict[@"optionSelect"] integerValue];
//    cell.optionNum = [dict[@""]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dataArr[indexPath.row];
    NSInteger select = [dict[@"optionSelect"] integerValue];
    NSMutableDictionary *mDict = dict.mutableCopy;
    mDict[@"optionSelect"] = select==0 ? @"1" : @"0";
    self.dataArr[indexPath.row] = mDict;
    [self.listTable reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *content = [[UIView alloc] init];

    UILabel *queContent = [[UILabel alloc] initWithFrame:CGRectZero];
    queContent.text = @"10、【判断题】世纪东方两件事都if建设路口江东父老开始搭建老婆婆漂流记评价欧派基督教搜你开票决胜巅峰领导看佛教扣扣扣上卡片";
    queContent.numberOfLines = 0;
    queContent.textColor = UIColor.darkGrayColor;
    [content addSubview:queContent];

    [queContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(content).offset(16);
        make.top.mas_equalTo(0);
        make.right.equalTo(content).offset(-26);
        make.height.mas_equalTo(100);
    }];

    return content;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *content = [[UIView alloc] init];

    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(self.sWidth-86, 50, 70, 30);
    [nextBtn setTitle:@"下一题" forState:UIControlStateNormal];
    [content addSubview:nextBtn];

    return content;
}

- (NSArray *)questionArr {
    if (!_questionArr) {
        _questionArr = @[@{@"question": @"就是点击分类三级屁哦发了卡两地分居阿里",
                           @"options": @[
                                   @{@"optionNum": @"A、", @"optionContent": @"特别危害", @"optionSelect": @"0"},
                                   @{@"optionNum": @"B、", @"optionContent": @"领导指示", @"optionSelect": @"0"},
                                   @{@"optionNum": @"C、", @"optionContent": @"停车场", @"optionSelect": @"0"}]
                         },
                         @{@"question": @"手动阀叫哦我福利卡是多么佛我安静",
                           @"options": @[
                                   @{@"optionNum": @"A、", @"optionContent": @"特别危害", @"optionSelect": @"0"},
                                   @{@"optionNum": @"B、", @"optionContent": @"领导指示", @"optionSelect": @"0"},
                                   @{@"optionNum": @"C、", @"optionContent": @"停车场", @"optionSelect": @"0"},
                                   @{@"optionNum": @"D、", @"optionContent": @"停车场2", @"optionSelect": @"0"} ]
                         }];
    }
    return _questionArr;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end

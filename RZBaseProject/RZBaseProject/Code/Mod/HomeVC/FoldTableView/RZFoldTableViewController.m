//
//  RZFoldTableViewController.m
//  RZBaseProject
//
//  Created by 利基 on 2017/7/26.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZFoldTableViewController.h"
#import "FoldSectionView.h"

@interface RZFoldTableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *foldTableView;
/** sectionViewArr */
@property (nonatomic, strong) NSMutableArray *sectionViewArr;
/** sectionTitleArr */
@property (nonatomic, strong) NSMutableArray *sectionTitleArr;
/* 用来记录某一组的状态 */
@property (nonatomic, strong) NSMutableArray *foldArray;

@end

@implementation RZFoldTableViewController

static NSString *const recellID = @"foldCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

- (void)setupTableView {
    self.foldTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.foldTableView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - tableView的代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionTitleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSNumber *number = self.foldArray[section];
    BOOL isOpen = number.boolValue;
    return isOpen ? 1 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recellID];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FoldSectionView *sectionView = (FoldSectionView *)self.sectionViewArr[section];
    
    __weak typeof(sectionView) weakSectionView = sectionView;
    [sectionView setSectionSelectBlock:^{
        NSNumber *number = self.foldArray[section];
        BOOL isOpen = number.boolValue;
        [self.foldArray replaceObjectAtIndex:section withObject:@(!isOpen)];
        
        // 箭头翻转
        [UIView animateWithDuration:0.35 animations:^{
            weakSectionView.sectionIcon.transform = CGAffineTransformRotate(weakSectionView.sectionIcon.transform, -M_PI);
        }];
        
        [self.foldTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationLeft];
    }];
    
    return sectionView;
}

#pragma mark - 懒加载

- (NSMutableArray *)sectionViewArr {
    if (!_sectionViewArr) {
        _sectionViewArr = [NSMutableArray array];
        
        for (int i = 0; i < self.sectionTitleArr.count; i++) {
            FoldSectionView *view = [[NSBundle mainBundle] loadNibNamed:@"FoldSectionView" owner:self options:nil].lastObject;
            view.sectionTitle.text = self.sectionTitleArr[i];
            [_sectionViewArr addObject:view];
        }
    }
    return _sectionViewArr;
}

- (NSMutableArray *)sectionTitleArr {
    if (!_sectionTitleArr) {
        _sectionTitleArr = [NSMutableArray array];
        [_sectionTitleArr addObject:@"line - 1"];
        [_sectionTitleArr addObject:@"line - 2"];
    }
    return _sectionTitleArr;
}

- (NSMutableArray *)foldArray {
    if (!_foldArray) {
        _foldArray = [NSMutableArray array];
        for (int i= 0; i < self.sectionTitleArr.count; i++) {
            [_foldArray addObject:@(NO)];
        }
    }
    return _foldArray;
}

@end

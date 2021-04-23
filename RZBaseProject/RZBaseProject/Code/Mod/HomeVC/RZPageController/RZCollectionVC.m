//
//  RZCollectionVC.m
//  RZBaseProject
//
//  Created by 技术平台开发部 on 2021/1/15.
//  Copyright © 2021 RZOL. All rights reserved.
//

#import "RZCollectionVC.h"
#import "ZLCollectionViewVerticalLayout.h"
#import "RZCustomCell.h"
#import "RZHeaderCollectionView.h"

static NSString *const reCellID = @"RZCustomCell";
static NSString *const reHeaderID = @"RZHeaderCollectionView";
static NSString *const reFooterID = @"RZFooterCollectionView";

@interface RZCollectionVC ()<UICollectionViewDelegate, UICollectionViewDataSource, ZLCollectionViewBaseFlowLayoutDelegate>

@property(nonatomic, strong) UICollectionView *RZCollection;

@property (nonatomic, strong) NSMutableArray *dataArr;    /**< 数据 */

@end

@implementation RZCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.orangeColor;
    
    [self.RZCollection registerNib:[UINib nibWithNibName:reCellID bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reCellID];
    [self.RZCollection registerNib:[UINib nibWithNibName:reHeaderID bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reHeaderID];
    [self.RZCollection registerNib:[UINib nibWithNibName:reHeaderID bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reFooterID];
    [self.view addSubview:self.RZCollection];
}

#pragma mark - collectionView delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 6;
    } else if (section == 2) {
        return 4;
    } else if (section == 3) {
        return 3;
    } else if (section == 4) {
        return 4;
    }
    return 3;
}

// 垂直方向-item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else if (section == 1) {
        return 15;
    } else if (section == 2) {
        return 15;
    } else if (section == 3) {
        return 0;
    } else if (section == 4) {
        return 0;
    }
    return 0;
}

// 水平方向-item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return 0;
    } else if (section == 1) {
        return 15;
    } else if (section == 2) {
        return 15;
    } else if (section == 3) {
        return 0;
    } else if (section == 4) {
        return 0;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(kScreeWith, 150);
    } else if (indexPath.section == 1) {
        CGFloat w = (kScreeWith-90)/5.f;
        return CGSizeMake(w, w);
    } else if (indexPath.section == 2) {
        CGFloat w = (kScreeWith-45)/2.f;
        return CGSizeMake(w, w);
    } else if (indexPath.section == 3) {
        return CGSizeMake(kScreeWith-30, 50);
    } else if (indexPath.section == 4) {
        return CGSizeMake(165, 165);
    }
    return CGSizeMake(kScreeWith-30, 50);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsZero;
    } else if (section == 1) {
        return UIEdgeInsetsMake(15, 15, 15, 15);
    } else {
        return UIEdgeInsetsMake(15, 15, 15, 15);
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RZCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reCellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:reCellID owner:self options:nil].lastObject;
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kScreeWith, 100);
//    return CGSizeMake(0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kScreeWith, 100);
//    return CGSizeMake(0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        RZHeaderCollectionView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reHeaderID forIndexPath:indexPath];
        if (!header) {
            header = [[NSBundle mainBundle] loadNibNamed:reHeaderID owner:self options:nil].lastObject;
        }
        header.BGView.backgroundColor = UIColor.grayColor;
        return header;
    } else {
        RZHeaderCollectionView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reFooterID forIndexPath:indexPath];
        if (!footer) {
            footer = [[NSBundle mainBundle] loadNibNamed:reHeaderID owner:self options:nil].lastObject;
        }
        footer.BGView.backgroundColor = UIColor.greenColor;
        return footer;
    }
}

#pragma mark - 懒加载

- (UICollectionView *)RZCollection {
    if (!_RZCollection) {
//        ZLCollectionViewVerticalLayout *flowLayout = [[ZLCollectionViewVerticalLayout alloc] init];
//        flowLayout.delegate = self;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        /*
         
         @property (nonatomic) CGFloat minimumLineSpacing;
         @property (nonatomic) CGFloat minimumInteritemSpacing;
         @property (nonatomic) CGSize itemSize;
         @property (nonatomic) CGSize estimatedItemSize API_AVAILABLE(ios(8.0));
         @property (nonatomic) UICollectionViewScrollDirection scrollDirection;
         @property (nonatomic) CGSize headerReferenceSize;
         @property (nonatomic) CGSize footerReferenceSize;
         @property (nonatomic) UIEdgeInsets sectionInset;
         
         */
        // 定义大小
//        layout.itemSize = CGSizeMake(100, 100);
        // 设置最小行间距
        layout.minimumLineSpacing = 0;
        // 设置垂直间距
        layout.minimumInteritemSpacing = 0;
        // 设置滚动方向（默认垂直滚动）
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        CGRect frame = CGRectMake(0, 0, kScreeWith, kScreeHeight-kRZTopHeight-kRZBottomHeight);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = UIColor.whiteColor;
        collectionView.alwaysBounceVertical = YES;
        _RZCollection = collectionView;
    }
    return _RZCollection;
}

@end

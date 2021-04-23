//
//  RZAnswerCell.h
//  RZBaseProject
//
//  Created by 技术平台开发部 on 2021/3/10.
//  Copyright © 2021 RZOL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RZAnswerCell : UITableViewCell

@property (nonatomic, assign) NSInteger selectNum;

@property (nonatomic, copy) NSString *optionNum;

@property (nonatomic, copy) NSString *optionContent;

@end

NS_ASSUME_NONNULL_END

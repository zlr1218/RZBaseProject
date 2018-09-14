//
//  RZGCDVC.m
//  RZBaseProject
//
//  Created by os on 2018/8/15.
//  Copyright © 2018年 RZOL. All rights reserved.
//

#import "RZGCDVC.h"

@interface RZGCDVC ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *gcdTableView;

@end

@implementation RZGCDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuseCellID"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"line %li", indexPath.row];
    
    return cell;
}

@end

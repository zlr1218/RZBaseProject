//
//  RZBGFMDBVC.m
//  RZBaseProject
//
//  Created by 技术平台开发部 on 2021/4/20.
//  Copyright © 2021 RZOL. All rights reserved.
//

#import "RZBGFMDBVC.h"
#import <BGFMDB/BGFMDB.h>
#import "RZPeople.h"

@interface RZBGFMDBVC ()

@end

@implementation RZBGFMDBVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 打开BGFMDB调试开关
    bg_setDebug(YES);
    
    for (NSInteger i = 0; i < 10; i++) {
        RZPeople *people = [[RZPeople alloc] init];
        people.name = [NSString stringWithFormat:@"张三%li", (long)i];
        if (i == 8) {
            people.age = 25;
        } else {
            people.age = 20;
        }
        people.bg_id = @(i+21);
        people.bg_tableName = @"RZPeople";
        [people bg_save];
    }
    NSArray *all = [RZPeople bg_findAll:@"RZPeople"];
    RZLog(@"%@", [all valueForKeyPath:@"name"]);
    NSString *where = [NSString stringWithFormat:@"where %@=%@ or %@=%@", bg_sqlKey(@"name"), bg_sqlValue(@"张三0"), bg_sqlKey(@"age"), bg_sqlValue(@(25))];
    NSArray *arr = [RZPeople bg_find:@"RZPeople" where:where];
    RZLog(@"%@", [arr valueForKeyPath:@"name"]);
}



@end

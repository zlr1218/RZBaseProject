//
//  RZUpdateLocationVC.m
//  RZBaseProject
//
//  Created by os on 2019/3/20.
//  Copyright © 2019 RZOL. All rights reserved.
//

#import "RZUpdateLocationVC.h"
#import "RZLocation.h"

@interface RZUpdateLocationVC ()

@property (weak, nonatomic) IBOutlet UITextView *showText;

@end

@implementation RZUpdateLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     应用程序始终使用定位服务      NSLocationAlwaysUsageDescription
     使用应用程序期间使用定位服务   NSLocationWhenInUseUsageDescription
     应用程序始终使用定位服务      NSLocationAlwaysAndWhenInUseUsageDescription（始终允许，iOS11新增）
     在iOS11时，NSLocationAlwaysAndWhenInUseUsageDescription表示始终允许，NSLocationAlwaysUsageDescription在功能上被降级为为“应用使用期间”
     */
}

- (IBAction)startUpdateLocation:(id)sender {
    [[RZLocation shareInstance] startLocationSuccess:^(CLPlacemark *placemark) {
        _showText.text = [NSString stringWithFormat:@"%@", placemark.addressDictionary];
    } Failed:^(NSError *error) {}];
}

@end

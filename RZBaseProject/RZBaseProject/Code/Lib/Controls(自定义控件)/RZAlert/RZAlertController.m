//
//  RZAlertController.m
//  RZBaseProject
//
//  Created by 利基 on 2017/11/13.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZAlertController.h"

@implementation RZAlertController

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message actionLeftTitle:(NSString *)leftTitle lefthandler:(alertLeftBlock)leftHandler showVC:(UIViewController *)vc {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    if (leftTitle == nil || leftTitle.length == 0 || ![leftTitle isKindOfClass:[NSString class]]) {
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (leftHandler) {
                leftHandler();
            }
        }];
        [alert addAction:defaultAction];
    }else{
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (leftHandler) {
                leftHandler();
            }
        }];
        [alert addAction:defaultAction];
    }
    [vc presentViewController:alert animated:YES completion:nil];
}

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
       actionLeftTitle:(NSString *)leftTitle
           lefthandler:(alertLeftBlock)leftHandler
      actionRightTitle:(NSString *)rightTitle
          righthandler:(alertRightBlock)rightHandler
                showVC:(UIViewController *)vc {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (leftTitle == nil || leftTitle.length == 0 || ![leftTitle isKindOfClass:[NSString class]]) {
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (leftHandler) {
                leftHandler();
            }
        }];
        [alert addAction:defaultAction];
    }else{
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (leftHandler) {
                leftHandler();
            }
        }];
        [alert addAction:defaultAction];
    }
    
    if (rightTitle == nil || rightTitle.length == 0 || ![rightTitle isKindOfClass:[NSString class]]) {
        UIAlertAction *rightAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (rightHandler) {
                rightHandler();
            }
        }];
        [alert addAction:rightAction];
    }else{
        UIAlertAction *rightAction = [UIAlertAction actionWithTitle:rightTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (rightHandler) {
                rightHandler();
            }
        }];
        [alert addAction:rightAction];
    }
    
    [vc presentViewController:alert animated:YES completion:nil];
}

@end

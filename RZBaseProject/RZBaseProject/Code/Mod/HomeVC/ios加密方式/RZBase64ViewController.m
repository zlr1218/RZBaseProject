//
//  RZBase64ViewController.m
//  RZBaseProject
//
//  Created by 瑞仔 on 2017/2/19.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZBase64ViewController.h"
#import "RZEncryptionTool.h"


@interface RZBase64ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

@property (weak, nonatomic) IBOutlet UITextView *encryptAndDecryptTextView;
@end

@implementation RZBase64ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)base64:(id)sender {
    NSDictionary *dict = @{
                           @"1": @"123",
                           @"2": @"234",
                           @"3": @[@"1",@"2"],
                           @"4": @[@"1",@"2"]
                           };
    NSArray *array = @[@"1", @"2",@"3",@"4"];
    
    NSString *dict_base64Encode = [RZEncryptionTool MF_base64EncodeWithJSON:dict];
    NSString *arr_base64Encode = [RZEncryptionTool MF_base64EncodeWithJSON:array];
    
    if (self.inputTextView.text.length > 0) {
        NSData *data = [self.inputTextView.text dataUsingEncoding:NSUTF8StringEncoding];
        NSString *base64Encode = [data base64EncodedStringWithOptions:0];
        
        NSData *dataFromBase64String = [[NSData alloc] initWithBase64EncodedString:base64Encode options:0];
        NSString *base64Decode = [[NSString alloc] initWithData:dataFromBase64String encoding:NSUTF8StringEncoding];
        self.encryptAndDecryptTextView.text = [NSString stringWithFormat:@"%@\n %@", base64Encode, base64Decode];
    } else {
        self.encryptAndDecryptTextView.text = [NSString stringWithFormat:@"  %@\n%@\n  %@\n%@", dict_base64Encode,[RZEncryptionTool MF_base64DecodeWithString:dict_base64Encode],arr_base64Encode,[RZEncryptionTool MF_base64DecodeWithString:arr_base64Encode]];
    }
}

- (IBAction)DES:(id)sender {
}

- (IBAction)AES:(id)sender {
}

@end

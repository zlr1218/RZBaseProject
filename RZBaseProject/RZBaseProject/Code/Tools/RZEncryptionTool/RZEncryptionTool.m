//
//  RZEncryptionTool.m
//  RZBaseProject
//
//  Created by 利基 on 2017/2/20.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import "RZEncryptionTool.h"
#import "MF_Base64Additions.h"


@implementation RZEncryptionTool

+ (NSString *)base64EncodeWithJSON:(id)ID {
    NSData *data = [NSJSONSerialization dataWithJSONObject:ID options:NSJSONWritingPrettyPrinted error:nil];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    return base64String;
}
+ (NSString *)MF_base64EncodeWithJSON:(id)ID {
    NSData *data = [NSJSONSerialization dataWithJSONObject:ID options:NSJSONWritingPrettyPrinted error:nil];
    NSString *base64String = [MF_Base64Codec base64StringFromData:data];
    return base64String;
}
+ (id)base64DecodeWithString:(NSString *)str {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:0];
    NSJSONSerialization *temp = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return temp;
}
+ (id)MF_base64DecodeWithString:(NSString *)str {
    NSData *data = [MF_Base64Codec dataFromBase64String:str];
    NSJSONSerialization *temp = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return temp;
}

@end

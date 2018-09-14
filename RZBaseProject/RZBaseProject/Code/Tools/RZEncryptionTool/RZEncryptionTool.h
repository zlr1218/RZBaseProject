//
//  RZEncryptionTool.h
//  RZBaseProject
//
//  Created by 利基 on 2017/2/20.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import <Foundation/Foundation.h>



/** 
 
 Base64编码：可以将任意的二进制数据进行Base64编码（只用65个字符就能表示的文本文件）
     65字符：A~Z a~z 0~9 + / =
 
 #import "MF_Base64Additions.h"
 NSString *helloWorld = @"Hello World";
 NSString *helloInBase64 = [helloWorld base64String];
 NSString *helloDecoded = [NSString stringFromBase64String:helloInBase64];
 
 */


@interface RZEncryptionTool : NSObject

/** NSArray NSDictionary 进行base64编码 */
+ (NSString *)base64EncodeWithJSON:(id)ID;
+ (NSString *)MF_base64EncodeWithJSON:(id)ID;

/** NSString 进行base64编码 */
+ (id)base64DecodeWithString:(NSString *)str;
+ (id)MF_base64DecodeWithString:(NSString *)str;
@end

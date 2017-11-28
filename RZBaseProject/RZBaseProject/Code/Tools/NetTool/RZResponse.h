//
//  RZResponse.h
//  RZBaseProject
//
//  Created by 利基 on 2017/3/10.
//  Copyright © 2017年 RZOL. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, VPKCHttpStatusCode) {
    
    /// 业务正常处理
    VPKCStatusCode_OK = 200,
    
    /// 袋鼠家业务错误，返回错误码和错误信息
    VPKCStatusCode_Accepted = 202,
    
    /// 上行参数不符合定义，比较必须参数、json格式、数据类型等
    VPKCStatusCode_BadRequest = 400,
    
    /// 权限不够，hmac问题
    VPKCStatusCode_Unauthorized = 401,
    
    /// 请求的uri不符合协议规定，在服务器无法找到对应的处理器
    VPKCStatusCode_NotFound = 404,
    
    /// 服务器异常
    VPKCStatusCode_InternalServerError = 500,
    
    /// 接口对应的服务未部署
    VPKCStatusCode_BadGateway = 502,
    
};


@interface RZResponse : NSObject


/// 请求返回 responseObject
@property(copy, nonatomic) id responseObject;
//
/// 请求头信息
@property (copy, nonatomic) id headerFields;
//
/// AFNetworking返回错误信息
@property(strong, nonatomic) NSError *error;
//
//
///// 服务器状态码
@property (strong, nonatomic) NSNumber *status;

///// 202状态错误码
@property (strong, nonatomic) NSNumber *errorCode;
//
///// 202状态错误描述信息
@property (copy, nonatomic) NSString *errorDescription;
//
///// 弹框显示内容
@property (nonatomic, copy) NSString *content;

@end

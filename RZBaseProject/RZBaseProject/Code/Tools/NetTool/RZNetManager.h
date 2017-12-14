//
//  RZNetManager.h
//  RZNetWorking
//
//  Created by 赵林瑞 on 16/9/14.
//  Copyright © 2016年 ROL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


// 项目打包上线都不会打印日志，因此可放心。
//#ifdef DEBUG
//#define RZLog(s, ... ) NSLog( @"[%@ %s line: %d] -----> \n%@\n\n", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __func__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
//#else
//#define RZLog(s, ... )
//#endif



typedef NS_ENUM(NSUInteger, RZNetWorkStatus)
{
    /*! 未知网络 */
    RZNetworkStatusUnknown           = 0,
    /*! 没有网络 */
    RZNetworkStatusNotReachable,
    /*! 手机自带网络 */
    RZNetworkStatusReachableViaWWAN,
    /*! wifi */
    RZNetworkStatusReachableViaWiFi
};

typedef NS_ENUM(NSUInteger, RZHttpRequestType)
{
    /*! get请求 */
    RZHttpRequestTypeGet = 0,
    /*! post请求 */
    RZHttpRequestTypePost
};
/**
 *  请求成功的block
 *
 *  @param response 请求结果
 */
typedef void(^RZRequestSuccessBlock)(id response);

/**
 *  请求失败的block
 *
 *  @param error 请求结果
 */
typedef void(^RZRequestFailBlock)(NSError *error);

/**
 *  下载进度
 *
 *  @param bytesRead      已经下载的大小
 *  @param totalBytesRead 文件总大小
 */
typedef void(^RZDownloadProgress)(int64_t bytesRead,
                                  int64_t totalBytesRead);

/**
 *  上传进度
 *
 *  @param bytesWrite      已上传的大小
 *  @param totalBytesWrite 总上传的大小
 */
typedef void(^RZUploadProgress)(int64_t bytesWrite,
                                int64_t totalBytesWrite);

/*!
 *  方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel，取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume，继续任务
 */
typedef NSURLSessionTask RZURLSessionTask;


@interface RZNetManager : NSObject

/*! 获取当前网络状态 */
@property (nonatomic, assign) RZNetWorkStatus netWorkStatus;

/*!
 *  获得全局唯一的网络请求实例单例方法
 *
 *  @return 网络请求类BANetManager单例
 */
+ (instancetype)sharedNetManager;

/*!
 *  开启网络监测
 */
+ (void)rz_startNetWorkMonitor;

/** GET、POST */
+ (RZURLSessionTask *)rz_requestWithType:(RZHttpRequestType)type
                                    path:(NSString *)url
                              parameters:(NSDictionary *)parameterDic
                                 success:(RZRequestSuccessBlock)success
                                  failed:(RZRequestFailBlock)failed
                                progress:(RZDownloadProgress)progress;

/** 上传图片 */
+ (RZURLSessionTask *)rz_uploadImgWithURL:(NSString *)urlStr
                               parameters:(NSDictionary *)parameterDic
                                 ImgArray:(NSArray *)imgArray
                                  success:(RZRequestSuccessBlock)success
                                   failed:(RZRequestFailBlock)failed
                                 progress:(RZDownloadProgress)progress;

/** 上传视频 */
+ (void)rz_uploadVideoWithURL:(NSString *)urlStr
                               parameters:(NSDictionary *)parameterDic
                                 VideoPath:(NSString *)videoPath
                                  success:(RZRequestSuccessBlock)success
                                   failed:(RZRequestFailBlock)failed
                                 progress:(RZDownloadProgress)progress;

/** 下载文件 */
+ (RZURLSessionTask *)rz_downloadFileWithURL:(NSString *)urlStr
                                  parameters:(NSDictionary *)parameterDic
                                    SavePath:(NSString *)savePath
                                     success:(RZRequestSuccessBlock)success
                                      failed:(RZRequestFailBlock)failed
                                    progress:(RZDownloadProgress)progress;



/** 上传店面图片 */
+ (RZURLSessionTask *)rz_uploadImageArr:(NSArray<UIImage *> *)imageArr
                                  names:(NSArray<NSString *> *)namesArr
                               filename:(NSString *)filename
                                   path:(NSString *)urlPath
                                 params:(NSDictionary *)params
                                success:(RZRequestSuccessBlock)success
                                 failed:(RZRequestFailBlock)failed
                               progress:(RZDownloadProgress)progress;

@end

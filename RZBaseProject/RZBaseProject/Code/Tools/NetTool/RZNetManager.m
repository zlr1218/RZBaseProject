//
//  RZNetManager.m
//  RZNetWorking
//
//  Created by 赵林瑞 on 16/9/14.
//  Copyright © 2016年 ROL. All rights reserved.
//

#import "RZNetManager.h"

#import "AFNetworking.h"

/*! 系统相册 */
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>

#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetExportSession.h>
#import <AVFoundation/AVMediaFormat.h>


#import "UIImage+CompressImage.h"


#define kRZSystemVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
static NSMutableArray *tasks;

@implementation RZNetManager

+ (instancetype)sharedNetManager {
    static RZNetManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[self alloc] init];
        
    });
    return manager;
}

+ (AFHTTPSessionManager *)sharedAFManager
{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        
        /*! 设置请求超时时间 */
        manager.requestSerializer.timeoutInterval = 30;
        
        /*! 设置相应的缓存策略：此处选择不用加载也可以使用自动缓存【注：只有get方法才能用此缓存策略，NSURLRequestReturnCacheDataDontLoad】 */
        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        
        /*! 设置返回数据为json, 分别设置请求以及相应的序列化器 */
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        
        /*! 设置apikey ------类似于自己应用中的tokken---此处仅仅作为测试使用*/
        //        [manager.requestSerializer setValue:apikey forHTTPHeaderField:@"apikey"];
        
        /*! 复杂的参数类型 需要使用json传值-设置请求内容的类型*/
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        /*! 设置响应数据的基本了类型 */
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/xml",@"text/plain", @"application/javascript", nil];
        
        /*! https 参数配置 */
        /*!
         采用默认的defaultPolicy就可以了. AFN默认的securityPolicy就是它, 不必另写代码. AFSecurityPolicy类中会调用苹果security.framework的机制去自行验证本次请求服务端放回的证书是否是经过正规签名.
         */
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        manager.securityPolicy = securityPolicy;
        
        /*! 自定义的CA证书配置如下： */
        /*! 自定义security policy, 先前确保你的自定义CA证书已放入工程Bundle */
        /*!
         https://api.github.com网址的证书实际上是正规CADigiCert签发的, 这里把Charles的CA根证书导入系统并设为信任后, 把Charles设为该网址的SSL Proxy (相当于"中间人"), 这样通过代理访问服务器返回将是由Charles伪CA签发的证书.
         AFNetworking会自动扫描bundle中.cer的文件，并引入，这样就可以通过自签证书来验证服务器唯一性了。
         验证站点证书，是通过域名的，如果服务器端站点没有绑定域名（万恶的备案），仅靠IP地址上面的方法是绝对不行的。怎么办？答案是想通过设置是不可以的，你只能修改AFNetworking2的源代码！打开AFSecurityPolicy.m文件，找到方法：
         securityPolicy.validatesDomainName = NO;
         */
        //        NSSet <NSData *> *cerSet = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
        //        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
        //        policy.allowInvalidCertificates = YES;
        //        manager.securityPolicy = policy;
        
        /*! 如果服务端使用的是正规CA签发的证书, 那么以下几行就可去掉: */
        //        NSSet <NSData *> *cerSet = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
        //        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:cerSet];
        //        policy.allowInvalidCertificates = YES;
        //        manager.securityPolicy = policy;
        
        
    });
    
    return manager;
}

+ (NSMutableArray *)tasks
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //RZLog(@"创建数组");
        tasks = [[NSMutableArray alloc] init];
    });
    return tasks;
}

/**
 *  网络监控
 */
+ (void)rz_startNetWorkMonitor {
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                //RZLog(@"未知网络");
                [RZNetManager sharedNetManager].netWorkStatus = RZNetworkStatusUnknown;
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                //RZLog(@"没有网络");
                [RZNetManager sharedNetManager].netWorkStatus = RZNetworkStatusNotReachable;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //RZLog(@"手机自带网络");
                [RZNetManager sharedNetManager].netWorkStatus = RZNetworkStatusReachableViaWWAN;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //RZLog(@"WIFI");
                [RZNetManager sharedNetManager].netWorkStatus = RZNetworkStatusReachableViaWiFi;
                break;
                
            default:
                break;
        }
        
    }];
    
    [manager startMonitoring];
    
}


+ (RZURLSessionTask *)rz_requestWithType:(RZHttpRequestType)type
                                    path:(NSString *)url
                              parameters:(NSDictionary *)parameterDic
                                 success:(RZRequestSuccessBlock)success
                                  failed:(RZRequestFailBlock)failed
                                progress:(RZDownloadProgress)progress {
    
    if (url == nil) {
        return nil;
    }
    
    NSString *urlString = [NSURL URLWithString:url] ? url : [self strUTF8Encoding:url];
    
    //RZLog(@"请求参数\n请求头: %@\n请求方式: %@\n请求URL: %@\n请求param: %@\n\n",[self sharedAFManager].requestSerializer.HTTPRequestHeaders, (type == RZHttpRequestTypeGet) ? @"GET":@"POST",urlString, parameterDic);
    
    RZURLSessionTask *sessionTask = nil;
    
    if (type == RZHttpRequestTypeGet) {// GET
        
        sessionTask = [[self sharedAFManager] GET:urlString parameters:parameterDic progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            if (success) {
                success(responseObject);
            }
            
            [[self tasks] removeObject:sessionTask];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failed)
            {
                failed(error);
            }
            [[self tasks] removeObject:sessionTask];
            
        }];
    
    } else {                        // POST
        
        sessionTask = [[self sharedAFManager] POST:urlString parameters:parameterDic progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (success) {
                success(responseObject);
            }
            
            [[self tasks] removeObject:sessionTask];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failed)
            {
                failed(error);
            }
            [[self tasks] removeObject:sessionTask];
            
        }];
        
    }
    
    
    if (sessionTask)
    {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
    
}


+ (RZURLSessionTask *)rz_uploadImgWithURL:(NSString *)urlStr parameters:(NSDictionary *)parameterDic ImgArray:(NSArray *)imgArray success:(RZRequestSuccessBlock)success failed:(RZRequestFailBlock)failed progress:(RZDownloadProgress)progress {
    
    if (urlStr == nil) {
        return nil;
    }
    
    NSString *urlString = [NSURL URLWithString:urlStr] ? urlStr : [self strUTF8Encoding:urlStr];
    
    //RZLog(@"******************** 请求参数 ***************************\n 请求头: %@\n 请求方式: %@\n 请求URL: %@\n 请求param: %@\n\n",[self sharedAFManager].requestSerializer.HTTPRequestHeaders, @"POST",urlString, parameterDic);
    
    RZURLSessionTask *sessionTask = nil;
    
    sessionTask = [[self sharedAFManager] POST:urlString parameters:parameterDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        /*! 出于性能考虑,将上传图片进行压缩 */
        for (int i = 0; i < imgArray.count; i++)
        {
            /*! image的压缩方法 */
            UIImage *resizedImage;
            /*! 此处是使用原生系统相册 */
            if([imgArray[i] isKindOfClass:[ALAsset class]])
            {
                // 用ALAsset获取Asset URL  转化为image
                ALAssetRepresentation *assetRep = [imgArray[i] defaultRepresentation];
                
                CGImageRef imgRef = [assetRep fullResolutionImage];
                resizedImage = [UIImage imageWithCGImage:imgRef
                                                   scale:1.0
                                             orientation:(UIImageOrientation)assetRep.orientation];
                //                imageWithImage
                RZLog(@"1111-----size : %@",NSStringFromCGSize(resizedImage.size));
                
                resizedImage = [self imageWithImage:resizedImage scaledToSize:resizedImage.size];
                RZLog(@"2222-----size : %@",NSStringFromCGSize(resizedImage.size));
            }
            else
            {
                /*! 此处是使用其他第三方相册，可以自由定制压缩方法 */
                resizedImage = imgArray[i];
            }
            
            /*! 此处压缩方法是jpeg格式是原图大小的0.8倍，要调整大小的话，就在这里调整就行了还是原图等比压缩 */
            NSData *imgData = UIImageJPEGRepresentation(resizedImage, 0.8);
            
            NSString *imgFileName;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imgFileName = [NSString stringWithFormat:@"%@.png", str];
            
            /*! 拼接data */
            if (imgData != nil)
            {   // 图片数据不为空才传递
                [formData appendPartWithFileData:imgData name:@"file" fileName:imgFileName mimeType:@" image/jpeg"];
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //RZLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        
        if (progress)
        {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //RZLog(@"上传图片成功 = %@",responseObject);
        if (success)
        {
            success(responseObject);
        }
        
        [[self tasks] removeObject:sessionTask];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failed)
        {
            failed(error);
        }
        [[self tasks] removeObject:sessionTask];
        
    }];
    
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
    
}

+ (RZURLSessionTask *)rz_uploadImageArr:(NSArray<UIImage *> *)imageArr names:(NSArray<NSString *> *)namesArr filename:(NSString *)filename path:(NSString *)urlPath params:(NSDictionary *)params success:(RZRequestSuccessBlock)success failed:(RZRequestFailBlock)failed progress:(RZDownloadProgress)progress {
    
    RZURLSessionTask *sessionTask = nil;
    
    // 处理链接
    if (urlPath == nil || urlPath.length == 0 || ![urlPath isKindOfClass:[NSString class]]) {
        return sessionTask;
    }
    NSString *url = [NSURL URLWithString:urlPath] ? urlPath : [self strUTF8Encoding:urlPath];
    
    sessionTask = [[self sharedAFManager] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 上传
        for (int i = 0; i < imageArr.count; i++) {
            
            UIImage *image = [imageArr objectAtIndex:i];
            NSData *imgData = UIImageJPEGRepresentation(image, 0.8);
            
            NSString *name = [namesArr objectAtIndex:i];
            
            NSString *imageFileName;
            if (filename == nil || filename.length == 0 || ![filename isKindOfClass:[NSString class]]) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                imageFileName = [NSString stringWithFormat:@"%@.png", str];
            }else{
                imageFileName = filename;
            }
            
            [formData appendPartWithFileData:imgData name:name fileName:imageFileName mimeType:@" image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //RZLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //RZLog(@"上传图片成功 = %@",responseObject);
        if (success) {
            success(responseObject);
        }
        [[self tasks] removeObject:sessionTask];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
        [[self tasks] removeObject:sessionTask];
    }];
    
    if (sessionTask) {
        [[self tasks] addObject:sessionTask];
    }
    
    return sessionTask;
}

+ (void)rz_uploadVideoWithURL:(NSString *)urlStr parameters:(NSDictionary *)parameterDic VideoPath:(NSString *)videoPath success:(RZRequestSuccessBlock)success failed:(RZRequestFailBlock)failed progress:(RZDownloadProgress)progress {
    
    /*! 获得视频资源 */
    AVURLAsset *avAsset = [AVURLAsset assetWithURL:[NSURL URLWithString:videoPath]];
    
    /*! 压缩 */
    
    //    NSString *const AVAssetExportPreset640x480;
    //    NSString *const AVAssetExportPreset960x540;
    //    NSString *const AVAssetExportPreset1280x720;
    //    NSString *const AVAssetExportPreset1920x1080;
    //    NSString *const AVAssetExportPreset3840x2160;
    
    AVAssetExportSession  *  avAssetExport = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPreset640x480];
    
    /*! 创建日期格式化器 */
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    
    /*! 转化后直接写入Library---caches */
    
    NSString *  videoWritePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:[NSString stringWithFormat:@"/output-%@.mp4",[formatter stringFromDate:[NSDate date]]]];
    
    
    avAssetExport.outputURL = [NSURL URLWithString:videoWritePath];
    
    
    avAssetExport.outputFileType =  AVFileTypeMPEG4;
    
    [avAssetExport exportAsynchronouslyWithCompletionHandler:^{
        
        switch ([avAssetExport status]) {
            case AVAssetExportSessionStatusCompleted:
            {
                [[self sharedAFManager] POST:urlStr parameters:parameterDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    
                    //获得沙盒中的视频内容
                    
                    [formData appendPartWithFileURL:[NSURL fileURLWithPath:videoWritePath] name:@"write you want to writre" fileName:videoWritePath mimeType:@"video/mpeg4" error:nil];
                    
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                    RZLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
                    
                    if (progress)
                    {
                        progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
                    }
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
                    
                    RZLog(@"上传视频成功 = %@",responseObject);
                    if (success)
                    {
                        success(responseObject);
                    }
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    if (failed)
                    {
                        failed(error);
                    }
                }];
                
                break;
            }
            default:
                break;
        }
        
        
    }];
    
}

+ (RZURLSessionTask *)rz_downloadFileWithURL:(NSString *)urlStr parameters:(NSDictionary *)parameterDic SavePath:(NSString *)savePath success:(RZRequestSuccessBlock)success failed:(RZRequestFailBlock)failed progress:(RZDownloadProgress)progress {
    
    if (urlStr == nil) {
        return nil;
    }
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    RZLog(@"******************** 请求参数 ***************************\n 请求头: %@\n 请求方式: %@\n 请求URL: %@\n 请求param: %@\n\n",[self sharedAFManager].requestSerializer.HTTPRequestHeaders, @"download",urlStr, parameterDic);
    
    RZURLSessionTask *sessionTask = nil;
    
    sessionTask = [[self sharedAFManager] downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        
        RZLog(@"下载进度：%.2lld%%",100 * downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
        /*! 回到主线程刷新UI */
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (progress)
            {
                progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
            }
            
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        if (!savePath)
        {
            NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            RZLog(@"默认路径--%@",downloadURL);
            return [downloadURL URLByAppendingPathComponent:[response suggestedFilename]];
        }
        else
        {
            return [NSURL fileURLWithPath:savePath];
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [[self tasks] removeObject:sessionTask];
        
        RZLog(@"下载文件成功");
        if (error == nil)
        {
            if (success)
            {
                /*! 返回完整路径 */
                success([filePath path]);
            }
            else
            {
                if (failed)
                {
                    failed(error);
                }
            }
        }
    }];
    
    
    /*! 开始启动任务 */
    [sessionTask resume];
    
    if (sessionTask)
    {
        [[self tasks] addObject:sessionTask];
    }
    return sessionTask;
    
}

/*! 对图片尺寸进行压缩 */
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    if (newSize.height > 375/newSize.width*newSize.height)
    {
        newSize.height = 375/newSize.width*newSize.height;
    }
    
    if (newSize.width > 375)
    {
        newSize.width = 375;
    }
    
    UIImage *newImage = [UIImage needCenterImage:image size:newSize scale:1.0];
    
    return newImage;
}

+ (NSString *)strUTF8Encoding:(NSString *)str
{
    if (kRZSystemVersion >= 9.0) {
        return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    } else {
        return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}

@end

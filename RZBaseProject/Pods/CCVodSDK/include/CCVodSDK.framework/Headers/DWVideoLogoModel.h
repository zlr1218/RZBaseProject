//
//  DWVideoLogoModel.h
//  CCVodSDK
//
//  Created by 666666 on 2021/1/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//自定义视频LOGO
@interface DWVideoLogoModel : NSObject

/**
 *  @brief 资源地址URL，必填。支持网络URL，本地URL，支持jpg/jpeg/png/gif格式
 */
@property(nonatomic, strong)NSURL * url;

/**
 *  @brief 下载到本地Logo资源路径
 */
@property(nonatomic, strong, readonly)NSString * filePath;

/**
 *  @brief logo坐标百分比，选填，默认值左上角(0.1,0.1)
 */
@property(nonatomic, assign)CGPoint logoOrigin;

/**
 *  @brief logo大小，相对于DWPlayerView对象size的百分比，选填，默认(0.1,0.1)
 */
@property(nonatomic, assign)CGSize logoSize;

@end

NS_ASSUME_NONNULL_END

//
//  DWVideoDataAdapter.h
//  DW360Player4IOS
//
//  Created by ashqal on 16/4/9.
//  Copyright © 2016年 ashqal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DWVideoDataAdapter <NSObject>

/** 拷贝数据
 @return CVPixelBufferRef上下文
 */
- (CVPixelBufferRef)copyPixelBuffer;

@end

NS_ASSUME_NONNULL_END

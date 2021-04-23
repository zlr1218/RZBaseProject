//
//  RZCCManager.h
//  RZPlayer
//
//  Created by 技术平台开发部 on 2021/4/15.
//

#import <Foundation/Foundation.h>
#import <CCVodSDK/CCVodSDK.h>
#import "RZPlayBackDelegate.h"


NS_ASSUME_NONNULL_BEGIN

@interface RZCCManager : NSObject<RZPlayBackDelegate>

@property (nonatomic, strong, readonly) DWPlayerView *ccPlayer;

@property (nonatomic, copy) NSString *videoID;    /**< 视频ID */

@end

NS_ASSUME_NONNULL_END

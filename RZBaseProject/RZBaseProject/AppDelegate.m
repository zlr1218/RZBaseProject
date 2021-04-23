//
//  AppDelegate.m
//  RZBaseProject
//
//  Created by 赵林瑞 on 16/10/24.
//  Copyright © 2016年 RZOL. All rights reserved.
//

#import "AppDelegate.h"
#import "RZTabBarVC.h"
#import "SYSafeCategory.h"
//#import <CCVodSDK/CCVodSDK.h>

@interface AppDelegate ()//<BJVRequestTokenDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // CC播放器
    //设置全局AVAudioSession
//    NSError *categoryError = nil;
//    BOOL success = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&categoryError];
//    if (!success)
//    {
//        NSLog(@"Error setting audio session category: %@", categoryError);
//    }
//    NSError *activeError = nil;
//    success = [[AVAudioSession sharedInstance] setActive:YES error:&activeError];
//    if (!success)
//    {
//        NSLog(@"Error setting audio session active: %@", activeError);
//    }
    
    //百家云
//    [[BJVAppConfig sharedInstance] setPrivateDomainPrefix:BAIJIAYU_DOMAIN_NAME];
//    [BJVideoPlayerCore setTokenDelegate:self];
    
    [self setupRootViewController];
    
    [SYSafeCategory callSafeCategory];
    
    return YES;
}

/// 设置主控制器
- (void)setupRootViewController {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = RZ_White_Color;
    RZTabBarVC *tabVC = [[RZTabBarVC alloc] init];
    self.window.rootViewController = tabVC;
    [self.window makeKeyAndVisible];
}

/// 在这里写支持的旋转方向，为了防止横屏方向，应用启动时候界面变为横屏模式
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    // 可以这么写
    if (self.allowOrentitaionRotation) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
//    [self asyncConcurrent];
//    [self asyncSerial];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - 百家云 BJVRequestTokenDelegate

//- (void)requestTokenWithVideoID:(NSString *)videoID
//                     completion:(void (^)(NSString * _Nullable token, NSError * _Nullable error))completion {
//}
//- (void)requestTokenWithClassID:(NSString *)classID
//                      sessionID:(nullable NSString *)sessionID
//                     completion:(void (^)(NSString * _Nullable token, NSError * _Nullable error))completion {
//
//}


@end

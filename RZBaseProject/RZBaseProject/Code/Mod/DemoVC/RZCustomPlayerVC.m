//
//  RZCustomPlayerVC.m
//  RZBaseProject
//
//  Created by 技术平台开发部 on 2021/4/21.
//  Copyright © 2021 RZOL. All rights reserved.
//

#import "RZCustomPlayerVC.h"
#import "AppDelegate.h"
#import "RZPlayerController.h"

@interface RZCustomPlayerVC ()

@property (nonatomic, strong) RZPlayerController *player;

@end

@implementation RZCustomPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.allowOrentitaionRotation = YES;
    
    UIView *bGView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, kScreeWith, 260)];
    [self.view addSubview:bGView];
    bGView.backgroundColor = UIColor.orangeColor;
    
//    RZCCManager *manager = [[RZCCManager alloc] init];
//    manager.videoID = @"9AC7AF58161F084A9C33DC5901307461";
    
//    RZBJVideoManager *manager = [[RZBJVideoManager alloc] init];
//    [manager playForVideoID:@"69108458" videoToken:@"jjZHDGdzTd83Gu_x5aiohdTCNVgrU7VdAFfHras0uGKVrB-BbaD73Sou22apgAA0"];
//    manager.shouldAutoPlay = NO;
    
//    self.player = [RZPlayerController playerWithPlayerManager:manager containerView:bGView];
//    _player.title = @"中安云教育";
//    _player.placeImage = [UIImage imageNamed:@"shebaobg"];
}



@end

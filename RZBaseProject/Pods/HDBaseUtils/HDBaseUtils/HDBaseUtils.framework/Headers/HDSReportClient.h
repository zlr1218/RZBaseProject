//
//  HDSReportClient.h
//  CCFuncTool
//
//  Created by Chenfy on 2020/2/7.
//  Copyright © 2020 com.class.chenfy. All rights reserved.
//

#import <Foundation/Foundation.h>

//日志类别
typedef NS_ENUM(int, CCErrorLevel) {
    CCErrorLevel_VERBOSE = 2,
    CCErrorLevel_DEBUG = 3,
    CCErrorLevel_INFO = 4,
    CCErrorLevel_WARN = 5,
    CCErrorLevel_ERROR = 6,
    CCErrorLevel_ASSERT = 7,
};

NS_ASSUME_NONNULL_BEGIN

#pragma mark -- 云课堂使用
@interface HDSReportInfo : NSObject
@property(nonatomic,assign)NSTimeInterval responseTime;
@property(nonatomic,assign)CCErrorLevel   level;
@property(nonatomic,copy)NSString         *socketUrl;

//基本数据
@property(nonatomic,copy)NSString       *var_business;
@property(nonatomic,copy)NSString       *var_appVer;

@property(nonatomic,copy)NSString       *var_cdn;
@property(nonatomic,copy)NSString       *var_appid;
@property(nonatomic,copy)NSDictionary   *var_device;
@property(nonatomic,assign)int          var_serviceplatform;

@property(nonatomic,copy)NSString       *var_roomid;
@property(nonatomic,copy)NSString       *var_role;
@property(nonatomic,copy)NSString       *var_userid;
@property(nonatomic,copy)NSString       *var_username;
//事件数据
@property(nonatomic,copy)NSString       *event_event;
@property(nonatomic,assign)int          event_code;
@property(nonatomic,copy)NSString       *event_msg;
//data
@property(nonatomic,strong)NSDictionary   *event_data_requestmsg;
@property(nonatomic,strong)NSDictionary   *event_data_responsemsg;
@property(nonatomic,strong)NSDictionary   *event_data_stream;
@property(nonatomic,strong)NSDictionary   *event_data_pusher;
@property(nonatomic,strong)NSDictionary   *event_data_heartBeat;

@end

@interface HDSReportClient : NSObject
#pragma mark -- 新版API
/**
 * @param business 业务类型
 * @param sdkVer sdk版本号
 */
- (void)envInit:(NSString *)business version:(NSString *)sdkVer;

/**
 * 设置基础参数
 * @param baseInfo 基础信息
 */
- (void)setBaseInfo:(NSDictionary *)baseInfo;

/**
 * 日志上报
 * @param extraInfo 业务信息
 */
- (void)logReport:(NSDictionary *)extraInfo;


#pragma mark -- 旧版API
/** 云课堂旧版本使用 */
- (void)reportLogInfo:(HDSReportInfo *)info;

@end

NS_ASSUME_NONNULL_END

//
//  RZLocation.m
//  RZBaseProject
//
//  Created by os on 2019/2/27.
//  Copyright © 2019 RZOL. All rights reserved.
//

#import "RZLocation.h"
#import "UIView+RZAlert.h"

//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG

#define RZLocationLog(FORMAT, ...) do {                                      \
fprintf(stderr,"\n♨ Time:%s File:%s line:%d Func:%s ♨\n☞ %s ☜\n",         \
__TIME__,                                                                   \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__,                                                                   \
__func__,                                                                   \
[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);            \
} while (0)

#else
#define RZLocationLog(FORMAT, ...) nil
#endif


@interface RZLocation ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;    /**< 位置管理者 */

@property (nonatomic, strong) CLGeocoder *geocoder;    /**< （反）地理编码 */

@property (nonatomic, copy) RZLocationPlacemarkCallback successBlock;    /**< 成功回调 */
@property (nonatomic, copy) RZLocationFailCallback failedBlock;    /**< 失败回调 */

@end

@implementation RZLocation

+ (instancetype)shareInstance {
    static RZLocation *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        
        [manager initializeLocationManager];
    });
    return manager;
}
- (void)initializeLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    self.geocoder = [[CLGeocoder alloc] init];
    
    /*
     定位精确度
     kCLLocationAccuracyBestForNavigation    最适合导航
     kCLLocationAccuracyBest    精度最好的
     kCLLocationAccuracyNearestTenMeters    附近10米
     kCLLocationAccuracyHundredMeters    附近100米
     kCLLocationAccuracyKilometer    附近1000米
     kCLLocationAccuracyThreeKilometers    附近3000米
     */
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    
    /*
     每隔多少米更新一次位置，即定位更新频率
     */
    _locationManager.distanceFilter = 10.0f;
    
    //判断当前设备版本大于iOS8以后的话执行里面的方法
    if ([UIDevice currentDevice].systemVersion.floatValue >=8.0) {
        //持续授权
        //[_locationManager requestAlwaysAuthorization];
        //当用户使用的时候授权
        [_locationManager requestWhenInUseAuthorization];
    }
}



#pragma mark - 公共方法

- (void)startLocationSuccess:(RZLocationPlacemarkCallback)success Failed:(RZLocationFailCallback)failed {
    self.successBlock = success;
    self.failedBlock = failed;
    [self.locationManager startUpdatingLocation];
}

+ (BOOL)rz_locationEnabled {
    if ([CLLocationManager locationServicesEnabled]) {
        switch ([CLLocationManager authorizationStatus]) {
            case kCLAuthorizationStatusNotDetermined:
                RZLocationLog(@"用户尚未对该应用程序定位权限作出选择");
                break;
            case kCLAuthorizationStatusRestricted:
                RZLocationLog(@"应用程序的定位权限被限制");
                break;
            case kCLAuthorizationStatusAuthorizedAlways:
                RZLocationLog(@"用户已授权随时使用其位置");
                return YES;
                break;
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                RZLocationLog(@"用户允许定位");
                return YES;
                break;
            case kCLAuthorizationStatusDenied:
                RZLocationLog(@"用户拒绝获取定位");
                break;
                
            default:
                break;
        }
    }
    return NO;
}

+ (void)geocodeLocation:(NSString *)city block:(RZLocationPlacemarkCallback)block {
    CLGeocoder *geo = [RZLocation shareInstance].geocoder;
    [geo geocodeAddressString:city completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) return;
        if (block) {
            block(placemarks.lastObject);
        }
    }];
}

+ (void)reverseGeocodeLocation:(CLLocation *)location block:(RZLocationPlacemarkCallback)block {
    CLGeocoder *geo = [RZLocation shareInstance].geocoder;
    [geo reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) return;
        block(placemarks.lastObject);
    }];
}
+ (void)reverseGeocodeCoordinate:(CLLocationCoordinate2D)coordinate block:(RZLocationPlacemarkCallback)block {
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [RZLocation reverseGeocodeLocation:location block:block];
}

#pragma mark - LocationManagerDelegate

// 'startUpdatingLocation'方法开启后，当位置改变时会调用此方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //locations里就是更新出来的定位信息，一般取最后一个值
    [self.geocoder reverseGeocodeLocation:locations.lastObject completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error) {
            if (self.successBlock) {
                self.successBlock(placemarks.lastObject);
            }
            // 当定位成功就关闭定位
            [self.locationManager stopUpdatingLocation];
        }else{
            if (self.failedBlock) {
                self.failedBlock(error);
            }
        }
    }];
}

// 定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (self.failedBlock) {
        self.failedBlock(error);
    }
    switch (error.code) {
        case kCLErrorLocationUnknown:
            RZLocationLog(@"无法检索位置");
            break;
            
        case kCLErrorNetwork:
            RZLocationLog(@"网络问题");
            break;
            
        case kCLErrorDenied:
            RZLocationLog(@"定位权限的问题");
            [[self window] makeAlert:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)" Title:@"地点功能需要开启位置授权" sureTitle:@"去设置" sureBlock:^{
                NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if([[UIApplication sharedApplication] canOpenURL:url]) {
                    NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
            break;
            
        default:
            break;
    }
}

- (UIWindow *)window {
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    if (window && !window.isHidden) return window;
    
    window = [UIApplication sharedApplication].delegate.window;
    return window;
}

@end

//
//  RZLocation.h
//  RZBaseProject
//
//  Created by os on 2019/2/27.
//  Copyright © 2019 RZOL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^RZLocationPlacemarkCallback)(CLPlacemark *placemark);
typedef void(^RZLocationFailCallback)(NSError *error);

@interface RZLocation : NSObject

+ (instancetype)shareInstance;

/** 开始定位 */
- (void)startLocationSuccess:(RZLocationPlacemarkCallback)success Failed:(RZLocationFailCallback)failed;

/* 查看是否有定位权限 */
+ (BOOL)rz_locationEnabled;

/** 地理编码 */
+ (void)geocodeLocation:(NSString *)city block:(RZLocationPlacemarkCallback)block;

/* 反地理编码 */
+ (void)reverseGeocodeLocation:(CLLocation *)location block:(RZLocationPlacemarkCallback)block;
+ (void)reverseGeocodeCoordinate:(CLLocationCoordinate2D)coordinate block:(RZLocationPlacemarkCallback)block;

@end

//
//  RZColorHeader.h
//  RZRZseProject
//
//  Created by 赵林瑞 on 16/10/24.
//  Copyright © 2016年 RZOL. All rights reserved.
//

#ifndef RZColorHeader_h
#define RZColorHeader_h

#pragma mark - ***** 颜色设置

/*! RGB色值 */
#define RZ_COLOR(R, G, B, A)      [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

/*! 随机色 */
#define RZRandomColor RZ_COLOR(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255), 1.0)
#define RZHEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/*! navi蓝色 */
#define RZ_NaviBgBlueColor     RZ_COLOR(92, 177, 251, 1.0)
#define RZ_BGGrayColor         RZ_COLOR(239, 239, 239, 1.0)
#define RZ_TEXTGrayColor       RZ_COLOR(148, 147, 133, 1.0)
#define RZ_BLUEColor           RZ_COLOR(78, 164, 255, 1.0)
#define RZ_BGClearColor        [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.7f]

/*! 主题浅绿 */
#define RZ_Them_greenColor     RZ_COLOR(30, 198, 181, 1.0)

/*! 白色 */
#define RZ_White_Color         [UIColor whiteColor]

/*! 红色 */
#define RZ_Red_Color           [UIColor redColor]

/*! 黄色 */
#define RZ_Yellow_Color        [UIColor yellowColor]

/*! 绿色 */
#define RZ_Green_Color         [UIColor greenColor]

/*! 蓝色 */
#define RZ_Blue_Color          [UIColor blueColor]

/*! 无色 */
#define RZ_Clear_Color         [UIColor clearColor]

/*! 橙色 */
#define RZ_Orange_Color        [UIColor orangeColor]

/*! 黑色 */
#define RZ_Black_Color         [UIColor blackColor]

/*! 浅灰色色 */
#define RZ_LightGray_Color     [UIColor lightGrayColor]

#endif /* RZColorHeader_h */

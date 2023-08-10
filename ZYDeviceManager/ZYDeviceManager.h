//
//  ZYDeviceManager.h
//  findproperty
//
//  Created by objcat on 2021/10/14.
//  Copyright © 2021 Centaline. All rights reserved.
//  Version 0.1.0

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 参考 https://www.theiphonewiki.com/wiki/Models

@interface ZYDeviceManager : NSObject
/// 状态栏宽度
@property (class, nonatomic, readonly) CGFloat statusBarWidth;
/// 状态栏高度
@property (class, nonatomic, readonly) CGFloat statusBarHeight;
/// 2G 320x480 初代iPhone
@property (class, nonatomic, readonly) BOOL isIPhone_2G;
/// 3G、3GS 320x480
@property (class, nonatomic, readonly) BOOL isIPhone_3G_3GS;
/// 4、4S 320x480
@property (class, nonatomic, readonly) BOOL isIPhone_4_4s;
/// 5、5S、SE 320x568
@property (class, nonatomic, readonly) BOOL isIPhone_5_5s_se;
/// 6、6S、7、8 375x667
@property (class, nonatomic, readonly) BOOL isIPhone_6_6s_7_8;
/// 6P、6SP、7P、8P 414x736
@property (class, nonatomic, readonly) BOOL isIPhone_6p_6sp_7p_8p;
/// X、XS 375x812
@property (class, nonatomic, readonly) BOOL isIPhone_X_XS;
/// XR、XS_MAX、11_PRO_MAX 414x896
@property (class, nonatomic, readonly) BOOL isIPhone_XS_XSM_XR;
/// 12_MINI、13MINI 360x780
@property (class, nonatomic, readonly) BOOL isIPhone_12m_13m;
/// 12、12PRO、13、13PRO 390x844
@property (class, nonatomic, readonly) BOOL isIPhone_12_12p_13_13p;
/// 12_PRO_MAX、13_PRO_MAX 428x926
@property (class, nonatomic, readonly) BOOL isIPhone_12pm_13pm;
/// X以上机型
@property (class, nonatomic, readonly) BOOL isIPhone_x_up;
@end


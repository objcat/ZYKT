//
//  ZYDeviceManager.m
//  findproperty
//
//  Created by objcat on 2021/10/14.
//  Copyright © 2021 Centaline. All rights reserved.
//  

#import "ZYDeviceManager.h"
#import <sys/utsname.h>

@interface ZYDeviceManager ()

@end

@implementation ZYDeviceManager

+ (CGFloat)screen_width {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)screen_height {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)statusBarWidth {
    if (@available(iOS 13, *)) {
        return [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.width;
    } else {
        return UIApplication.sharedApplication.statusBarFrame.size.width;
    }
}

+ (CGFloat)statusBarHeight {
    if (@available(iOS 13, *)) {
        return [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;
    } else {
        return UIApplication.sharedApplication.statusBarFrame.size.width;
    }
}

+ (BOOL)isIPhone_2G {
    if ([self compareWithWidth:320 height:480]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isIPhone_3G_3GS {
    if ([self compareWithWidth:320 height:480]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isIPhone_4_4s {
    if ([self compareWithWidth:320 height:480]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isIPhone_5_5s_se {
    if ([self compareWithWidth:320 height:568]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isIPhone_6_6s_7_8 {
    if ([self compareWithWidth:375 height:667]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isIPhone_6p_6sp_7p_8p {
    if ([self compareWithWidth:414 height:736]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isIPhone_X_XS {
    if ([self compareWithWidth:375 height:812]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isIPhone_XS_XSM_XR {
    if ([self compareWithWidth:414 height:896]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isIPhone_12m_13m {
    if ([self compareWithWidth:360 height:780]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isIPhone_12_12p_13_13p {
    if ([self compareWithWidth:390 height:844]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isIPhone_12pm_13pm {
    if ([self compareWithWidth:428 height:926]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isIPhone_x_up {
    if (self.isIPhone_2G || self.isIPhone_3G_3GS || self.isIPhone_4_4s || self.isIPhone_5_5s_se || self.isIPhone_6_6s_7_8 || self.isIPhone_6p_6sp_7p_8p) {
        return NO;
    }
    return YES;
}

+ (BOOL)compareWithWidth:(CGFloat)width height:(CGFloat)height {
    // 横屏和竖屏只要有一个满足就几乎可以确定设备
    if ((width == self.screen_width && height == self.screen_height) ||
        (height == self.screen_width && width == self.screen_height)) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark -- 判断手机型号
+ (NSString*)judgeIphoneType {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString * phoneType = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    // simulator 模拟器
    
    if ([phoneType isEqualToString:@"i386"])   return @"Simulator";
    
    if ([phoneType isEqualToString:@"x86_64"])  return @"Simulator";
    
    //  常用机型  不需要的可自行删除
    
    if([phoneType  isEqualToString:@"iPhone1,1"])  return @"iPhone 2G";
    
    if([phoneType  isEqualToString:@"iPhone1,2"])  return @"iPhone 3G";
    
    if([phoneType  isEqualToString:@"iPhone2,1"])  return @"iPhone 3GS";
    
    if([phoneType  isEqualToString:@"iPhone3,1"])  return @"iPhone 4";
    
    if([phoneType  isEqualToString:@"iPhone3,2"])  return @"iPhone 4";
    
    if([phoneType  isEqualToString:@"iPhone3,3"])  return @"iPhone 4";
    
    if([phoneType  isEqualToString:@"iPhone4,1"])  return @"iPhone 4S";
    
    if([phoneType  isEqualToString:@"iPhone5,1"])  return @"iPhone 5";
    
    if([phoneType  isEqualToString:@"iPhone5,2"])  return @"iPhone 5";
    
    if([phoneType  isEqualToString:@"iPhone5,3"])  return @"iPhone 5c";
    
    if([phoneType  isEqualToString:@"iPhone5,4"])  return @"iPhone 5c";
    
    if([phoneType  isEqualToString:@"iPhone6,1"])  return @"iPhone 5s";
    
    if([phoneType  isEqualToString:@"iPhone6,2"])  return @"iPhone 5s";
    
    if([phoneType  isEqualToString:@"iPhone7,1"])  return @"iPhone 6 Plus";
    
    if([phoneType  isEqualToString:@"iPhone7,2"])  return @"iPhone 6";
    
    if([phoneType  isEqualToString:@"iPhone8,1"])  return @"iPhone 6s";
    
    if([phoneType  isEqualToString:@"iPhone8,2"])  return @"iPhone 6s Plus";
    
    if([phoneType  isEqualToString:@"iPhone8,4"])  return @"iPhone SE";
    
    if([phoneType  isEqualToString:@"iPhone9,1"])  return @"iPhone 7";
    
    if([phoneType  isEqualToString:@"iPhone9,2"])  return @"iPhone 7 Plus";
    
    if([phoneType  isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    
    if([phoneType  isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    
    if([phoneType  isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    
    if([phoneType  isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    
    if([phoneType  isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    
    if([phoneType  isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    
    if([phoneType  isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    
    if([phoneType  isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    
    if([phoneType  isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    
    if([phoneType  isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
 
    if([phoneType  isEqualToString:@"iPhone12,1"])  return @"iPhone 11";
    
    if ([phoneType isEqualToString:@"iPhone12,3"])  return @"iPhone 11 Pro";
    
    if ([phoneType isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";
    
    if ([phoneType isEqualToString:@"iPhone12,8"])   return @"iPhone SE2";

    if ([phoneType isEqualToString:@"iPhone13,1"])   return @"iPhone 12 mini";

    if ([phoneType isEqualToString:@"iPhone13,2"])   return @"iPhone 12";
    
    if ([phoneType isEqualToString:@"iPhone13,3"])   return @"iPhone 12  Pro";

    if ([phoneType isEqualToString:@"iPhone13,4"])   return @"iPhone 12  Pro Max";
    
    if ([phoneType isEqualToString:@"iPhone14,4"])   return @"iPhone 13 mini";
    
    if ([phoneType isEqualToString:@"iPhone14,5"])   return @"iPhone 13";
    
    if ([phoneType isEqualToString:@"iPhone14,2"])   return @"iPhone 13  Pro";
    
    if ([phoneType isEqualToString:@"iPhone14,3"])   return @"iPhone 13  Pro Max";
    
    return phoneType;
    
}


@end

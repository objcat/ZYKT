//
//  ZYUserDefaults.h
//  ZYKit
//
//  Created by 张祎 on 2020/5/7.
//  Update  by 张祎 on 2022/1/24 使用强类型进行优化处理 防止类型不同污染本地化存储
//  Version 2.0
//  https://github.com/objcat/ZYUserDefaults

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZYEnvironment) {
    /// 生产环境
    ZYEnvironmentProduction,
    /// 开发环境
    ZYEnvironmentDev
};

@interface ZYUserDefaults : NSObject

/// 环境
@property (assign, nonatomic) ZYEnvironment env;

/// 单例初始化
+ (instancetype)shareInstance;

/// 清空所有数据
- (void)clean;

@end

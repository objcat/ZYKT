//
//  ZYUserDefaults.h
//  ZYKit
//
//  Created by 张祎 on 2020/5/7.
//  Update  by 张祎 on 2022/1/24 使用强类型进行优化处理 防止类型不同污染本地化存储
//  Version 0.1.1

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


/**
 使用方法
 
 新建一个类继承于`ZYUserDefaults`写入以下内容, 假如叫`ExampleUserDefaults`
 
 #import "ZYUserDefaults.h"
 #import <UIKit/UIKit.h>

 #define x_store ExampleUserDefaults.shareInstance

 @interface ExampleUserDefaults : ZYUserDefaults
 @property (strong, nonatomic) NSString *testString;
 @property (strong, nonatomic) NSNumber *testNumber;
 @property (strong, nonatomic) NSArray *testArray;
 @property (strong, nonatomic) NSMutableArray *testMutableArray;
 @property (strong, nonatomic) NSDictionary *testDictionary;
 @property (strong, nonatomic) NSMutableDictionary *testMutableDictionary;
 @property (strong, nonatomic) NSData *testData;
 @property (strong, nonatomic) NSMutableData *testMutableData;
 @property (strong, nonatomic) NSDate *testDate;
 @property (assign, nonatomic) NSTimeInterval testTimeInterval;
 @property (assign, nonatomic) NSInteger testInteger;
 @property (assign, nonatomic) NSUInteger testUInteger;
 @property (assign, nonatomic) int testInt;
 @property (assign, nonatomic) long testLong;
 @property (assign, nonatomic) float testFloat;
 @property (assign, nonatomic) double testDouble;
 @property (assign, nonatomic) BOOL testBool;
 @property (assign, nonatomic) Boolean testBoolean;
 @property (assign, nonatomic) CGFloat testCGFloat;
 @end
 
 然后创建pch文件, 把头文件放进去
 
 使用如下:
 x_store.env = ZYEnvironmentDev;
 x_store.testString = @"123";
 x_store.testNumber = @(666);
 x_store.testArray = @[@"1", @"2", @"3"];
 x_store.testMutableArray = x_store.testArray.mutableCopy;
 x_store.testDictionary = @{@"name": @"张三", @"age": @"18"};
 x_store.testMutableDictionary = x_store.testDictionary.mutableCopy;
 x_store.testData = [[NSData alloc] init];
 x_store.testMutableData = [[NSMutableData alloc] init];
 x_store.testDate = NSDate.date;
 x_store.testTimeInterval = 1;
 x_store.testInteger = 1;
 x_store.testUInteger = 2;
 x_store.testInt = 1;
 x_store.testLong = 11;
 x_store.testFloat = 0.2;
 x_store.testDouble = 0.22;
 x_store.testCGFloat = 0.222;
 x_store.testBool = YES;
 x_store.testBoolean = true;
 NSLog(@"%@", x_store);
 */

//
//  ZYUserDefaults.h
//  ZYKit
//
//  Created by 张祎 on 2020/5/7.
//  Update  by 张祎 on 2022/1/24 使用强类型进行优化处理 防止类型不同污染本地化存储
//  Version 0.1.1

#import <Foundation/Foundation.h>

@interface ZYAbstractUserDefaults : NSObject

/// 单例初始化
+ (instancetype)shareInstance;

/// 清空所有数据
- (void)clean;

/// 打印变量
- (void)logPropertys;

@end


/**
 -> 实现原理:
 
 不要一惊一乍的, 其实这就是个Model+KVO+NSUserDefaults
 目前它的弱点是, 存放变量到NSUserDefaults有延迟, 如果存放后直接杀死进程就会出现存不住的问题, 所以请不要暴力搞, 有人会问如果是这样我存完直接使用可以吗, 答案是可以的, 因为存放变量有两份, 一份在Model上, 一份在NSUserDefaults中
 
 当存入变量的时候就会触发KVO, 这时候变量已经会先判断类型, 如果与定义的变量不一致就把NSUserDefaults置空, 一致就直接存
 
 -> 使用方法
 
 新建一个类继承于`ZYAbstractUserDefaults`写入以下内容, 假如叫`ExampleUserDefaults`
 
 #import "ZYAbstractUserDefaults.h"
 #import <UIKit/UIKit.h>

 #define x_store ExampleStore.shareInstance

 @interface ExampleStore : ZYAbstractUserDefaults
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

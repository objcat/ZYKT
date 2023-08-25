//
//  ExampleUserDefaults.h
//  ZYUserDefaults
//
//  Created by objcat on 2022/1/26.
//  Copyright © 2022 objcat. All rights reserved.
//

#import <ZYKT/ZYUserDefaults.h>
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

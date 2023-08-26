//
//  ZYEnvStore.h
//  ZYKTDemo
//
//  Created by objcat on 2023/8/26.
//

#import <ZYKT/ZYAbstractUserDefaults.h>

#define e_store ZYEnvStore.shareInstance

typedef NS_ENUM(NSUInteger, ZYEnvironment) {
    ZYEnvironmentProd,
    ZYEnvironmentDev
};

@interface ZYEnvStore : ZYAbstractUserDefaults
@property (assign, nonatomic) ZYEnvironment env;
@end

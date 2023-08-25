//
//  ZYNormalStore.h
//  ZYKTDemo
//
//  Created by objcat on 2023/8/25.
//

#import <ZYKT/ZYUserDefaults.h>

#define n_store ZYNormalStore.shareInstance

@interface ZYNormalStore : ZYUserDefaults
@property (strong, nonatomic) NSString *saveClass;
@end

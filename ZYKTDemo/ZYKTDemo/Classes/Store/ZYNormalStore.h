//
//  ZYNormalStore.h
//  ZYKTDemo
//
//  Created by objcat on 2023/8/25.
//

#import <ZYKT/ZYAbstractUserDefaults.h>

#define n_store ZYNormalStore.shareInstance

@interface ZYNormalStore : ZYAbstractUserDefaults
@property (strong, nonatomic) NSString *saveClass;
@end

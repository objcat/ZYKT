//
//  ZYUserDefaults.m
//  ZYKit
//
//  Created by 张祎 on 2020/5/7.
//  Copyright © 2020 objcat. All rights reserved.
//

#import "ZYAbstractUserDefaults.h"
#import "objc/runtime.h"

@interface ZYAbstractUserDefaults ()
@property (strong, nonatomic) NSUserDefaults *ud;
@property (strong, nonatomic) NSMutableArray *propertyList;
@property (strong, nonatomic) NSMutableDictionary *typeList;
@end

@implementation ZYAbstractUserDefaults

/**
 *  单例
 */
+ (instancetype)shareInstance {
    static NSMutableDictionary *storeDic = nil;
    if (storeDic == nil) { storeDic = [NSMutableDictionary dictionary]; }
    ZYAbstractUserDefaults *info = storeDic[NSStringFromClass(self.class)];
    if (info == nil) {
        info = [[[self class] alloc] init];
        storeDic[NSStringFromClass(self.class)] = info;
        // 设置ud路径
        NSString *ud_name = [NSString stringWithFormat:@"zy_ud_%@", NSStringFromClass([self class])];
        info.ud = [[NSUserDefaults alloc] initWithSuiteName:ud_name];
        // 绑定数据
        [info bindData];
        // 监听数据变化
        [info addObserver];
        NSLog(@"%@启动成功, 保存路径: \n %@/Preferences/%@.plist", NSStringFromClass([self class]), [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject], ud_name);
    }
    return info;
}

- (NSMutableDictionary *)typeList {
    if (!_typeList) {
        _typeList = [NSMutableDictionary dictionary];
    }
    return _typeList;
}

/// 绑定数据 目前仅用于初始化
- (void)bindData {
    for (NSString *propertyName in self.propertyList) {
        id value;
        // 存储普通变量
        value = [self.ud objectForKey:propertyName];
        // 安全赋值
        [self safeSetValueForKey:propertyName value:value];
    }
}

/// 设置监听
- (void)addObserver {
    for (NSString *property in self.propertyList) {
        [self addObserver:self forKeyPath:property options:NSKeyValueObservingOptionNew context:nil];
    }
}

// 忽略bindData的属性
- (NSArray *)ignore_properties {
    return @[@"propertyList", @"ud", @"typeList"];
}

/// KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    id value = [object valueForKey:keyPath];
    [self safeSetObjectWithStore:self.ud key:keyPath value:value];
}

/// 获取属性列表
- (NSArray *)propertyList {
    if (!_propertyList) {
        NSMutableArray *tempArray = [NSMutableArray array];
        NSArray *keys = [self zy_propertity_keys];
        for (NSString *key in keys) {
            if ([self.ignore_properties containsObject:key]) {
                continue;
            }
            [tempArray addObject:key];
        }
        _propertyList = tempArray.copy;
    }
    return _propertyList;
}

- (NSArray *)zy_propertity_keys {
    // key字典
    NSMutableArray *keyArray = [NSMutableArray array];
    // 类
    Class cls = self.class;
    // 遍历属性列表
    while (1) {
        // 获取属性列表
        unsigned int count;
        objc_property_t *propertyArray = class_copyPropertyList(cls, &count);
        for (unsigned int i = 0; i < count; i++) {
            objc_property_t property = propertyArray[i];
            NSString *key = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            NSString *type = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            self.typeList[key] = type ? : @"";
            [keyArray addObject:key];
        }
        // 释放属性列表
        free(propertyArray);
        // 找完子类找父类
        cls = class_getSuperclass(cls);
        // 父类找到NSObject为止跳出
        if ([cls isEqual:[NSObject class]]) {
            break;
        }
    }
    return keyArray.copy;
}

/// 打印模型
- (NSString *)description {
    NSString *result = [NSMutableString string];
    /// 打印值
    for (NSString *propertyName in self.propertyList) {
        NSString *propertyKeyValue = [NSString stringWithFormat:@"%@ %@", propertyName, [self valueForKey:propertyName]];
        result = [NSString stringWithFormat:@"%@ \n %@", result, propertyKeyValue];
    }
    return result;
}

- (void)clean {
    // 清理属性
    [self cleanPropertys];
    // 清理ud, 理论上来说上面的方法已经全部清空了, 但是NSNumber类型的仍然会存留在ud不清理也没什么关系 但这里还是选择了清理
    [self cleanUserDefaults];
}

- (void)cleanPropertys {
    for (NSString *propertyName in self.propertyList) {
        [self safeSetValueForKey:propertyName value:nil];
    }
}

- (void)cleanUserDefaults {
    NSDictionary *dic = [self.ud dictionaryRepresentation];
    for (id key in dic) {
        [self.ud removeObjectForKey:key];
    }
    [self.ud synchronize];
}

- (void)safeSetObjectWithStore:(NSUserDefaults *)store key:(id)key value:(id)value {
    Class cls = [self classFromKey:key];
    if ([value isKindOfClass:cls]) {
        // 如果类型正确设置正确的值
        [store setObject:value forKey:key];
    } else {
           
#ifdef DEBUG
        NSLog(@"key=%@ 的`值类型 (%@)`与`属性类型 (%@)`不符 被直接置空!", key, value, cls);
#endif
        // 如果类型错误直接设为空
        [store setObject:nil forKey:key];
    }
}

- (void)safeSetValueForKey:(NSString *)key value:(id)value {
    Class cls = [self classFromKey:key];
    if (value == nil) {
        // 如果值为空, 就把数值变为nil或0
        [self safeSetNilValueForKey:key];
    } else {
        if ([value isKindOfClass:cls]) {
            [self setValue:value forKey:key];
        } else {
            [self safeSetNilValueForKey:key];
        }
    }
}

- (void)safeSetNilValueForKey:(NSString *)key {
    Class cls = [self classFromKey:key];
    if ([cls isEqual:[NSNumber class]]) {
        [self setValue:@(0) forKey:key];
    } else {
        [self setValue:nil forKey:key];
    }
}

- (Class)classFromKey:(NSString *)key {
    NSString *type = self.typeList[key];
    if ([type hasPrefix:@"T@"]) {
        NSString *clsName = [self zy_firstMatchWithPartten:@"(?<=^T@\").*(?=\")" text:type];
        return NSClassFromString(clsName);
    } else if ([type hasPrefix:@"T"]) {
        return [NSNumber class];
    } else {
        NSAssert(NO, @"未知类型");
    }
    return nil;
}

- (NSString *)zy_firstMatchWithPartten:(NSString *)pattern text:(NSString *)text {
    NSTextCheckingResult *result = [[NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil] firstMatchInString:text options:0 range:NSMakeRange(0, text.length)];
    return [text substringWithRange:result.range];
}

- (void)dealloc {
    // 由于是单例 所以不用担心释放的问题 固不用移除
}

@end

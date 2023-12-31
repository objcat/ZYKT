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
/// 主要NSUserDefaults
@property (strong, nonatomic) NSUserDefaults *ud;
/// 属性列表
@property (strong, nonatomic) NSMutableArray *propertyList;
/// 类型列表
@property (strong, nonatomic) NSMutableDictionary <NSString *, Class> *typeDictionary;
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

- (NSMutableDictionary *)typeDictionary {
    if (!_typeDictionary) {
        _typeDictionary = [NSMutableDictionary dictionary];
    }
    return _typeDictionary;
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
    return @[@"propertyList", @"ud", @"typeDictionary"];
}

/// KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    // 给NSUserDefaults赋值, 因为没有涉及到自身变量, 所以不会递归
    [self safeSetObjectWithStore:self.ud key:keyPath value:[object valueForKey:keyPath]];
}

/// 获取属性列表
- (NSArray *)propertyList {
    if (!_propertyList) {
        NSMutableArray *tempArray = [NSMutableArray array];
        NSArray *keys = [self zy_propertity_keys];
        for (NSString *key in keys) {
            // 在属性列表里排除三个
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
            if (![self.ignore_properties containsObject:key]) {
                self.typeDictionary[key] = [self classFromType:type];
            }
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

/// 安全设置值给Store
/// - Parameters:
///   - store: NSUserDefaults
///   - key: 键
///   - value: 值
- (void)safeSetObjectWithStore:(NSUserDefaults *)store key:(id)key value:(id)value {
    // 获取class
    Class cls = [self classFromKey:key];
    // 判断值和类的类型是否一致
    if ([value isKindOfClass:cls]) {
        // 如果类型一致就直接赋值
        [store setObject:value forKey:key];
    } else {
        
#ifdef DEBUG
        NSLog(@"key=%@ 的`值类型 (%@)`与`属性类型 (%@)`不符合 被直接置空!", key, value, cls);
#endif
        // 如果类型不一致就设为空
        [store setObject:nil forKey:key];
    }
}

/// 安全设置值给成员变量(切勿用在KVO否则会递归)
/// - Parameters:
///   - key: 键
///   - value: 值
- (void)safeSetValueForKey:(NSString *)key value:(id)value {
    // 获取类型
    Class cls = [self classFromKey:key];
    if (value == nil) {
        // 如果值为空, 就把数值变为nil或0
        [self safeSetNilValueForKey:key cls:cls];
    } else {
        if ([value isKindOfClass:cls]) {
            [self setValue:value forKey:key];
        } else {
            // 如果类型不同, 也把数值变为nil或0
            [self safeSetNilValueForKey:key cls:cls];
        }
    }
}

/// 安全设置空值
/// - Parameter key: 键
- (void)safeSetNilValueForKey:(NSString *)key cls:(Class)cls{
    // 判断变量原类型
    if ([cls isEqual:[NSNumber class]]) {
        // 如果是NSNumber就设置为@(0)
        [self setValue:@(0) forKey:key];
    } else {
        // 如果是对象类型的就置为nil
        [self setValue:nil forKey:key];
    }
}

/// 判断类型
/// - Parameter key: 根据键从typeList取出类型并转换成Class
- (Class)classFromKey:(NSString *)key {
    return self.typeDictionary[key];
}

/// 判断类型
/// - Parameter key: 根据键从typeList取出类型并转换成Class
- (Class)classFromType:(NSString *)type {
    if ([type hasPrefix:@"T@"]) {
        NSString *clsName = [self zy_firstMatchWithPartten:@"(?<=^T@\").*(?=\")" text:type];
        return NSClassFromString(clsName);
    } else if ([type hasPrefix:@"T"]) {
        return [NSNumber class];
    } else {
        return nil;
    }
}

- (NSString *)zy_firstMatchWithPartten:(NSString *)pattern text:(NSString *)text {
    NSTextCheckingResult *result = [[NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil] firstMatchInString:text options:0 range:NSMakeRange(0, text.length)];
    return [text substringWithRange:result.range];
}

- (void)dealloc {
    // 由于是单例 所以不用担心释放的问题 固不用移除
}

- (void)logPropertys {
    NSArray *propertyList = self.propertyList;
    NSDictionary *typeDictionary = self.typeDictionary;
    NSLog(@"%@", propertyList);
    NSLog(@"%@", typeDictionary);
}

@end

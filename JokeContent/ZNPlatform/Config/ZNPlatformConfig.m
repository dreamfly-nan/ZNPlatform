//
//  ZNPlatformConfig.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/25.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNPlatformConfig.h"

@implementation ZNPlatformConfig

+ (instancetype)sharedSingleton {
    static ZNPlatformConfig *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //不能再使用alloc方法
        //因为已经重写了allocWithZone方法，所以这里要调用父类的分配空间的方法
        _sharedSingleton = [[super allocWithZone:NULL] init];
    });
    return _sharedSingleton;
}

// 防止外部调用alloc 或者 new
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [[self class] sharedSingleton];
}

// 防止外部调用copy
- (id)copyWithZone:(nullable NSZone *)zone {
    return [[self class] sharedSingleton];
}

// 防止外部调用mutableCopy
- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [[self class] sharedSingleton];
}

@end

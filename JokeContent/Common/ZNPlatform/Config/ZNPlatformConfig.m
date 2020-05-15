//
//  ZNPlatformConfig.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/25.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNPlatformConfig.h"

@interface ZNPlatformConfig()

/// 是否有网络
@property (nonatomic , assign) BOOL haveNet;

@end

@implementation ZNPlatformConfig

+ (instancetype)sharedSingleton {
    static ZNPlatformConfig *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //不能再使用alloc方法
        //因为已经重写了allocWithZone方法，所以这里要调用父类的分配空间的方法
        _sharedSingleton = [[super allocWithZone:NULL] init];
        [_sharedSingleton netState];
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

- (void)netState{
    self.haveNet = YES;
    znWeakSelf(self)
    [ZNNetManager networkReachabilityStart:^(AFNetworkReachabilityStatus status) {
        znStrongSelf
        // 在每次网络状态发生改变的时候会执行一次
        // 这里可以重复一两次进行关闭和打开移动、Wi-Fi就知道了
            if (status == AFNetworkReachabilityStatusReachableViaWWAN || status == AFNetworkReachabilityStatusReachableViaWiFi) {
                // 也就是每次恢复有网络的状态下都会执行一遍
                // 当然如果觉得这样不太好也可以自己做一些条件限制
                if (!weakSelf.haveNet) {
                    weakSelf.haveNet = YES;
                    [[NSNotificationCenter defaultCenter] postNotificationName:netRefreshData object:nil];
                }
            }else if(status == AFNetworkReachabilityStatusNotReachable || status == AFNetworkReachabilityStatusUnknown){
                if (weakSelf.haveNet) {
                    weakSelf.haveNet = NO;
                    [[NSNotificationCenter defaultCenter] postNotificationName:netErrorNotification object:nil];
                }
            }else{
                
            }
    }];
}

#pragma mark - get

- (UIColor *)dateColor{
    if (!_dateColor) {
        return zn_colorString(@"#BFBFBF");
    }
    return _dateColor;
}

- (UIColor *)mainColor{
    if (!_mainColor) {
        return zn_colorString(@"#56B5D5");
    }
    return _mainColor;
}

- (UIColor *)backgroundColor{
    if (!_backgroundColor) {
        return zn_colorString(@"#F97856");
    }
    return _backgroundColor;
}

- (UIColor *)titleColor{
    if (!_titleColor) {
        return zn_colorString(@"#545556");
    }
    return _titleColor;
}

- (UIColor *)contentColor{
    if (!_contentColor) {
        return zn_colorString(@"#636161");
    }
    return _contentColor;
}

- (UIColor *)lineColor{
    if (!_lineColor) {
        return zn_colorString(@"#cdcdcd");
    }
    return _lineColor;
}

- (UIColor *)introductionColor{
    if (!_introductionColor) {
        return zn_colorString(@"#ABACAD");
    }
    return _introductionColor;
}

@end

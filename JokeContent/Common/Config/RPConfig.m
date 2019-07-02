//
//  RPConfig.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/23.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPConfig.h"

#define UserDataKey @"UserDataKey"
//是否第一次打开
#define fristOpen @"fristOpen"

static RPConfig *rpConfig;

@interface RPConfig()

@end

@implementation RPConfig

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (rpConfig == nil) {
            rpConfig = [super allocWithZone:zone];
        }
    });
    return rpConfig;
}

+ (instancetype)sharedInstance{
    return [[self alloc] init];
}

//保存用户信息
+ (void)saveUserData:(UserData*)userData{
    [RPConfig sharedInstance].userData = userData;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userData requiringSecureCoding:NO error:nil];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userData];
    NSUserDefaults *userdafault = [NSUserDefaults standardUserDefaults];
    [userdafault setObject:data forKey:UserDataKey];
    [userdafault synchronize];
}

//清除用户信息
+ (void)clearUserData{
    NSUserDefaults *userdafault = [NSUserDefaults standardUserDefaults];
    [userdafault removeObjectForKey:UserDataKey];
}

//获取用户信息
+ (UserData*)obtainUserData{
    return [RPConfig sharedInstance].userData;
}

/**
 更新用户选中的新闻类别
 */
+ (void)upDataChooseKinds{
    NSMutableArray * array = [NSMutableArray array];
    NSArray * kindIds = [[RPConfig sharedInstance].userData obtainKindsId];
    for (NSString * channId in kindIds) {
        [array addObject:[RPConfig sharedInstance].kindsIdsDic[channId]];
    }
    [RPConfig sharedInstance].chooseKinds = [array copy];;
}

- (void)setKinds:(NSArray<NewsKindsModel *> *)kinds{
    _kinds = kinds;
    NSMutableDictionary * dic = [NSMutableDictionary new];
    for (NewsKindsModel * model in kinds) {
        [dic setObject:model forKey:model.channelId];
    }
    self.kindsIdsDic = [dic copy];
}

/**
 是否是第一次打开
 
 @return <#return value description#>
 */
+ (BOOL)isFristOpen{
    NSUserDefaults *userdafault = [NSUserDefaults standardUserDefaults];
    id frist = [userdafault objectForKey:fristOpen];
    if (frist) {
        return NO;
    }else{
        return YES;
    }
}

/**
 设置第一次打开
 */
+ (void)setFristOpen{
    NSUserDefaults *userdafault = [NSUserDefaults standardUserDefaults];
    [userdafault setObject:@(NO) forKey:fristOpen];
    [userdafault synchronize];
}

#pragma mark -----------get-----------

- (UserData *)userData{
    if (!_userData) {
        NSUserDefaults *userdafault = [NSUserDefaults standardUserDefaults];
        NSData *data = [userdafault objectForKey:UserDataKey];
        _userData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
   return _userData;
}

@end

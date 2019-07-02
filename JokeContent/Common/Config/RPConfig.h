//
//  RPConfig.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/23.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "USerData.h"
#import "NewsKindsModel.h"
#import "ImageModel.h"

@interface RPConfig : NSObject

/**
 新闻类别，频道
 */
@property (nonatomic , strong) NSArray<NewsKindsModel*> * kinds;

/**
 选中的类别
 */
@property (nonatomic , strong) NSArray<NewsKindsModel*> * chooseKinds;

@property (nonatomic , strong) UserData * userData;

/**
 所有的类别id作为key,类别对象进行存储
 */
@property (nonatomic , strong) NSDictionary * kindsIdsDic;

//导航栏高度
@property (nonatomic , assign) CGFloat navigationHeight;

//tabBar的高度
@property (nonatomic , assign) CGFloat tabBarHeight;

+ (instancetype)sharedInstance;

//保存用户信息
+ (void)saveUserData:(UserData*)userData;

//获取用户信息
+ (UserData*)obtainUserData;

//清除用户信息
+ (void)clearUserData;

/**
 更新用户选中的新闻类别
 */
+ (void)upDataChooseKinds;

/**
 是否是第一次打开

 @return <#return value description#>
 */
+ (BOOL)isFristOpen;

/**
 设置第一次打开
 */
+ (void)setFristOpen;

@end

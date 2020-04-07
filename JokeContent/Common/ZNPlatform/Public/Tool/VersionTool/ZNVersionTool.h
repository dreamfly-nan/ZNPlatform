//
//  ZNVersionTool.h
//  JokeContent
//  根据互联网上的APP版本号进行判断，以美国那边的互联网信息为主，一般时间差为1~7小时内
//  Created by 郑楠楠 on 2019/6/23.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZNVersionTool : NSObject

/**
 block回调
 
 @param currentVersion 当前版本号
 @param storeVersion 商店版本号
 @param openUrl 跳转到商店的地址
 @param description 更新描述
 @param isUpdate 是否为最新版本
 */
typedef void(^UpdateBlock)(NSString *currentVersion,NSString *storeVersion, NSString *openUrl,NSString * description,BOOL isUpdate);

/**
 失败回调

 @param error 错误消息
 @param currentVersion 当前版本号
 */
typedef void(^updateFailBlock)(NSError * error,NSString * currentVersion);

/**
 一行代码实现检测app是否为最新版本。appId，bundelId，随便传一个 或者都传nil 即可实现检测。
 
 @param appId    项目APPID，10位数字，有值默认为APPID检测，可传nil
 @param bundelId 项目bundelId，有值默认为bundelId检测，可传nil
 @param block    检测结果block回调
 @param fail     失败回调
 */
+(void)zn_updateWithAPPID:(NSString *)appId withBundleId:(NSString *)bundelId block:(UpdateBlock)block fail:(updateFailBlock) fail;

@end

NS_ASSUME_NONNULL_END

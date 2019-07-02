//
//  USerData.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/15.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "NewsKindsModel.h"

@interface UserData : BmobObject

@property (nonatomic , copy) NSString *id;

@property (nonatomic , copy) NSString *username;

@property (nonatomic , copy) NSString *password;

//阅读后产生的金币
@property (copy , nonatomic) NSString * gold_coin;

//昵称
@property (nonatomic , copy) NSString  * nickName;

//微信
@property (nonatomic , copy) NSString *weChat;

//qq
@property (nonatomic , copy) NSString *qq;

//邮箱
@property (nonatomic , copy) NSString *email;

//头像
@property (nonatomic , copy) NSString *iconUrl;

//简介
@property (nonatomic , copy) NSString *introduction;

//电话号码
@property (nonatomic , copy) NSString *mobilePhoneNum;

//用户关注的类别，中间用‘，’（逗号）隔开
@property (nonatomic , copy) NSString  * kindsIds;

/**
 设置用户关注的类别 , 如果为空字符串，则默认用户选中所有类别数据

 @param kinds <#kinds description#>
 */
- (void)setKinds:(NSArray<NewsKindsModel*>*) kinds;

/**
 获取新闻类别的id
 @return <#return value description#>
 */
- (NSArray<NSString*>*)obtainKindsId;

@end

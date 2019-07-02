//
//  DefineHeaderFile.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/3.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#ifndef DefineHeaderFile_h
#define DefineHeaderFile_h

//弱引用
#define znWeakSelf(x) __weak typeof(x) weakObject = (x);
#define znStrongSelf __strong typeof(weakObject) weakSelf = weakObject;

//代码块
#define znnBlockSelf(x) __block typeof(x) blockSelf = (x);

//状态栏高度大小
#define znStateSize [UIApplication sharedApplication].statusBarFrame.size
#define znStateHeight znStateSize.height

//屏幕高度大小
#define screenBounds [UIScreen mainScreen].bounds
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth [UIScreen mainScreen].bounds.size.width

#define znString(x) [NSString stringWithFormat:@"%@",x]

//一次阅读产生的金币数量
#define glodNumerWithOne 10

//评论的占位符
#define commentPlaceText @"来说两句"

//用来做字符分割的  字符
#define sepString @","

//首页的新闻类别改变
#define homeKindsChange @"homeKindsChange"

//资讯列表页面的默认图
#define InformationPlaceHoldImage @"no_data"

//用户默认头像
#define UserIconPlaceHoldImage @"UserIconPlaceHoldImage"

//bmob的应用key
#define bmobKey @"9490c4cce3e81ff81dd0ed51f81ef387"

//万维易源的应用id
#define wwyyAppId @"91944"
//万维易源的应用密钥
#define wwyyAppKey @"efee5bcd18934179bcc1fb65713564d8"

#endif /* DefineHeaderFile_h */

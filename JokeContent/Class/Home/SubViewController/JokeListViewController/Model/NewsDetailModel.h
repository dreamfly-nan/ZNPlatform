//
//  NewsDetailModel.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/18.
//  Copyright © 2019 社会人. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsImageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsDetailModel : NSObject

/**
 新闻地址
 */
@property (nonatomic , copy) NSString  * link;

@property (nonatomic , copy) NSString  * id;

//网页源码
@property (nonatomic , copy) NSString  * html;

/**
简介图片，有时可能没有图片
 */
@property (nonatomic , strong) NSArray<NewsImageModel*>  * imageurls;

/**
 是否封面图，与 imageurls字段是否有数据有关
 */
@property (nonatomic , assign) BOOL  havePic;

/**
 封面图
 */
@property (nonatomic , copy) NSString  * img;

/**
 新闻时间
 */
@property (nonatomic , copy) NSString  * pubDate;

/**
 新闻标题
 */
@property (nonatomic , copy) NSString  * title;

/**
 数据来源 -  新浪，或者其他网站
 */
@property (nonatomic , copy) NSString  * source;

/**
 所属类型名
 */
@property (nonatomic , copy) NSString  * channelName;

/**
 所属类型的id
 */
@property (nonatomic , copy) NSString  * channelId;


/**
 一张图，两张图，三张图
 */
@property (nonatomic , assign) int type;

@end

NS_ASSUME_NONNULL_END

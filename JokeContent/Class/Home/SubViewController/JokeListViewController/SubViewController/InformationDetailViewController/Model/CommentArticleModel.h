//
//  CommentArticleModel.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/28.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaseObject.h"

@interface CommentArticleModel : BmobObject

/**
 评论内容
 */
@property (nonatomic , copy) NSString *commentText;

/**
 评论的文章id
 */
@property (nonatomic , copy) NSString *articleID;

//文章链接
@property (nonatomic , copy) NSString  * link;

//来源
@property (copy , nonatomic) NSString * source;

//新闻时间
@property (copy , nonatomic) NSString * pubDate;

//文字标题
@property (copy , nonatomic) NSString * title;

//新闻封面
@property (copy , nonatomic) NSString * imageUrl;

/**
 该评论的消息数
 */
@property (nonatomic , copy) NSString *messageNum;

/**
 该评论的点赞数
 */
@property (nonatomic , copy) NSString *thumUp;

/**
 该评论的创建时间
 */
@property (nonatomic , copy) NSString *createTime;

/**
 该评论的发表者
 */
@property (nonatomic , copy) NSString *fromUserID;

@property (nonatomic , copy) NSString *fromUserName;

@property (nonatomic , copy) NSString *fromUserIcon;

@end

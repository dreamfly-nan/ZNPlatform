//
//  RPInformationDataModel.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaseObject.h"
#import "NewsDetailModel.h"
#import "CommentModel.h"
#import "ArticleThumUpModel.h"

@interface RPInformationDetailDataModel : RPBaseObject

@property (nonatomic , strong) NewsDetailModel *information;

@property(nonatomic,strong) ArticleThumUpModel * thumModel;

//文章id
@property (nonatomic , copy) NSString *articleId;

@property (nonatomic , assign) int page;

@property (nonatomic , assign) int pageSize;

//是否还有数据
@property (nonatomic , assign) BOOL isNoMoreData;

/**
 文章评论的数据
 */
@property (nonatomic , strong) NSMutableArray <CommentArticleModel*> * ariticleComments;

//评论文章
@property (nonatomic , strong) RACCommand *commentCommand;

//获取评论数据
@property (nonatomic , strong) RACCommand *getCommentCommands;

/**
 留言点赞
 */
@property (nonatomic , strong) RACCommand * thumUpCommentCommand;

/**
 留言的评论数
 */
@property (nonatomic , strong) RACCommand * msgCommentCommand;

@end

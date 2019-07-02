//
//  RPCommentTableViewCell.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/12.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaseTableViewCell.h"
#import "CommentModel.h"

@protocol RPCommentTableViewCellDelegate <NSObject>

/**
 点赞操作

 @param model <#model description#>
 */
- (void)thumUpBtnAction:(CommentArticleModel*)model;

/**
 评论操作
 @param model <#model description#>
 */
- (void)messageBtnAction:(CommentArticleModel*)model;

@end

@interface RPCommentTableViewCell : RPBaseTableViewCell

@property (nonatomic , strong) CommentArticleModel * model;

@property (nonatomic , weak) id<RPCommentTableViewCellDelegate> znDelegate;

@end

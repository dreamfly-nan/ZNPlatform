//
//  CommentUserViewController.h
//  JokeContent
//
//  Created by 南木南木 on 2019/5/16.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "RPBaseViewController.h"
#import "CommentArticleModel.h"
#import "RPDetailCommentView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentUserViewController : RPBaseViewController
<UITableViewDataSource,RPDetailCommentViewDelegate>

@property(nonatomic,strong) CommentArticleModel *model;

@end

NS_ASSUME_NONNULL_END

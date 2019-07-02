//
//  CommentUserDataModel.h
//  JokeContent
//
//  Created by 南木南木 on 2019/5/16.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentUserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentUserDataModel : NSObject

@property(nonatomic,strong) NSMutableArray<CommentUserModel*> *models;

/**
 获取评论
 */
@property(nonatomic,strong) RACCommand * getCommentCommand;

/**
 提交评论
 */
@property(nonatomic,strong) RACCommand * commitCommand;

@end

NS_ASSUME_NONNULL_END

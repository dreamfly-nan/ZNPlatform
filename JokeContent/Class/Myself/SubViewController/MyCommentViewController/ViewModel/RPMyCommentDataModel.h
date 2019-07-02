//
//  RPMyCommentDataModel.h
//  JokeContent
//
//  Created by 社会人 on 2019/5/14.
//  Copyright © 2019 社会人. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentArticleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RPMyCommentDataModel : NSObject

@property(nonatomic,strong) NSMutableArray<CommentArticleModel*> *models;

/**
 获取评论
 */
@property(nonatomic,strong) RACCommand * getCommentCommand;

@end

NS_ASSUME_NONNULL_END

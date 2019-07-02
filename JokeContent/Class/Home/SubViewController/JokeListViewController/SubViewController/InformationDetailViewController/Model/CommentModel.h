//
//  CommentModel.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/24.
//  Copyright © 2019 社会人. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentUserModel.h"
#import "CommentArticleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentModel : NSObject

@property (nonatomic , strong) CommentArticleModel * articleComment;

@property (nonatomic , strong) NSMutableArray<CommentUserModel*> * userComments;

@end

NS_ASSUME_NONNULL_END

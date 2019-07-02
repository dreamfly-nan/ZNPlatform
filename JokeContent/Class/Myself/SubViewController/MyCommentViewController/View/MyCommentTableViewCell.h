//
//  MyCommentTableViewCell.h
//  JokeContent
//
//  Created by 社会人 on 2019/5/16.
//  Copyright © 2019 社会人. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentArticleModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyCommentTableViewCell : RPBaseTableViewCell

@property(nonatomic,strong) CommentArticleModel * model;

@end

NS_ASSUME_NONNULL_END

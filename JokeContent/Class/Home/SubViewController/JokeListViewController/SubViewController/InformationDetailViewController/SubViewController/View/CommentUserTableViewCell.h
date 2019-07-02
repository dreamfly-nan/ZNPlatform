//
//  CommentUserTableViewCell.h
//  JokeContent
//
//  Created by 南木南木 on 2019/6/3.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "RPBaseTableViewCell.h"
#import "CommentUserModel.h"
@protocol CommentUserTableViewCell <NSObject>

- (void)thumUp:(CommentUserModel*) model;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CommentUserTableViewCell : RPBaseTableViewCell

//底线
@property(nonatomic,strong) UIView * lineView;

@property(nonatomic,strong) CommentUserModel * model;

@property(nonatomic,weak) id<CommentUserTableViewCell> znDelegate;

@end

NS_ASSUME_NONNULL_END

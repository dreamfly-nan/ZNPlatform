//
//  CommentUserViewModel.h
//  JokeContent
//
//  Created by 南木南木 on 2019/6/3.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentUserHeadView.h"
#import "CommentUserViewController.h"
#import "CommentUserTableViewCell.h"
#import "RPDetailCommentView.h"
#import "CXInputView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentUserViewModel : NSObject

@property(nonatomic,weak) CommentUserViewController * controller;

@property(nonatomic,strong) CommentUserHeadView * headView;

@property(nonatomic,strong) RPDetailCommentView * commentView;

/**
 输入评论的视图
 */
@property(nonatomic,strong) CXInputView *inputCommentView;

@property(nonatomic,strong) UITableView * tableView;

- (void)setUpInitUI;

@end

NS_ASSUME_NONNULL_END

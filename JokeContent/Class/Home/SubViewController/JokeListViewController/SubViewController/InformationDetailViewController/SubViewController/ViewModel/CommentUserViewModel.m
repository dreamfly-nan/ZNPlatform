//
//  CommentUserViewModel.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/3.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "CommentUserViewModel.h"

@implementation CommentUserViewModel

- (void)setUpInitUI{
    [self.controller.view addSubview:self.tableView];
    [self.controller.view addSubview:self.commentView];
    
    self.commentView.sd_layout
    .leftEqualToView(self.controller.view)
    .rightEqualToView(self.controller.view)
    .bottomEqualToView(self.controller.view)
    .autoHeightRatio(0);
}

#pragma mark - get

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.controller.view.bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self.controller;
        _tableView.dataSource = self.controller;
        [_tableView registerClass:[CommentUserTableViewCell class] forCellReuseIdentifier:[CommentUserTableViewCell idString]];
        _tableView.tableHeaderView = self.headView;
    }
    return _tableView;
}

- (RPDetailCommentView *)commentView{
    if (!_commentView) {
        _commentView = [RPDetailCommentView new];
        _commentView.znDelegate = self.controller;
        _commentView.backgroundColor = [UIColor whiteColor];
    }
    return _commentView;
}

- (CommentUserHeadView *)headView{
    if (!_headView) {
        _headView = [[CommentUserHeadView alloc] init];
    }
    return _headView;
}

- (CXInputView *)inputCommentView{
    if (!_inputCommentView) {
        _inputCommentView = [CXInputView inputView];
    }
    return _inputCommentView;
}

@end

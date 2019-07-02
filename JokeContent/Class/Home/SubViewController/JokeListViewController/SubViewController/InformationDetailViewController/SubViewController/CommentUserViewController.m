//
//  CommentUserViewController.m
//  JokeContent
//
//  Created by 南木南木 on 2019/5/16.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "CommentUserViewController.h"
#import "CommentUserDataModel.h"
#import "CommentUserViewModel.h"

@interface CommentUserViewController ()<CommentUserTableViewCell>

@property(nonatomic,strong) CommentUserDataModel * dataModel;

@property(nonatomic,strong) CommentUserViewModel * viewModel;

@end

@implementation CommentUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    [self setUpInutUI];
    [self setBangding];
}

- (void)setUpInutUI{
    [self.viewModel setUpInitUI];
    self.viewModel.headView.model = self.model;
    [self.viewModel.headView layoutSubviews];
    self.viewModel.tableView.tableHeaderView = self.viewModel.headView;
}

- (void)setBangding{
    znWeakSelf(self)
    [self.dataModel.getCommentCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       znStrongSelf
        [weakSelf hideLoading];
        if ([x[0] boolValue]) {
            [weakSelf.viewModel.tableView reloadData];
        }else{
            
        }
    }];
    
    [self.dataModel.commitCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       znStrongSelf
        [weakSelf hideLoading];
        if ([x[0] boolValue]) {
            weakSelf.viewModel.commentView.commentTextView.text = commentPlaceText;
            weakSelf.viewModel.commentView.commentTextView.sd_layout.heightIs(zn_AutoWidth(25));
            [weakSelf.dataModel.getCommentCommand execute:@{@"commentId":weakSelf.model.objectId}];
        }else{
            [weakSelf showError:@"评论失败！"];
        }
    }];
    
    self.viewModel.inputCommentView.hideWithInputTextHandler = ^(NSString * _Nonnull content) {
        znStrongSelf
        if ([content isEqualToString:@""] || [content isEqualToString:commentPlaceText]) {
            weakSelf.viewModel.commentView.commentTextView.text = commentPlaceText;
            weakSelf.viewModel.commentView.commentTextView.sd_layout.heightIs(zn_AutoWidth(25));
        }else{
            UIFont * font = weakSelf.viewModel.commentView.commentTextView.font;
            CGFloat width = weakSelf.viewModel.commentView.commentTextView.width;
            CGFloat height = [content zn_obtainHeightWithFont:font width:width];
            //加上内容边距
            height = height + 8 + 8;
            if (height > zn_AutoWidth(150)) {
                weakSelf.viewModel.commentView.commentTextView.sd_layout.heightIs(zn_AutoWidth(150));
            }else if(height < zn_AutoWidth(25)){
                weakSelf.viewModel.commentView.commentTextView.sd_layout.heightIs(zn_AutoWidth(25));
            } else{
                weakSelf.viewModel.commentView.commentTextView.sd_layout.heightIs(height);
            }
            weakSelf.viewModel.commentView.commentTextView.text = content;
        }
        [weakSelf.viewModel.commentView upHeight];
    };
    
    [self showLoading];
    [self.dataModel.getCommentCommand execute:@{@"commentId":self.model.objectId}];
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataModel.models.count == 0) {
        return 1;
    }
    return self.dataModel.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataModel.models.count == 0) {
        return [UITableViewCell new];
    }
    
    CommentUserTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[CommentUserTableViewCell idString]];
    cell.model = self.dataModel.models[indexPath.row];
    cell.znDelegate = self;
    if (indexPath.row + 1 == self.dataModel.models.count) {
        cell.lineView.hidden = YES;
    }else{
        cell.lineView.hidden = NO;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataModel.models.count == 0) {
        return 0.01f;
    }
    return [tableView cellHeightForIndexPath:indexPath model:self.dataModel.models[indexPath.row] keyPath:@"model" cellClass:[CommentUserTableViewCell class] contentViewWidth:screenWidth];
}

#pragma mark - CommentUserTableViewCell

//点赞
- (void)thumUp:(CommentUserModel *)model{
    
}

#pragma mark - RPDetailCommentViewDelegate

/**
 点击消息
 */
- (void)messageAritcleBtnAction{
    
}

/**
 点击点赞
 */
- (void)thumUpAritcleBtnAction{
    
}

/**
 提交评论内容
 
 @param context <#context description#>
 */
- (void)commitComment:(NSString*) context{
    if ([self toLoginController]) {
        
    }else{
        CommentUserModel * model = [CommentUserModel new];
        model.userIcon = self.model.fromUserIcon;
        model.userId = self.model.fromUserID;
        model.userNikeName = self.model.fromUserName;
        model.createTime = [ZNTimeTool getCurrentTimes];
        model.commentText = context;
        model.commentId = self.model.objectId;
        [self showLoading];
        [self.dataModel.commitCommand execute:model];
    }
}

/**
 展示评论输入视图
 */
- (void)showInputComment{
    if ([self.viewModel.commentView.commentTextView.text isEqualToString:commentPlaceText]) {
        [self.viewModel.inputCommentView show:@""];
    }else{
        [self.viewModel.inputCommentView show:self.viewModel.commentView.commentTextView.text];
    }
}

#pragma mark - get

- (CommentUserViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [CommentUserViewModel new];
        _viewModel.controller = self;
    }
    return _viewModel;
}

- (CommentUserDataModel *)dataModel{
    if (!_dataModel) {
        _dataModel = [CommentUserDataModel new];
    }
    return _dataModel;
}

@end

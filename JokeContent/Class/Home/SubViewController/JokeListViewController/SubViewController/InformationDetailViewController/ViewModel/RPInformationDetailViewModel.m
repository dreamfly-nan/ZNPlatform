//
//  RPInformationViewModel.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPInformationDetailViewModel.h"
#import "RPCommentTableViewCell.h"

@interface RPInformationDetailViewModel()

@end

@implementation RPInformationDetailViewModel

- (void)setupInitUI{
    [self.viewController.view addSubview:self.tableView];
    [self.viewController.view addSubview:self.commentView];
    self.commentView.sd_layout
    .leftEqualToView(self.viewController.view)
    .rightEqualToView(self.viewController.view)
    .bottomEqualToView(self.viewController.view)
    .autoHeightRatio(0);
    
    self.tableView.sd_layout
    .bottomSpaceToView(self.commentView, 0)
    .leftEqualToView(self.viewController.view)
    .rightEqualToView(self.viewController.view)
    .topEqualToView(self.viewController.view);
    
}

#pragma mark ------get--------

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self.viewController;
        _tableView.dataSource = self.viewController;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, zn_AutoHeight(40), 0);
        [_tableView registerClass:[RPCommentTableViewCell class] forCellReuseIdentifier:[RPCommentTableViewCell idString]];
    }
    return _tableView;
}

- (RPDetailCommentView *)commentView{
    if (!_commentView) {
        _commentView = [RPDetailCommentView new];
        _commentView.znDelegate = self.viewController;
        _commentView.backgroundColor = [UIColor whiteColor];
    }
    return _commentView;
}

- (RPDtailCommentHeadView *)commentHeadView{
    if (!_commentHeadView) {
        _commentHeadView = [RPDtailCommentHeadView new];
    }
    return _commentHeadView;
}

- (RPDetailHeadView *)headView{
    if (!_headView) {
        _headView = [RPDetailHeadView new];
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

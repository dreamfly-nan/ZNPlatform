//
//  RPInformationViewModel.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaseObject.h"
#import "RPInformationDetailViewController.h"
#import "RPDetailCommentView.h"
#import "RPDtailCommentHeadView.h"
#import "RPDetailHeadView.h"
#import "CXInputView.h"

@interface RPInformationDetailViewModel : RPBaseObject

@property (nonatomic , strong) UITableView * tableView;

/**
 底部评论的视图
 */
@property (nonatomic , strong) RPDetailCommentView * commentView;

/**
 输入评论的视图
 */
@property(nonatomic,strong) CXInputView *inputCommentView;

//评论的头部
@property (nonatomic , strong) RPDtailCommentHeadView * commentHeadView;

//tableview的头部
@property (nonatomic , strong) RPDetailHeadView *headView;

@property (nonatomic , weak) RPInformationDetailViewController *viewController;

- (void)setupInitUI;

@end

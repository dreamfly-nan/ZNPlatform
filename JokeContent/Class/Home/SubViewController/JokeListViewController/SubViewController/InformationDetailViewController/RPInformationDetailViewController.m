//
//  RPInformationDetailViewController.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPInformationDetailViewController.h"
#import "CommentUserViewController.h"
#import "RPInformationDetailViewModel.h"
#import "RPInformationDetailDataModel.h"
#import "RPCommentTableViewCell.h"

@interface RPInformationDetailViewController ()
<RPCommentTableViewCellDelegate>

@property (nonatomic , strong) RPInformationDetailViewModel *viewmodel;

@property (nonatomic , strong) RPInformationDetailDataModel *datamodel;

@property (nonatomic , strong) UIButton * backBtn;

@property (nonatomic , assign) BOOL isLink;

@property (nonatomic , assign) CGFloat tableViewHeight;

@property(nonatomic,assign) BOOL isAddGlod;

@end

@implementation RPInformationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewHeight = 0;
    self.isLink = YES;
    self.isAddGlod = NO;
    self.title = @"资讯详情";
    UIBarButtonItem * backBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    self.navigationItem.leftBarButtonItems = @[backBarItem];
    [self.viewmodel setupInitUI];
    [self setBingding];
    // Do any additional setup after loading the view.
}

- (void)setBingding{
    [self showLoading];
    znWeakSelf(self)
    [RACObserve(self.viewmodel.headView, isLoadFinish) subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        if ([x boolValue]) {
            [weakSelf hideLoading];
            if (!weakSelf.viewmodel.headView.isSuccess) {
                [weakSelf showError:@"请求失败！"];
            }
//            [weakSelf.viewmodel.tableView beginUpdates];
            weakSelf.viewmodel.tableView.tableHeaderView = weakSelf.viewmodel.headView;
            [weakSelf.viewmodel.tableView reloadData];
//            [weakSelf.viewmodel.tableView endUpdates];
        }
    }];
    
    [RACObserve(self.viewmodel.tableView, contentOffset) subscribeNext:^(id  _Nullable x) {
       znStrongSelf
        if ([RPConfig sharedInstance].userData == nil || weakSelf.isAddGlod) {
            return;
        }
        
        CGPoint point = weakSelf.viewmodel.tableView.contentOffset;
        //阅读超过80%，则进行奖励金币
        if (point.y / weakSelf.viewmodel.headView.height > 0.8) {
            
            weakSelf.isAddGlod = YES;
            NSString * goldNumber = [RPConfig sharedInstance].userData.gold_coin;
            if (goldNumber && ![goldNumber isEqualToString:@""]) {
                int number = [goldNumber intValue] + glodNumerWithOne;
                goldNumber = [NSString stringWithFormat:@"%d",number];
            }else{
                goldNumber = @"10";
            }
            
            [[RPConfig sharedInstance].userData zn_updateWithDic:@{@"gold_coin":goldNumber} ResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    [weakSelf hideLoading];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [MBProgressHUD zn_show:@"阅读奖励10金币！" icon:@"get_glod" view:weakSelf.view];
                    });
                }else{
                    NSLog(@"阅读金币获取失败!");
                }
            }];
        }
    }];
    
    self.viewmodel.inputCommentView.hideWithInputTextHandler = ^(NSString * _Nonnull content) {
      znStrongSelf
        if ([content isEqualToString:@""] || [content isEqualToString:commentPlaceText]) {
            weakSelf.viewmodel.commentView.commentTextView.text = commentPlaceText;
            weakSelf.viewmodel.commentView.commentTextView.sd_layout.heightIs(zn_AutoWidth(25));
        }else{
            UIFont * font = weakSelf.viewmodel.commentView.commentTextView.font;
            CGFloat width = weakSelf.viewmodel.commentView.commentTextView.width;
            CGFloat height = [content zn_obtainHeightWithFont:font width:width];
            //加上内容边距
            height = height + 8 + 8;
            if (height > zn_AutoWidth(150)) {
                weakSelf.viewmodel.commentView.commentTextView.sd_layout.heightIs(zn_AutoWidth(150));
            }else if(height < zn_AutoWidth(25)){
                weakSelf.viewmodel.commentView.commentTextView.sd_layout.heightIs(zn_AutoWidth(25));
            } else{
                weakSelf.viewmodel.commentView.commentTextView.sd_layout.heightIs(height);
            }
            weakSelf.viewmodel.commentView.commentTextView.text = content;
        }
        
        [weakSelf.viewmodel.commentView upHeight];
    };
    
    [self.datamodel.commentCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        [weakSelf hideLoading];
        if ([x[0] boolValue]) {
            weakSelf.viewmodel.commentView.commentTextView.text = commentPlaceText;
            weakSelf.viewmodel.commentView.commentTextView.sd_layout.heightIs(zn_AutoWidth(25));
            [weakSelf.datamodel.getCommentCommands execute:@{@"link":weakSelf.information.link}];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.viewmodel.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.datamodel.ariticleComments.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            });
            
        }else{
            [weakSelf showError:x[1]];
        }
    }];
    
    [self.datamodel.getCommentCommands.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        if ([x[0] boolValue]) {
            [weakSelf.viewmodel.tableView reloadData];
        }else{
            [weakSelf showError:x[1]];
        }
    }];
    
    [self.datamodel.thumUpCommentCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        if ([x[0] boolValue]) {
            [self.viewmodel.tableView reloadData];
        }else{
            
        }
    }];
    
    [self.datamodel.getCommentCommands execute:@{@"link":self.information.link}];
}

#pragma mark - RPDetailCommentViewDelegate

- (void)messageAritcleBtnAction{
    //查看文章评论
    if (self.datamodel.ariticleComments.count > 0 ) {
        /* 滚动指定段的指定row  到 指定位置*/
        [self.viewmodel.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }else{
        [self showSuccess:@"暂无评论"];
    }
}

- (void)thumUpAritcleBtnAction{
    //给文章点赞
    
}

- (void)commitComment:(NSString *)context{
    self.tableViewHeight = self.viewmodel.tableView.contentOffset.y;
    //未登录跳转登录
    if ([self toLoginController]) {
        
    }else{
        CommentArticleModel * model = [CommentArticleModel new];
        model.commentText = context;
        model.title = self.information.title;
        model.imageUrl = [self.information.imageurls lastObject].url;
        model.fromUserID = [RPConfig sharedInstance].userData.objectId;
        model.fromUserIcon = [RPConfig sharedInstance].userData.iconUrl;
        model.fromUserName = [RPConfig sharedInstance].userData.nickName;
        model.link = self.information.link;
        model.createTime = [ZNTimeTool getCurrentTimes];
        model.source = self.information.source;
        model.pubDate = self.information.pubDate;
        [self showLoading];
        [self.datamodel.commentCommand execute:model];
    }
}

- (void)showInputComment{
    if ([self.viewmodel.commentView.commentTextView.text isEqualToString:commentPlaceText]) {
        [self.viewmodel.inputCommentView show:@""];
    }else{
        [self.viewmodel.inputCommentView show:self.viewmodel.commentView.commentTextView.text];
    }
}

#pragma mark - RPCommentTableViewCellDelegate

- (void)thumUpBtnAction:(CommentArticleModel *)model{

}

- (void)messageBtnAction:(CommentArticleModel *)model{
    
}

#pragma mark ---------UITableViewDelegate------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CommentUserViewController * controller = [CommentUserViewController new];
    controller.model = self.datamodel.ariticleComments[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ---------UITableViewDataSource-----------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.datamodel.ariticleComments.count > 0 && self.isLink) {
        return self.datamodel.ariticleComments.count;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.datamodel.ariticleComments.count > 0 && self.isLink) {
        RPCommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[RPCommentTableViewCell idString]];
        cell.znDelegate = self;
        cell.model = self.datamodel.ariticleComments[indexPath.row];
        return cell;
    }else{
        return [UITableViewCell new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.datamodel.ariticleComments.count > 0 && self.isLink) {
        CommentArticleModel * model = self.datamodel.ariticleComments[indexPath.row];
        return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[RPCommentTableViewCell class] contentViewWidth:screenWidth];
    }
    return 0.01f;
}

#pragma makr ------------set-----------

- (void)setInformation:(NewsDetailModel *)information{
    _information = information;
    [self.viewmodel.headView setModel:self.information];
}

#pragma mark ------------get----------

- (RPInformationDetailDataModel *)datamodel{
    if (!_datamodel) {
        _datamodel = [RPInformationDetailDataModel new];
        _datamodel.information = self.information;
    }
    return _datamodel;
}

- (RPInformationDetailViewModel *)viewmodel{
    if (!_viewmodel) {
        _viewmodel = [RPInformationDetailViewModel new];
        _viewmodel.viewController = self;
        _viewmodel.tableView.tableHeaderView = self.viewmodel.headView;
        _viewmodel.tableView.tableFooterView = [UIView new];
    }
    return _viewmodel;
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton new];
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        _backBtn.bounds = CGRectMake(0, 0, zn_AutoWidth(22), zn_AutoWidth(22));
        znWeakSelf(self)
        [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            znStrongSelf
            if ([weakSelf.viewmodel.headView isBackViewControllerOrWeb]) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                if ([[weakSelf.viewmodel.headView.webView.URL absoluteString] isEqualToString:weakSelf.information.link]) {
                    weakSelf.isLink = YES;
                }else{
                    weakSelf.isLink = NO;
                }
                [weakSelf.viewmodel.tableView reloadData];
            }
        }];
    }
    return _backBtn;
}

@end

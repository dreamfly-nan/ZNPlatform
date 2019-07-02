//
//  RPMyCommentViewController.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/7.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPMyCommentViewController.h"
#import "RPInformationDetailViewController.h"
#import "MyCommentTableViewCell.h"

#import "RPMyCommentDataModel.h"
#import "NewsDetailModel.h"

@interface RPMyCommentViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property(nonatomic,strong) RPMyCommentDataModel * dataModel;

@property(nonatomic,strong) UITableView * tableView;

@end

@implementation RPMyCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
    [self setBangding];
}

- (void)setBangding{
    znWeakSelf(self)
    [self.dataModel.getCommentCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        [weakSelf hideLoading];
        if ([x[0] boolValue]) {
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf showError:x[1]];
        }
    }];
    
    [self showLoading];
    [self.dataModel.getCommentCommand execute:nil];
}

#pragma mark - UITableViewDatasourece

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataModel.models.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[MyCommentTableViewCell idString]];
    cell.model = self.dataModel.models[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return zn_AutoWidth(100);
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RPInformationDetailViewController * controller = [RPInformationDetailViewController new];
    NewsDetailModel * model = [NewsDetailModel new];
    CommentArticleModel * commentModel = self.dataModel.models[indexPath.row];
    model.title = commentModel.title;
    model.source = commentModel.source;
    model.link = commentModel.link;
    model.pubDate = commentModel.pubDate;
    controller.information = model;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - get

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MyCommentTableViewCell class] forCellReuseIdentifier:[MyCommentTableViewCell idString]];
        _tableView.tableFooterView = [UIView new];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        
        if (@available(iOS 11.0 ,*)) {
            self.tableView.estimatedSectionFooterHeight = 0;
            self.tableView.estimatedSectionHeaderHeight = 0;
        }
    }
    return _tableView;
}

- (RPMyCommentDataModel *)dataModel{
    if (!_dataModel) {
        _dataModel = [RPMyCommentDataModel new];
    }
    return _dataModel;
}

@end

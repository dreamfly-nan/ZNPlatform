//
//  JokeListViewController.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/17.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "JokeListViewController.h"
#import "RPInformationDetailViewController.h"
#import "OneTypeTableViewCell.h"
#import "ThreeTypeTableViewCell.h"
#import "TwoTypeTableViewCell.h"
#import "TextTableViewCell.h"

#import "JokeListDataModel.h"

@interface JokeListViewController()

@property (nonatomic , strong) UITableView * tableView;

@property (nonatomic , strong) JokeListDataModel * dataModel;

@end

@implementation JokeListViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpInitUI];
    [self setBingding];
}

- (void)reloadRequest{
    [self showLoading];
    [self.dataModel.informationCommand execute:nil];
}

- (void)setUpInitUI{
    [self.view addSubview:self.tableView];
    __block UIViewController * controller = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(controller.view);
        make.right.equalTo(controller.view);
        make.top.equalTo(controller.view);
        make.bottom.equalTo(controller.view);
    }];
}

- (void)setBingding{
    znWeakSelf(self)
    [self.dataModel.informationCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        [weakSelf hideLoading];
        if (weakSelf.dataModel.isNoMoreData) {
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [weakSelf.tableView.mj_footer endRefreshing];
        }
        [weakSelf.tableView.mj_header endRefreshing];
        if ([x[0] boolValue]) {
            if (weakSelf.dataModel.page == 1 && weakSelf.dataModel.informations.count < 5) {
                weakSelf.dataModel.page ++;
                [weakSelf.dataModel.informationCommand execute:nil];
            }
            [weakSelf.tableView reloadData];
        }else{
            
        }
    }];
    
    [self showLoading];
    [self.dataModel.informationCommand execute:nil];
}

#pragma mark ------------UITableViewDelegate-------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RPInformationDetailViewController * controller = [RPInformationDetailViewController new];
    controller.information = self.dataModel.informations[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ------------UITableViewDataSource-----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.dataModel.informations.count == 0) {
        return 0;
    }
    return self.dataModel.informations.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsDetailModel * model = self.dataModel.informations[indexPath.row];
    //    （0.文章-一张小图，1.文章一张大图，2.文章三张小图, 3.视频）
    switch (model.type) {
        case 0:
        {
            return zn_AutoHeight(100);
        }
        case 1:
        {
//            return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[OneTypeTableViewCell class] contentViewWidth:screenWidth];
            return zn_AutoHeight(96);
        }
        case 2:
        {
            return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[TwoTypeTableViewCell class] contentViewWidth:screenWidth];
        }
        case 3:
        {
            return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[ThreeTypeTableViewCell class] contentViewWidth:screenWidth];
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsDetailModel * model = self.dataModel.informations[indexPath.row];
    //    （0.文章-一张小图，1.文章一张大图，2.文章三张小图, 3.视频）
    switch (model.type) {
        case 0:
        {
            TextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[OneTypeTableViewCell idString]];
            cell.model = model;
            return cell;
        }
        case 1:
        {
            OneTypeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[OneTypeTableViewCell idString]];
            cell.model = model;
            return cell;
        }
        case 2:
        {
            TwoTypeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[TwoTypeTableViewCell idString]];
            cell.model = model;
            return cell;
        }
        case 3:
        {
            ThreeTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ThreeTypeTableViewCell idString]];
            cell.model = model;
            return cell;
        }
    }
    return [UITableViewCell new];
}

#pragma mark - get

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[OneTypeTableViewCell class] forCellReuseIdentifier:[OneTypeTableViewCell idString]];
        [_tableView registerClass:[TwoTypeTableViewCell class] forCellReuseIdentifier:[TwoTypeTableViewCell idString]];
        [_tableView registerClass:[ThreeTypeTableViewCell class] forCellReuseIdentifier:[ThreeTypeTableViewCell idString]];
        [_tableView registerClass:[TextTableViewCell class] forCellReuseIdentifier:[TextTableViewCell idString]];
        _tableView.tableFooterView = [UIView new];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        
        znWeakSelf(self)
        _tableView.mj_header = [RPRfreshHeader headerWithRefreshingBlock:^{
            znStrongSelf
            weakSelf.dataModel.page = 1;
            [weakSelf.dataModel.informationCommand execute:nil];
        }];
        
        _tableView.mj_footer = [RPRefreshFooter footerWithRefreshingBlock:^{
            znStrongSelf
            weakSelf.dataModel.page ++;
            [weakSelf.dataModel.informationCommand execute:nil];
        }];
        
        if (@available(iOS 11.0 ,*)) {
//            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            self.tableView.estimatedSectionFooterHeight = 0;
            self.tableView.estimatedSectionHeaderHeight = 0;
        }else{
            
        }
    }
    return _tableView;
}

- (JokeListDataModel *)dataModel{
    if (!_dataModel) {
        _dataModel = [JokeListDataModel new];
        _dataModel.typeId = self.typeId;
        _dataModel.searchText = self.searchText;
    }
    return _dataModel;
}

@end

//
//  RPMyInforMationViewController.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/7.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPMyInformationViewController.h"
#import "RPMyInformationDataModel.h"
#import "ItemTableViewCell.h"

@interface RPMyInformationViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic , strong) UITableView * tableview;

@property (nonatomic , strong) UIButton * sureBtn;

@property (nonatomic , strong) RPMyInformationDataModel * dataModel;

@end

@implementation RPMyInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    [self setInitUI];
    [self setBingding];
    // Do any additional setup after loading the view.
}

- (void)setInitUI{
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:self.sureBtn]];
    [self.view addSubview:self.tableview];
}

- (void)setBingding{
    znWeakSelf(self)
    
    [self.dataModel.upUserDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       znStrongSelf
        [weakSelf hideLoading];
        if ([x[0] boolValue]) {
            //更新用户数据
            [weakSelf.dataModel upUserData];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [weakSelf showError:x[1]];
        }
    }];
    
    [[self.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        [weakSelf showLoading];
        [weakSelf.dataModel.upUserDataCommand execute:nil];
    }];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataModel.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[ItemTableViewCell idString]];
    cell.model = self.dataModel.items[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView cellHeightForIndexPath:indexPath model:nil keyPath:@"model" cellClass:[ItemTableViewCell class] contentViewWidth:screenWidth];
}

#pragma mark - get

- (RPMyInformationDataModel *)dataModel{
    if (!_dataModel) {
        _dataModel = [RPMyInformationDataModel new];
    }
    return _dataModel;
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = Big_background_Color();
        _tableview.tableFooterView = [UIView new];
        [_tableview registerClass:[ItemTableViewCell class] forCellReuseIdentifier:[ItemTableViewCell idString]];
        if (@available(iOS 11.0 ,*)) {
            _tableview.estimatedSectionFooterHeight = 0;
            _tableview.estimatedSectionHeaderHeight = 0;
        }
    }
    return _tableview;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton new];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = zn_font(13);
        [_sureBtn setTitleColor:Main_Color() forState:UIControlStateNormal];
    }
    return _sureBtn;
}


@end

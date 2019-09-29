//
//  ZNChooseViewController.m
//  CityManagement
//
//  Created by 南木南木 on 2019/8/29.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "ZNChooseViewController.h"
#import "ZNDatePicker.h"
#import "ZNChooseTwoTableViewCell.h"
#import "ZNChooseOneTableViewCell.h"
#import "ZNChooseDataModel.h"
@interface ZNChooseViewController ()
<UITableViewDataSource,
UITableViewDelegate>

@property(nonatomic,strong) ZNChooseDataModel * dataModel;

@property(nonatomic,strong) UITableView * tableView;

@property(nonatomic,strong) UIButton * sureBtn;

@property(nonatomic,strong) NSMutableArray<ZNChooseItemModel*> * chooseTitles;

@property(nonatomic,strong) NSMutableArray<NSArray<ZNChooseItemModel*>*> * chooseItems;

@end

@implementation ZNChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setInitUI];
    [self setBangding];
    // Do any additional setup after loading the view.
}

- (void)setInitUI{
    [self.view addSubview:self.sureBtn];
    [self.view addSubview:self.tableView];
    self.sureBtn.sd_layout
    .bottomEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(zn_AutoWidth(53));
    
    self.tableView.sd_layout
    .topSpaceToView(self.view, zn_AutoWidth(0))
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomSpaceToView(self.sureBtn, 0);
}

- (void)setBangding{
    znWeakSelf(self)
    [[self.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        if (weakSelf.znDelegate && [weakSelf.znDelegate respondsToSelector:@selector(chooseTitles:items:)]) {
            [weakSelf obtainChooseData];
            [weakSelf.znDelegate chooseTitles:self.chooseTitles items:self.chooseItems];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)obtainChooseData{
    for (int section = 0; section < self.titleItems.count; section ++) {
        ZNChooseItemModel * sectionModel = self.titleItems[section];
        if (sectionModel.cellType == ZNChooseTableViewCellTypeText) {
            NSMutableArray * array = [NSMutableArray array];
            for (ZNChooseItemModel * model in self.items[section]) {
                if (model.isChoose) {
                    if (![self.chooseTitles containsObject:sectionModel]) {
                        [self.chooseTitles addObject:sectionModel];
                    }
                    [array addObject:model];
                }
            }
            if (array.count > 0) {
                [self.chooseItems addObject:[array copy]];
            }
        }else if(sectionModel.cellType == ZNChooseTableViewCellTypeTime){
            [self.chooseTitles addObject:sectionModel];
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ZNChooseItemModel * model = self.titleItems[section];
    //展开
    if (model.isExtend) {
        return self.items[section].count + 1;
    }else{
        //未展开
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ZNChooseOneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[ZNChooseOneTableViewCell idString]];
        cell.model = self.titleItems[indexPath.section];
        return cell;
    }else{
        ZNChooseTwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[ZNChooseTwoTableViewCell idString]];
        cell.model = self.items[indexPath.section][indexPath.row - 1];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return zn_AutoWidth(55);
    }
    return zn_AutoWidth(47);
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ZNChooseItemModel * model = self.titleItems[indexPath.section];
        if (model.cellType == ZNChooseTableViewCellTypeText) {
            model.isExtend = !model.isExtend;
            [self.tableView reloadData];
        }else if(model.cellType == ZNChooseTableViewCellTypeTime){
            znWeakSelf(self)
            [ZNDatePicker zn_showDatePickerWithBlick:^(NSString * _Nonnull dateStr) {
                znStrongSelf
                model.content = dateStr;
                [weakSelf.tableView reloadData];
            }];
        }
    }else{
        ZNChooseItemModel * model = self.items[indexPath.section][indexPath.row - 1];
        model.isChoose = !model.isChoose;
        [self.tableView reloadData];
    }
    
}

#pragma mark - get

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView registerClass:[ZNChooseOneTableViewCell class] forCellReuseIdentifier:[ZNChooseOneTableViewCell idString]];
        
        [_tableView registerClass:[ZNChooseTwoTableViewCell class] forCellReuseIdentifier:[ZNChooseTwoTableViewCell idString]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = UIButton.zn_create
        .zn_font(zn_font(18))
        .zn_title(@"确定",UIControlStateNormal)
        .zn_titleColor([UIColor whiteColor],UIControlStateNormal);
        _sureBtn.backgroundColor = MAIN_COLOR;
    }
    return _sureBtn;
}

- (ZNChooseDataModel *)dataModel{
    if (!_dataModel) {
        _dataModel = [ZNChooseDataModel new];
    }
    return _dataModel;
}

- (NSMutableArray<ZNChooseItemModel *> *)chooseTitles{
    if (!_chooseTitles) {
        _chooseTitles = [NSMutableArray new];
    }
    return _chooseTitles;
}

- (NSMutableArray<NSArray<ZNChooseItemModel *> *> *)chooseItems{
    if (!_chooseItems) {
        _chooseItems = [NSMutableArray new];
    }
    return _chooseItems;
}

@end

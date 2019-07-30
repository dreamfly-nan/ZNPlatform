//
//  ZNSearchViewController.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/18.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNSearchViewController.h"
#import "ZNSearchViewModel.h"
#import "ZNSearchDataModel.h"

@interface ZNSearchViewController ()

@property(nonatomic,strong) ZNSearchViewModel * viewModel;

@property(nonatomic,strong) ZNSearchDataModel * dataModel;

@end

@implementation ZNSearchViewController

#pragma mark - life

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACKGROUND_COLOR;
    [self.viewModel setInitUI];
    [self setBangding];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.viewModel.searchBarView.searchText.textField becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - private

- (void)setBangding{
    znWeakSelf(self)
    
    self.viewModel.searchBarView.backBlock = ^{
        znStrongSelf
        [weakSelf signOut];
    };
    
    self.viewModel.searchBarView.searchBlock = ^(NSString * _Nonnull searchText) {
      znStrongSelf
        [weakSelf searchText:searchText];
    };
    
    [[self.viewModel.deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       znStrongSelf
        [ZNAlertDialogTool zn_showController:weakSelf title:nil message:@"确定删除记录？" sureTitle:@"确定" cancelTitle:@"取消" block:^(BOOL sure) {
            if (sure) {
                [weakSelf.dataModel deleteHistory:@""];
                [weakSelf.dataModel.history removeAllObjects];
                [weakSelf.viewModel.historyCollectionView reloadData];
                if (weakSelf.znDelegate && [weakSelf.znDelegate respondsToSelector:@selector(deleteHistory:)]) {
                    [weakSelf.znDelegate deleteHistory:weakSelf.dataModel.history];
                }
            }
        }];
    }];
}

- (void)searchText:(NSString *) text{
    [self.dataModel saveHistory:text];
    [self.dataModel.history addObject:text];
    [self.viewModel.historyCollectionView reloadData];
    if (self.znDelegate && [self.znDelegate respondsToSelector:@selector(searchWithStr:controller:)]) {
        [self.znDelegate searchWithStr:text controller:self];
    }
    
}

- (void)signOut{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self searchText:self.dataModel.history[indexPath.row]];
}

#pragma mark - UICollectionViewDatasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataModel.history.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZNSearchHistoryItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZNSearchHistoryItemCell idString] forIndexPath:indexPath];
    cell.text = self.dataModel.history[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString * text = self.dataModel.history[indexPath.row];
    CGFloat width = [text zn_obtainWidthWithHeight:zn_AutoWidth(20) font:zn_font(12)];
    CGSize size = CGSizeMake(width + zn_AutoWidth(10), zn_AutoWidth(20));
    return size;
}

#pragma mark - get

- (ZNSearchViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [ZNSearchViewModel new];
        _viewModel.controller = self;
    }
    return _viewModel;
}

- (ZNSearchDataModel *)dataModel{
    if (!_dataModel) {
        _dataModel = [ZNSearchDataModel new];
    }
    return _dataModel;
}

@end

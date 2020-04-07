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

@property (nonatomic , assign) BOOL isSearch;

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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isSearch = NO;
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
        searchText = [searchText stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (searchText && ![searchText isEqualToString:@""]) {
            if (!weakSelf.isSearch) {
                [weakSelf searchText:searchText];
            }
        }else{
            weakSelf.viewModel.searchBarView.searchText.textField.text = @"";
            [weakSelf showError:@"检索内容不能为空"];
        }
    };
}

- (void)searchText:(NSString *) text{
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(text && ![text isEqualToString:@""]){
        if (self.znDelegate && [self.znDelegate respondsToSelector:@selector(searchWithStr:controller:)]) {
            [self.znDelegate searchWithStr:text controller:self];
        }
    }else{
        [self showError:@"检索关键词不能为空"];
    }
    
    //如果历史记录中有，则不进行存储
    for (NSString * history in self.dataModel.history) {
        if ([text isEqualToString:history]) {
            return;
        }
    }
    //历史记录保留最新的
    if (self.dataModel.history.count >= self.history) {
        if (self.dataModel.history.count > 0) {
            //删除
            [self.dataModel deleteHistory:self.dataModel.history[self.history-1]];
            [self.dataModel.history removeObjectAtIndex:self.history-1];
        }
    }
    
    [self.dataModel saveHistory:text];
    [self.dataModel.history insertObject:text atIndex:0];
    [self.viewModel.historyCollectionView reloadData];
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
    self.isSearch = YES;
    //只有一组的话，可能是历史，也可以是推荐
    if (indexPath.section == 0) {
        if (self.dataModel.history.count > 0) {
            [self searchText:self.dataModel.history[indexPath.row]];
        }else{
            if (self.recommends.count > 0) {
                [self searchText:self.recommends[indexPath.row]];
            }
        }
    }else{
        [self searchText:self.recommends[indexPath.row]];
    }
}

#pragma mark - UICollectionViewDatasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    int section = 0;
    if (self.recommends.count > 0) {
        section ++;
    }
    if (self.dataModel.history.count > 0) {
        section ++;
    }
    return section;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.dataModel.history.count > 0) {
            return self.dataModel.history.count;
        }else{
            return self.recommends.count;
        }
    }else{
        return self.recommends.count;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] ) {
        ZNRecommendView * headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZNRecommendView" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            if(self.dataModel.history.count > 0){
                headView.recommendLabel.text = @"历史记录";
                headView.isShowClear = YES;
                znWeakSelf(self)
                headView.clearHistory = ^{
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
                };
            }else{
                headView.recommendLabel.text = @"推荐搜索";
                headView.isShowClear = NO;
            }
        }else{
            headView.recommendLabel.text = @"推荐搜索";
            headView.isShowClear = NO;
        }
        return headView;
    }else{
        ZNSearchFooterView * footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ZNSearchFooterView" forIndexPath:indexPath];
        return footerView;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(screenWidth, zn_AutoWidth(59));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section == 0) {
        if (self.dataModel.history.count > 0) {
            return CGSizeMake(screenWidth, zn_AutoWidth(35));
        }
    }
    return CGSizeZero;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZNSearchHistoryItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZNSearchHistoryItemCell idString] forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (self.dataModel.history.count > 0) {
            cell.text = self.dataModel.history[indexPath.row];
            cell.backgroundColor = zn_colorString(@"#f2f2f2");
            cell.zn_borderColor([UIColor clearColor]).zn_borderWidth(0.5);
        }else{
            cell.text = self.recommends[indexPath.row];
            cell.backgroundColor = [UIColor whiteColor];
            cell.zn_borderColor(zn_colorString(@"#cccccc")).zn_borderWidth(0.5);
        }
    }else{
        cell.text = self.recommends[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        cell.zn_borderColor(zn_colorString(@"#cccccc")).zn_borderWidth(0.5);
    }
    cell.layer.cornerRadius = zn_AutoWidth(11);
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString * text = @"";
    if (indexPath.section == 0) {
        if (self.dataModel.history.count > 0) {
            text = self.dataModel.history[indexPath.row];
        }else{
            text = self.recommends[indexPath.row];
        }
    }else{
        text = self.recommends[indexPath.row];
    }
    CGFloat width = [text zn_obtainWidthWithHeight:zn_AutoWidth(20) font:zn_font(12)];
    if ((width + zn_AutoWidth(10)) >= screenWidth) {
        width = screenWidth - zn_AutoWidth(40);
    }
    CGSize size = CGSizeMake(width + zn_AutoWidth(10), zn_AutoWidth(22));
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

- (int)history{
    if (!_history) {
        _history = 8;
    }
    return _history;
}

@end

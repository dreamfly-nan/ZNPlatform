//
//  ZNSearchViewModel.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/18.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNSearchViewModel.h"


@implementation ZNSearchViewModel

- (void)setInitUI{
    [self.controller.view addSubview:self.searchBarView];
    [self.controller.view addSubview:self.historyLabel];
    [self.controller.view addSubview:self.deleteBtn];
    [self.controller.view addSubview:self.historyCollectionView];
    [self setLayoutWithView:self.controller.view];
}

- (void)setLayoutWithView:(UIView *) view{
    self.searchBarView.sd_layout
    .topSpaceToView(view, znStateHeight)
    .leftEqualToView(view)
    .rightEqualToView(view)
    .heightIs(zn_AutoWidth(45));
    
    self.historyLabel.sd_layout
    .topSpaceToView(self.searchBarView, zn_AutoWidth(20))
    .leftSpaceToView(view, zn_AutoWidth(15))
    .widthIs(zn_AutoWidth(60))
    .heightIs(zn_AutoWidth(20));
    
    self.deleteBtn.sd_layout
    .centerYEqualToView(self.historyLabel)
    .rightSpaceToView(view, zn_AutoWidth(15))
    .widthIs(zn_AutoWidth(30))
    .heightIs(zn_AutoWidth(20));
    
    self.historyCollectionView.sd_layout
    .topSpaceToView(self.historyLabel, zn_AutoWidth(5))
    .leftSpaceToView(view, zn_AutoWidth(15))
    .rightSpaceToView(view, zn_AutoWidth(15))
    .bottomEqualToView(view);
}

#pragma mark - get

- (UILabel *)historyLabel{
    if (!_historyLabel) {
        _historyLabel = [UILabel new];
        _historyLabel.zn_text(@"历史记录")
        .zn_font(zn_font(12))
        .zn_textColor(PLACE_COLOR)
        .zn_alignment(NSTextAlignmentLeft);
    }
    return _historyLabel;
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton new];
        _deleteBtn.zn_title(@"清空",UIControlStateNormal)
        .zn_titleColor(PLACE_COLOR,UIControlStateNormal)
        .zn_font(zn_font(12));
    }
    return _deleteBtn;
}

- (ZNSearchBarView *)searchBarView{
    if (!_searchBarView) {
        _searchBarView = [[ZNSearchBarView alloc] init];
        _searchBarView.searchText.isLeftView = YES;
        _searchBarView.searchText.leftImage = zn_ImagePath(@"magnifier", @".png");
        _searchBarView.searchText.imageSize = CGSizeMake(zn_AutoWidth(15), zn_AutoWidth(15));
        _searchBarView.searchText.inset = UIEdgeInsetsMake(0, zn_AutoWidth(10), 0, 0);
        _searchBarView.searchText.textField.zn_font(zn_font(13));
        _searchBarView.searchText.zn_borderWidth(1).zn_borderColor(PLACE_COLOR).zn_cornerRadius(3);
    }
    return _searchBarView;
}

- (ZNCollectionViewFlowlayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [ZNCollectionViewFlowlayout new];
        _flowLayout.minimumInteritemSpacing = zn_AutoWidth(10);
        _flowLayout.leftLayout = YES;
    }
    return _flowLayout;
}

- (UICollectionView *)historyCollectionView{
    if (!_historyCollectionView) {
        _historyCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _historyCollectionView.backgroundColor = [UIColor clearColor];
        [_historyCollectionView registerClass:[ZNSearchHistoryItemCell class] forCellWithReuseIdentifier:[ZNSearchHistoryItemCell idString]];
        _historyCollectionView.delegate = self.controller;
        _historyCollectionView.dataSource = self.controller;
    }
    return _historyCollectionView;
}

@end

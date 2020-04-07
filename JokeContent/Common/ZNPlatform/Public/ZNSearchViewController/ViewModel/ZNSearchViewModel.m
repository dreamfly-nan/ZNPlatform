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
    self.controller.view.backgroundColor = [UIColor whiteColor];
    [self.controller.view addSubview:self.searchBarView];
    [self.controller.view addSubview:self.historyCollectionView];
    [self setLayoutWithView:self.controller.view];
}

- (void)setLayoutWithView:(UIView *) view{
    self.searchBarView.sd_layout
    .topSpaceToView(view, znStateHeight)
    .leftEqualToView(view)
    .rightEqualToView(view)
    .heightIs(zn_AutoWidth(44));
    
    [self.searchBarView zn_setBottomLineWithColor:LINE_COlOR];
    
    self.historyCollectionView.sd_layout
    .topSpaceToView(self.searchBarView, 0)
    .leftSpaceToView(view, 0)
    .rightSpaceToView(view, 0)
    .bottomEqualToView(view);
}

#pragma mark - get

- (ZNSearchBarView *)searchBarView{
    if (!_searchBarView) {
        _searchBarView = [[ZNSearchBarView alloc] init];
        _searchBarView.searchText.isLeftView = YES;
        _searchBarView.searchText.leftImage = zn_imageName(@"public_search");
        _searchBarView.searchText.imageSize = CGSizeMake(zn_AutoWidth(15), zn_AutoWidth(15));
        _searchBarView.searchText.inset = UIEdgeInsetsMake(0, zn_AutoWidth(10), 0, 0);
        _searchBarView.searchText.textField.zn_font(zn_font(13));
        _searchBarView.searchText.zn_cornerRadius(3);
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
        
        [_historyCollectionView registerClass:[ZNRecommendView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZNRecommendView"];
        
        [_historyCollectionView registerClass:[ZNSearchFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ZNSearchFooterView"];
        
        _historyCollectionView.delegate = self.controller;
        _historyCollectionView.dataSource = self.controller;
    }
    return _historyCollectionView;
}

@end

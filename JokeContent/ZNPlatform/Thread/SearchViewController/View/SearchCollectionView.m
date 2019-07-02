//
//  SearchCollectionView.m
//  准到-ipad
//
//  Created by zhundao on 2017/9/8.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "SearchCollectionView.h"
#import "SearchCollectionViewCell.h"
#import "SearchViewModel.h"
static NSString *cellID = @"searchID";

@interface SearchCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>
/*! viewmodel */
@property(nonatomic,strong)SearchViewModel *searchVM;
@end

@implementation SearchCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout array :(NSMutableArray *)dataArray{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource =self;
        self.scrollEnabled = NO;
        _dataArray = [dataArray mutableCopy];
        self.backgroundColor = Big_background_Color();
        [self registerClass:[SearchCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    }
    return self;
}

#pragma mark --- 懒加载 

- (BigSizeButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [BigSizeButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectZero;
        [_deleteButton setImage:[UIImage imageNamed:@"Search-Delete"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (SearchViewModel *)searchVM{
    if (!_searchVM) {
        _searchVM =[[SearchViewModel alloc]init];
    }
    return _searchVM;
}

#pragma mark ---UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.searchStr = self.dataArray[indexPath.item];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(removeCell:)];
    [cell addGestureRecognizer:longPress];
    return cell;
    
}

#pragma mark --- UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchCollectionViewCell *cell = (SearchCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[SearchCollectionViewCell alloc]initWithFrame:CGRectZero];;
    }
    cell.searchStr = self.dataArray[indexPath.item];
    return [cell sizeForCell];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [_historyDelegate select :_dataArray[indexPath.item]];
}

#pragma mark --- UILongPressGestureRecognizer

- (void)removeCell:(UILongPressGestureRecognizer *)ges{
    CGPoint touchPoint = [ges locationInView:self];
    SearchCollectionViewCell *cell = (SearchCollectionViewCell *)ges.view;
    NSIndexPath *indexpath = [self indexPathForItemAtPoint:touchPoint];
    if (ges.state == UIGestureRecognizerStateBegan) {
        NSLog(@"第%li个",(long)indexpath.item);
        self.deleteButton.frame = CGRectMake(cell.frame.size.width-20, 3, 20, 20);
        [cell addSubview:self.deleteButton];
    }
}

- (void)deleteData{
    SearchCollectionViewCell *cell = (SearchCollectionViewCell *)_deleteButton.superview;
    [_deleteButton removeFromSuperview];
    [_historyDelegate delete:cell.wordLabel.text];
}

@end

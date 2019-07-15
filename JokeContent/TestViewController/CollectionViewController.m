//
//  CollectionViewController.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/8.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "CollectionViewController.h"
#import "ZNMenuCollectViewCell.h"

@interface CollectionViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property(nonatomic,strong) UICollectionView * collectionView;

@property(nonatomic,strong) UICollectionViewFlowLayout * flowLayout;

@property(nonatomic,strong) NSArray * menuItems;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionDelegate

#pragma mark - UICollectionDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.menuItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZNMenuCollectViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZNMenuCollectViewCell idString] forIndexPath:indexPath];
    cell.model = self.menuItems[indexPath.row];
    return cell;
}

#pragma mark - get

- (NSArray *)menuItems{
    if (!_menuItems) {
        _menuItems = @[
                       [ZNMentItemModel initWithTitle:@"资讯" image:@"information_select"],
                       [ZNMentItemModel initWithTitle:@"资讯" image:@"information_select"],
                       [ZNMentItemModel initWithTitle:@"资讯" image:@"information_select"],
                       [ZNMentItemModel initWithTitle:@"资讯" image:@"information_select"],
                       [ZNMentItemModel initWithTitle:@"资讯" image:@"information_select"],
                       [ZNMentItemModel initWithTitle:@"资讯" image:@"information_select"],
                       [ZNMentItemModel initWithTitle:@"资讯" image:@"information_select"]
                       ];
    }
    return _menuItems;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ZNMenuCollectViewCell class] forCellWithReuseIdentifier:[ZNMenuCollectViewCell idString]];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [UICollectionViewFlowLayout new];
        CGFloat width = screenWidth/4 - 1;
        _flowLayout.itemSize = CGSizeMake(width, width);
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}

@end

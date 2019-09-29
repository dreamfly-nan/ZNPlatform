//
//  ZNImageLookViewController.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/12.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNImageLookViewController.h"
#import "ZNImageLookViewManager.h"
#import "ZNImageLookCollectionViewCell.h"

@interface ZNImageLookViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property(nonatomic,strong) UICollectionView * collectionView;

@property(nonatomic,strong) UICollectionViewFlowLayout * flowLayout;

@property(nonatomic,strong) UILabel * pageNumberLabel;

@property(nonatomic,strong) ZNImageLookViewManager * manager;

//保存初始化的页码
@property(nonatomic,assign) int initPageNumber;

//有进行设置初始化的页码
@property(nonatomic,assign) BOOL isInitPageNumber;

@end

@implementation ZNImageLookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setInitUI];
    [self setBangding];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //因为在首次初始化会进行调用scrollViewDidScroll，导致self.manager.currentNumber被重置，所以需要在这里进行初始化位置
    if (self.isInitPageNumber) {
        self.manager.currentNumber = self.initPageNumber;
        NSIndexPath * path = [NSIndexPath indexPathForRow:self.manager.currentNumber inSection:0];
        [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
    }
}

- (void)setInitUI{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.pageNumberLabel];
    self.pageNumberLabel.sd_layout
    .bottomSpaceToView(self.view, zn_AutoWidth(50))
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(zn_AutoWidth(20));
}

- (void)setBangding{
    znWeakSelf(self)
    [RACObserve(self.manager, currentNumber) subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        if (weakSelf.manager.imageModels.count > weakSelf.manager.currentNumber && weakSelf.manager.currentNumber >= 0) {
            weakSelf.pageNumberLabel.text = [NSString stringWithFormat:@"%d/%ld",weakSelf.manager.currentNumber+1,weakSelf.manager.imageModels.count];
        }
    }];
}

#pragma mark - public

- (void)setImages:(NSArray<UIImage*> *) images{
    [self.manager setImages:images];
    
}

- (void)setImageUrls:(NSArray<NSString*> *) imageUrls{
    [self.manager setImageUrls:imageUrls];
}

- (void)addImageWithModel:(ZNImageLookModel*) imageModel{
    [self.manager.imageModels addObject:imageModel];
}

/**
 设置当前的页码
 @param numebr <#numebr description#>
 */
- (void)setCurrentpageNumber:(int) numebr{
    self.initPageNumber = numebr;
    self.isInitPageNumber = YES;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.manager.imageModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZNImageLookCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ZNImageLookCollectionViewCell idString] forIndexPath:indexPath];
    cell.model = self.manager.imageModels[indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    int number = (point.x + self.collectionView.width/2)/self.collectionView.width;
    if(self.manager.currentNumber != number){
        self.manager.currentNumber = number;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(screenWidth,self.collectionView.bounds.size.height);
}

#pragma mark - get

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        _collectionView.height = _collectionView.height - self.navigationController.navigationBar.height;
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollsToTop = NO;
        _collectionView.bounces = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[ZNImageLookCollectionViewCell class] forCellWithReuseIdentifier:[ZNImageLookCollectionViewCell idString]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumLineSpacing = 0;
    }
    return _flowLayout;
}

- (UILabel *)pageNumberLabel{
    if (!_pageNumberLabel) {
        _pageNumberLabel = [UILabel new];
        _pageNumberLabel.font = zn_font(15);
        _pageNumberLabel.textAlignment = NSTextAlignmentCenter;
        _pageNumberLabel.textColor = [UIColor whiteColor];
    }
    return _pageNumberLabel;
}

- (ZNImageLookViewManager *)manager{
    if (!_manager) {
        _manager = [ZNImageLookViewManager new];
    }
    return _manager;
}

@end

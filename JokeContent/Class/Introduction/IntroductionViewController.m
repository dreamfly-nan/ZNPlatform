//
//  IntroductionViewController.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/5/2.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "IntroductionViewController.h"
#import "IntroductionCollectionViewCell.h"

@interface IntroductionViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView * collectionView;

@property (nonatomic , strong) UICollectionViewFlowLayout * flowLayout;

//简介图
@property (nonatomic , strong) NSArray<NSString*> *imageArrs;

@end

@implementation IntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setInitUI];
    // Do any additional setup after loading the view.
}

- (void)setInitUI{
    [self.view addSubview:self.collectionView];
    self.collectionView.sd_layout
    .topEqualToView(self.view)
    .bottomEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view);
}

#pragma mark - UICollectionViewDelegate

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    IntroductionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[IntroductionCollectionViewCell idString] forIndexPath:indexPath];
    cell.imageUrl = self.imageArrs[indexPath.row];
    if (indexPath.row == self.imageArrs.count - 1) {
        cell.functionBtn.hidden = NO;
//        znWeakSelf(self)
        cell.btnBlock = ^(UIButton * _Nonnull btn) {
            [UIApplication sharedApplication].delegate.window.rootViewController = [[RPNavigationController alloc] initWithRootViewController:[RPBaceTabBarController new]];
        };
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArrs.count;
}

#pragma mark - get

- (NSArray<NSString *> *)imageArrs{
    if (!_imageArrs) {
        _imageArrs = @[];
    }
    return _imageArrs;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) collectionViewLayout:self.flowLayout];
        [_collectionView registerClass:[IntroductionCollectionViewCell class] forCellWithReuseIdentifier:[IntroductionCollectionViewCell idString]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}

@end

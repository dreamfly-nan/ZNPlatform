//
//  RPMyselfViewModel.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPMyselfViewModel.h"
#import "RPMyItemCollectionViewCell.h"
#import "RPRpView.h"
#import "WSLNativeScanTool.h"

@interface RPMyselfViewModel()

@property (nonatomic , strong) UIScrollView *contentScrollView;

@property (nonatomic , strong) UICollectionViewFlowLayout *flowLayout;

//二维码的展示
@property(nonatomic,strong) RPRpView * rpView;

@property (nonatomic , assign) CGFloat itemWidth;

@end

@implementation RPMyselfViewModel

- (void)setupInitUI{
    [self.viewController.view addSubview:self.contentScrollView];
    [self.contentScrollView addSubview:self.headView];
    [self.contentScrollView addSubview:self.collectinView];
    
    self.collectinView.sd_layout
    .topSpaceToView(self.headView, 0)
    .leftEqualToView(self.contentScrollView)
    .rightEqualToView(self.contentScrollView)
    .heightIs(self.itemWidth * 2 + zn_AutoWidth(1) + zn_AutoHeight(7));
}

#pragma mark -----------get------------

- (CGFloat)itemWidth{
    return (screenWidth - zn_AutoWidth(1)) / 3 - 1;
}

- (RPRpView *)rpView{
    if (!_rpView) {
        _rpView = [RPRpView new];
    }
    return _rpView;
}

- (UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, znStateHeight + [RPConfig sharedInstance].navigationHeight, screenWidth, screenHeight)];
    }
    return _contentScrollView;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake(self.itemWidth, self.itemWidth);
        _flowLayout.minimumLineSpacing = zn_AutoWidth(1);
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}

- (UICollectionView *)collectinView{
    if (!_collectinView) {
        _collectinView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectinView.backgroundColor = Big_background_Color();
        [_collectinView registerClass:[RPMyItemCollectionViewCell class] forCellWithReuseIdentifier:[RPMyItemCollectionViewCell idString]];
        _collectinView.delegate = self.viewController;
        _collectinView.dataSource = self.viewController;
        _collectinView.scrollEnabled = NO;
        _collectinView.contentInset = UIEdgeInsetsMake(zn_AutoHeight(5), 0, 1, 0);
    }
    return _collectinView;
}

- (RPHeadIconView *)headView{
    if (!_headView) {
        _headView = [[RPHeadIconView alloc] init];
        znWeakSelf(self)
        [[_headView.rpBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            znStrongSelf
            NSString * userId = [RPConfig sharedInstance].userData.objectId;
            UIImage * image =  [WSLNativeScanTool createQRCodeImageWithString:userId andSize:CGSizeMake(zn_AutoWidth(200), zn_AutoWidth(200)) andBackColor:[UIColor whiteColor] andFrontColor:Title_Color() andCenterImage:weakSelf.headView.iconImage.image];
            weakSelf.rpView.rpImage = image;
            [weakSelf.rpView show:weakSelf.viewController.view];
        }];
    }
    return _headView;
}

@end

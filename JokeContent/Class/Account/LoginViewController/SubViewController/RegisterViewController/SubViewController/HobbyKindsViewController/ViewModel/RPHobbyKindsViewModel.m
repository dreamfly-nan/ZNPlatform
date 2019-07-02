//
//  RPHobbyKindsViewModel.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/24.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPHobbyKindsViewModel.h"
#import "RPKindCollectionViewCell.h"
@interface RPHobbyKindsViewModel()

@property (nonatomic , assign) CGFloat itemSize;

@end

@implementation RPHobbyKindsViewModel

- (void)setUpInitUI{
    [self.controller.view addSubview:self.collectionView];
    self.controller.view.backgroundColor = [UIColor whiteColor];
    [self.controller.view addSubview:self.nextBtn];
    
    znWeakSelf(self)
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        znStrongSelf
        make.bottom.equalTo(weakSelf.controller.view).offset(zn_AutoWidth(-52));
        make.left.equalTo(weakSelf.controller.view).offset(zn_AutoWidth(25));
        make.right.equalTo(weakSelf.controller.view).offset(zn_AutoWidth(-25));
        make.height.mas_equalTo(zn_AutoHeight(35));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        znStrongSelf
        make.left.equalTo(weakSelf.controller.view).offset(zn_AutoWidth(30));
        make.right.equalTo(weakSelf.controller.view).offset(zn_AutoWidth(-30));
        make.top.equalTo(weakSelf.controller.view).offset(zn_AutoHeight(80));
        make.bottom.equalTo(weakSelf.nextBtn.mas_top).offset(zn_AutoHeight(- 80));
    }];
}

#pragma mark ------------get-----------

- (UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [UIButton new];
        _nextBtn.backgroundColor = Main_Color();
        _nextBtn.layer.cornerRadius = zn_AutoWidth(5);
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = zn_font(15);
    }
    return _nextBtn;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if(!_flowLayout){
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat widht = (screenWidth - zn_AutoWidth(60)) / 3;
        _flowLayout.itemSize = CGSizeMake(widht, widht);
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.minimumInteritemSpacing = 0;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self.controller;
        _collectionView.delegate = self.controller;
        [_collectionView registerClass:[RPKindCollectionViewCell class] forCellWithReuseIdentifier:[RPKindCollectionViewCell idString]];
    }
    return _collectionView;
}


@end

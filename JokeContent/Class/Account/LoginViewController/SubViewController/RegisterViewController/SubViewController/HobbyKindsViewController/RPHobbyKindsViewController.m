//
//  RPHobbyKindsViewController.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/24.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPHobbyKindsViewController.h"
#import "RPHobbyKindsDataModel.h"
#import "RPHobbyKindsViewModel.h"
#import "RPKindCollectionViewCell.h"

@interface RPHobbyKindsViewController ()


@property (nonatomic, strong) RPHobbyKindsDataModel *datamodel;

@property (nonatomic , strong) RPHobbyKindsViewModel *viewmodel;

@end

@implementation RPHobbyKindsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.viewmodel setUpInitUI];
    [self setBingding];
    // Do any additional setup after loading the view.
}

- (void)setBingding{
    [MBProgressHUD zn_showMessage:@""];
    znWeakSelf(self)
    //关注
    [self.datamodel.attentionKindsCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       znStrongSelf
        [MBProgressHUD zn_hideHUD];
        if ([x[0] boolValue]) {
            
        }else{
            
        }
    }];
    
    [[self.viewmodel.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        [weakSelf.datamodel.attentionKindsCommand execute:nil];
    }];
    
    [self.datamodel.kindsCommand execute:nil];
    
}

#pragma mark -------UICollectionViewDelegate----------

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.datamodel.items[indexPath.row].isSelect = !self.datamodel.items[indexPath.row].isSelect;
    [self.viewmodel.collectionView reloadData];
}

#pragma mark --------UICollectionViewDataSource----------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datamodel.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RPKindCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[RPKindCollectionViewCell idString] forIndexPath:indexPath];
    cell.model = self.datamodel.items[indexPath.row];
    return cell;
}

#pragma mark -------get---------

- (RPHobbyKindsViewModel *)viewmodel{
    if (!_viewmodel) {
        _viewmodel = [RPHobbyKindsViewModel new];
        _viewmodel.controller = self;
    }
    return _viewmodel;
}

- (RPHobbyKindsDataModel *)datamodel{
    if (!_datamodel) {
        _datamodel = [RPHobbyKindsDataModel new];
    }
    return _datamodel;
}

@end

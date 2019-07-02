//
//  RPMyselfViewModel.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaseObject.h"
#import "RPMyselfViewController.h"
#import "RPHeadIconView.h"
#import "RPMyselfDataModel.h"
#import "RPMyItemModel.h"

@interface RPMyselfViewModel : RPBaseObject

@property (nonatomic , weak) RPMyselfViewController *viewController;

@property (nonatomic , strong) RPMyselfDataModel *dataModel;

@property (nonatomic , strong) UICollectionView *collectinView;

//头部
@property (nonatomic , strong) RPHeadIconView *headView;

- (void)setupInitUI;

@end

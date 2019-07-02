//
//  RPHobbyKindsViewModel.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/24.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaseObject.h"
#import "RPHobbyKindsViewController.h"
#import <UIKit/UIKit.h>

@interface RPHobbyKindsViewModel : RPBaseObject

@property (nonatomic , strong) UICollectionView *collectionView;

@property (nonatomic , strong) UICollectionViewFlowLayout * flowLayout;

@property (nonatomic , strong) UIButton *nextBtn;

@property (nonatomic , weak) RPHobbyKindsViewController * controller;

- (void)setUpInitUI;

@end

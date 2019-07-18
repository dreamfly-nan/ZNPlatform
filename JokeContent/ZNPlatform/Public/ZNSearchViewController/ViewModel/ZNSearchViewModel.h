//
//  ZNSearchViewModel.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/18.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZNSearchBarView.h"
#import "ZNSearchViewController.h"
#import "ZNSearchHistoryItemCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZNSearchViewModel : NSObject

@property(nonatomic,weak) ZNSearchViewController * controller;

/**
 历史记录的标题
 */
@property(nonatomic,strong) UILabel * historyLabel;

/**
 历史记录
 */
@property(nonatomic,strong) UICollectionView * historyCollectionView;

/**
 检索框
 */
@property(nonatomic,strong) ZNSearchBarView * searchBarView;

/**
 history 删除键
 */
@property(nonatomic,strong) UIButton * deleteBtn;

- (void)setInitUI;

@end

NS_ASSUME_NONNULL_END

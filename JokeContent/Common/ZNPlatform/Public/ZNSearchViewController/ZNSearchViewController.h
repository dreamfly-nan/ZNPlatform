//
//  ZNSearchViewController.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/18.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZNSearchViewController;
NS_ASSUME_NONNULL_BEGIN

@protocol ZNSearchViewDelegate <NSObject>
@optional
/**
 开始检索

 @param text 检索的内容
 @param controller 检索的控制器
 */
- (void)searchWithStr:(NSString *) text controller:(ZNSearchViewController *) controller;

/**
 删除查找历史
 @param history 历史记录
 */
- (void)deleteHistory:(NSArray *) history;

@end

@interface ZNSearchViewController : ZNBaseViewController
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property(nonatomic,weak) id<ZNSearchViewDelegate> znDelegate;

//推荐
@property (nonatomic , strong) NSArray<NSString *> * recommends;

/// 检索历史记录默认为八个
@property (nonatomic , assign) int history;

@end

NS_ASSUME_NONNULL_END

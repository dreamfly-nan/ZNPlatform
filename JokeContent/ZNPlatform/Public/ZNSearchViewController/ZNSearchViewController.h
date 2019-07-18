//
//  ZNSearchViewController.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/18.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZNSearchViewDelegate <NSObject>

/**
 开始检索

 @param text 检索的内容
 */
- (void)searchWithStr:(NSString *) text;

/**
 删除查找历史
 @param history
 */
- (void)deleteHistory:(NSArray *) history;

@end

@interface ZNSearchViewController : UIViewController
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property(nonatomic,weak) id<ZNSearchViewDelegate> znDelegate;

@end

NS_ASSUME_NONNULL_END

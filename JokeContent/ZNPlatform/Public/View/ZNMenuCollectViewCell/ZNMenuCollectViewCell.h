//
//  ZNMenuCollectViewCell.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/8.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNBaseCollectionViewCell.h"
#import "ZNMentItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZNMenuCollectViewCell : ZNBaseCollectionViewCell

@property(nonatomic,strong) ZNMentItemModel * model;

@end

NS_ASSUME_NONNULL_END

//
//  ZNTextFieldTableViewCell.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/1.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNBaseTableViewCell.h"
#import "ZNTextCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZNTextFieldTableViewCell : ZNBaseTableViewCell

@property(nonatomic,strong) ZNTextCellModel * model;

@property(nonatomic,strong) UIImageView * arrowImageView;

@property(nonatomic,strong) UIView * lineView;

@property(nonatomic,strong) UILabel * titleLabel;

@property(nonatomic,strong) UITextField * contentField;

/**
 设置布局，如有需要可自己重写
 return 是否经过重写
 */
- (BOOL) setUILayout;

@end

NS_ASSUME_NONNULL_END

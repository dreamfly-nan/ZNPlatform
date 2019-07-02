//
//  ZNNoNetWorkView.h
//  JokeContent
//
//  Created by 南木南木 on 2019/6/26.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZNNoNetWorkView : UIView

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , copy) void (^reloadBlock)(void);

+ (instancetype)createRPNoNetView;

@end

NS_ASSUME_NONNULL_END

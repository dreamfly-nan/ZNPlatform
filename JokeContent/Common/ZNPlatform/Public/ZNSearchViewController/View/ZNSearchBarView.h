//
//  ZNSearchBarView.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/18.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNTextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZNSearchBarView : UIView

@property(nonatomic,assign) CGFloat leftSpace;

@property(nonatomic,assign) CGFloat rightSpace;

@property(nonatomic,strong) UIButton * backBtn;

@property(nonatomic,strong) ZNTextField * searchText;

/**
 点击返回按键的时候执行
 */
@property (copy , nonatomic) void (^backBlock)(void);

/**
 检索执行
 */
@property (copy , nonatomic) void (^searchBlock)(NSString * searchText);

@end

NS_ASSUME_NONNULL_END

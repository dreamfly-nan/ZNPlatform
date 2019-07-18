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

@property(nonatomic,strong) ZNTextField * searchText;

/**
 点击取消按键的时候执行
 */
@property (copy , nonatomic) void (^backBlock)(void);

@end

NS_ASSUME_NONNULL_END

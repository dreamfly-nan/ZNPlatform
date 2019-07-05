//
//  ZNTextField.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/5.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZNTextField : UIView

/**
 输入框距离左边的距离
 */
@property (nonatomic , assign) CGFloat left_distance;
/**
 输入框距离右边的距离
 */
@property (nonatomic , assign) CGFloat right_distance;

/**
 图片距离输入框的距离
 */
@property(nonatomic,assign) CGFloat imageSpace;

/**
 是否存在左边的视图
 */
@property(nonatomic,assign) BOOL isLeftView;

@end

NS_ASSUME_NONNULL_END

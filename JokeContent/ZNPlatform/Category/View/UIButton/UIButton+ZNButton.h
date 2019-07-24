//
//  UIButton+ZNButton.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/18.
//  Copyright © 2019 南木南木. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIButton (ZNButton)

/**
 扩展的点击宽度
 */
@property(nonatomic,assign)CGFloat expandWidth;

/**
 设置按钮上的图片是否自动跟随按键主题色
 */
@property(nonatomic,assign) BOOL autoImageTinkColor;

/**
 扩展的点击宽度
 */
- (UIButton * (^)(CGFloat expandWidth))zn_expandWidth;

@end

NS_ASSUME_NONNULL_END

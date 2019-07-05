//
//  UIView+ZNCreate.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/4.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZNCreate)

+ (instancetype)zn_create;

- (UIView * (^)(UIColor * color))zn_backgroundColor;

- (UIView * (^)(UIColor * color))zn_layerColor;

- (UIView * (^)(UIColor * color))zn_borderColor;

- (UIView * (^)(CGFloat width))zn_borderWidth;

- (UIView * (^)(CGFloat cornerRadius))zn_cornerRadius;

/**
 根据颜色生成view

 @param color <#color description#>
 @return <#return value description#>
 */
+ (instancetype) zn_createWithColor:(UIColor *) color;

@end

NS_ASSUME_NONNULL_END

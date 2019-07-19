//
//  UIButton+ZNCreate.h
//  JokeContent
//  默认为UIControlStateNormal状态
//  Created by 南木南木 on 2019/7/4.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (ZNCreate)

+ (UIButton * _Nonnull (^)(NSString * title,UIControlState state))zn_createTitle;

- (UIButton * (^)(NSString * title,UIControlState state))zn_title;

- (UIButton * (^)(UIColor * color,UIControlState state))zn_titleColor;

- (UIButton * (^)(UIFont * font))zn_font;

- (UIButton * (^)(UIImage * image,UIControlState state))zn_backgroundImage;

- (UIButton * (^)(UIImage * image,UIControlState state))zn_image;

- (UIButton * (^)(UIViewContentMode mode))zn_ImageContentMode;

/**
 根据标题初始化,默认为UIControlStateNormal状态

 @param title <#title description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithTitle:(NSString *) title;

/**
 根据标题,状态初始化
 
 @param title <#title description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithTitle:(NSString *) title
                             state:(UIControlState) state;

/**
 根据标题和标题颜色初始化

 @param title <#title description#>
 @param titleColor <#titleColor description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithTitle:(NSString *) title
                        titleColor:(UIColor *)titleColor;

/**
  根据标题和标题颜色,字体初始化

 @param title <#title description#>
 @param titleColor <#titleColor description#>
 @param font <#font description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithTitle:(NSString *) title
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *) font;

/**
 根据标题，标题颜色，事件状态来初始化

 @param title <#title description#>
 @param titleColor <#titleColor description#>
 @param state <#state description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithTitle:(NSString *) title
                        titleColor:(UIColor *)titleColor
                             state:(UIControlState) state;

/**
 根据标题，标题颜色，事件状态来初始化
 
 @param title <#title description#>
 @param titleColor <#titleColor description#>
 @param state <#state description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithTitle:(NSString *) title
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *) font
                             state:(UIControlState) state;

/**
  根据标题，标题颜色，事件状态，背景颜色来初始化

 @param title <#title description#>
 @param titleColor <#titleColor description#>
 @param state <#state description#>
 @param color <#color description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithTitle:(NSString *) title
                        titleColor:(UIColor *)titleColor
                             state:(UIControlState) state
                   backgroundColor:(UIColor *) color;

/**
  根据标题，标题颜色，事件状态，背景图片来初始化

 @param title <#title description#>
 @param titleColor <#titleColor description#>
 @param state <#state description#>
 @param image <#image description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithTitle:(NSString *) title
                        titleColor:(UIColor *)titleColor
                             state:(UIControlState) state
                   backgroundImage:(UIImage *) image;

@end

NS_ASSUME_NONNULL_END

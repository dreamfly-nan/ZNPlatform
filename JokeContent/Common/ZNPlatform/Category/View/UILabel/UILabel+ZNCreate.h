//
//  UILabel+ZNCreate.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/4.
//  Copyright © 2019 南木南木. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (ZNCreate)

/**
 设置文本显示模式
 */
- (UILabel * (^)(NSTextAlignment alignment))zn_alignment;

/**
 设置文本颜色
 */
- (UILabel * (^)(UIColor * textColor))zn_textColor;

/**
 设置文本字体
 */
- (UILabel* (^)(UIFont * font))zn_font;

/**
 设置文本
 */
- (UILabel * (^)(NSString * text))zn_text;

/**
 设置行数
 */
- (UILabel * (^)(NSInteger numberOfLines))zn_numberOfLines;


/**
 便捷构造器

 @param text 文本
 @param font 文本字体
 @param textColor 文本颜色
 @param backgroundColor 背景颜色
 @return 实例
 */
+ (UILabel *) zn_createWithText:(NSString *) text
                           font:(UIFont *) font
                      textColor:(UIColor *) textColor
                backgroundColor:(UIColor* ) backgroundColor;

/**
 便捷构造器

 @param text 文本
 @param font 文本字体
 @param textColor 文本颜色
 @return 实例
 */
+ (UILabel *) zn_createWithText:(NSString *) text
                           font:(UIFont *) font
                      textColor:(UIColor *) textColor;

/**
 <#Description#>
 @param font 文本字体
 @param textColor 文本颜色
 @return 实例
 */
+ (UILabel *) zn_createWithFont:(UIFont *) font
                      textColor:(UIColor *) textColor;

/**
 便捷构造器
 @param text 文本
 @return 实例
 */
+ (UILabel *) zn_createWithText:(NSString *) text;

@end

NS_ASSUME_NONNULL_END

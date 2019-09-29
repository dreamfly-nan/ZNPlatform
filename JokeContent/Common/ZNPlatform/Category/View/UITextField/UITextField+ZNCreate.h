//
//  UITextField+ZNCreate.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/4.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (ZNCreate)

/**
 设置字体
 */
- (UITextField * (^)(UIFont * font))zn_font;

/**
 设置字体颜色
 */
- (UITextField * (^)(UIColor * color))zn_textColor;

/**
 设置显示文本
 */
- (UITextField *(^)(NSString * text))zn_text;

/**
 设置占位符
 */
- (UITextField *(^)(NSString * placeStr))zn_place;

/**
 设置文本显示模式
 */
- (UITextField *(^)(NSTextAlignment alignment))zn_alignment;

/**
 根据字体，字体颜色初始化

 @param font <#font description#>
 @param color <#color description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithFont:(UIFont *) font
                        textColor:(UIColor *) color;

/**
 根据字体，字体颜色，文本排布初始化
 
 @param font <#font description#>
 @param color <#color description#>
 @parem alignment 文本排布
 @return <#return value description#>
 */
+ (instancetype)zn_createWithFont:(UIFont *) font
                        textColor:(UIColor *) color
                        alignment:(NSTextAlignment) alignment;

/**
  根据字体，字体颜色，文本初始化

 @param font <#font description#>
 @param color <#color description#>
 @param text <#text description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithFont:(UIFont *) font
                        textColor:(UIColor *) color
                             text:(NSString *) text;

/**
  根据字体，字体颜色，占位符初始化

 @param font <#font description#>
 @param color <#color description#>
 @param placeStr <#placeStr description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithFont:(UIFont *) font
                        textColor:(UIColor *) color
                         placeStr:(NSString *) placeStr;

/**
  根据字体，字体颜色，占位符，文本初始化

 @param font <#font description#>
 @param color <#color description#>
 @param text <#text description#>
 @param placeStr <#placeStr description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithFont:(UIFont *) font
                        textColor:(UIColor *) color
                             text:(NSString *) text
                         placeStr:(NSString *) placeStr;

@end

NS_ASSUME_NONNULL_END

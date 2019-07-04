//
//  UITextField+ZNCreate.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/4.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "UITextField+ZNCreate.h"

@implementation UITextField (ZNCreate)

- (UITextField * (^)(UIFont * font))zn_font{
    return ^(UIFont * font){
        self.font = font;
        return self;
    };
}

- (UITextField * (^)(UIColor * color))zn_textColor{
    return ^(UIColor * color){
        self.textColor = color;
        return self;
    };
}

- (UITextField *(^)(NSString * text))zn_text{
    return ^(NSString * text){
        self.text = text;
        return self;
    };
}

- (UITextField *(^)(NSString * placeStr))zn_place{
    return ^(NSString * placeStr){
        self.placeholder = placeStr;
        return self;
    };
}

- (UITextField *(^)(NSTextAlignment alignment))zn_alignment{
    return ^(NSTextAlignment alignment){
        self.textAlignment = alignment;
        return self;
    };
}

/**
 根据字体，字体颜色初始化
 
 @param font <#font description#>
 @param color <#color description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithFont:(UIFont *) font
                        textColor:(UIColor *) color{
    UITextField * textField = [UITextField new];
    textField.font = font;
    textField.textColor = color;
    return textField;
}

/**
 根据字体，字体颜色，文本排布初始化
 
 @param font <#font description#>
 @param color <#color description#>
 @parem alignment 文本排布
 @return <#return value description#>
 */
+ (instancetype)zn_createWithFont:(UIFont *) font
                        textColor:(UIColor *) color
                        alignment:(NSTextAlignment) alignment{
    UITextField * textField = [self zn_createWithFont:font textColor:color];
    textField.textAlignment = alignment;
    return textField;
}

/**
 根据字体，字体颜色，文本初始化
 
 @param font <#font description#>
 @param color <#color description#>
 @param text <#text description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithFont:(UIFont *) font
                        textColor:(UIColor *) color
                             text:(NSString *) text{
    UITextField * textField = [self zn_createWithFont:font textColor:color];
    textField.text = text;
    return textField;
}

/**
 根据字体，字体颜色，占位符初始化
 
 @param font <#font description#>
 @param color <#color description#>
 @param placeStr <#placeStr description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithFont:(UIFont *) font
                        textColor:(UIColor *) color
                         placeStr:(NSString *) placeStr{
    UITextField * textField = [self zn_createWithFont:font textColor:color];
    textField.placeholder = placeStr;
    return textField;
}

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
                         placeStr:(NSString *) placeStr{
    UITextField * textField = [self zn_createWithFont:font textColor:color text:text];
    textField.placeholder = placeStr;
    return textField;
}

@end

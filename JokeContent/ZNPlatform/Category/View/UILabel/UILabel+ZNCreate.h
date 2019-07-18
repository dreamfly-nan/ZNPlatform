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

- (UILabel * (^)(NSTextAlignment alignment))zn_alignment;

- (UILabel * (^)(UIColor * textColor))zn_textColor;

- (UILabel* (^)(UIFont * font))zn_font;

- (UILabel * (^)(NSString * text))zn_text;


+ (UILabel *) zn_createWithText:(NSString *) text
                           font:(UIFont *) font
                      textColor:(UIColor *) textColor
                backgroundColor:(UIColor* ) backgroundColor;

+ (UILabel *) zn_createWithText:(NSString *) text
                           font:(UIFont *) font
                      textColor:(UIColor *) textColor;

+ (UILabel *) zn_createWithText:(NSString *) text;

@end

NS_ASSUME_NONNULL_END

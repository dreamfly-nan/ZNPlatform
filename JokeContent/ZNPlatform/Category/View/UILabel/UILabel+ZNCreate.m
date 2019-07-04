//
//  UILabel+ZNCreate.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/4.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "UILabel+ZNCreate.h"

@implementation UILabel (ZNCreate)

+ (UILabel *)zn_create{
    return [UILabel new];
}

- (UILabel * (^)(NSTextAlignment alignment))zn_alignment{
    return ^ (NSTextAlignment alignment){
        self.textAlignment = alignment;
        return self;
    };
}

- (UILabel * (^)(UIColor * textColor))zn_textColor{
    return ^ (UIColor * textColor){
        self.textColor = textColor;
        return self;
    };
}

- (UILabel* (^)(UIFont * font))zn_font{
    return ^(UIFont * font){
        self.font = font;
        return self;
    };
}

+ (UILabel *) zn_createWithText:(NSString *) text{
    UILabel * label = [UILabel new];
    label.text = text;
    return label;
}

+ (UILabel *) zn_createWithText:(NSString *) text
                           font:(UIFont *) font
                      textColor:(UIColor *) textColor{
    UILabel * label = [self zn_createWithText:text];
    if (font) {
        label.font = font;
    }
    
    if (textColor) {
        label.textColor = textColor;
    }
    
    return label;
}

+ (UILabel *) zn_createWithText:(NSString *) text
                           font:(UIFont *) font
                      textColor:(UIColor *) textColor
                backgroundColor:(UIColor*) backgroundColor{
    UILabel * label = [self zn_createWithText:text font:font textColor:textColor];
    label.backgroundColor = backgroundColor;
    return label;
}



@end

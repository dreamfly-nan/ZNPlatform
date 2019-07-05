//
//  UITextView+ZNCreate.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/5.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "UITextView+ZNCreate.h"

@implementation UITextView (ZNCreate)

- (UITextView * (^)(NSString * text))zn_text{
    return ^(NSString * text){
        self.text = text;
        return self;
    };
}

- (UITextView * (^)(UIFont * font))zn_font{
    return ^(UIFont * font){
        self.font = font;
        return self;
    };
}

- (UITextView * (^)(UIColor * textColor))zn_textColor{
    return ^(UIColor * textColor){
        self.textColor = textColor;
        return self;
    };
}

- (UITextView * (^)(NSTextAlignment alignment))zn_alignment{
    return ^(NSTextAlignment alignment){
        self.textAlignment = alignment;
        return self;
    };
}

@end

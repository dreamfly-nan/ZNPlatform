//
//  UITextView+ZNCreate.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/5.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (ZNCreate)

- (UITextView * (^)(NSString * text))zn_text;

- (UITextView * (^)(UIFont * font))zn_font;

- (UITextView * (^)(UIColor * textColor))zn_textColor;

- (UITextView * (^)(NSTextAlignment alignment))zn_alignment;

@end

NS_ASSUME_NONNULL_END

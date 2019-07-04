//
//  UIButton+ZNCreate.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/4.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "UIButton+ZNCreate.h"

@implementation UIButton (ZNCreate)

+ (UIButton * (^)(NSString * title,UIControlState state))zn_createTitle{
    return ^(NSString * title,UIControlState state){
        return [UIButton zn_createWithTitle:title state:state];
    };
}

- (UIButton * (^)(NSString * title,UIControlState state))zn_title{
    return ^(NSString * title,UIControlState state){
        [self setTitle:title forState:state];
        return self;
    };
}

- (UIButton * (^)(UIColor * color,UIControlState state))zn_titleColor{
    return ^(UIColor * color,UIControlState state){
        [self setTitleColor:color forState:state];
        return self;
    };
}

- (UIButton * (^)(UIFont * font))zn_font{
    return ^(UIFont * font){
        self.titleLabel.font = font;
        return self;
    };
}

- (UIButton * (^)(UIImage * image,UIControlState state))zn_backgroundImage{
    return ^(UIImage * image,UIControlState state){
        [self setBackgroundImage:image forState:state];
        return self;
    };
}

- (UIButton * (^)(UIColor * color))zn_backgroundColor{
    return ^(UIColor * color){
        self.backgroundColor = color;
        return self;
    };
}

/**
 根据标题,状态初始化
 
 @param title <#title description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithTitle:(NSString *) title
                             state:(UIControlState) state{
    UIButton * btn = [UIButton new];
    [btn setTitle:title forState:state];
    return btn;
}

/**
 根据标题初始化
 
 @param title <#title description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithTitle:(NSString *) title{
    return [self zn_createWithTitle:title state:UIControlStateNormal];
}

/**
 根据标题和标题颜色初始化
 
 @param title <#title description#>
 @param titleColor <#titleColor description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithTitle:(NSString *) title
                        titleColor:(UIColor *)titleColor{
    UIButton * btn = [self zn_createWithTitle:title];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    return btn;
}

/**
 根据标题和标题颜色,字体初始化
 
 @param title <#title description#>
 @param titleColor <#titleColor description#>
 @param font <#font description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithTitle:(NSString *) title
                        titleColor:(UIColor *)titleColor
                              font:(UIFont *) font{
    UIButton * btn = [self zn_createWithTitle:title titleColor:titleColor];
    btn.titleLabel.font = font;
    return btn;
}

/**
 根据标题，标题颜色，事件状态来初始化
 
 @param title <#title description#>
 @param titleColor <#titleColor description#>
 @param state <#state description#>
 @return <#return value description#>
 */
+ (instancetype)zn_createWithTitle:(NSString *) title
                        titleColor:(UIColor *)titleColor
                             state:(UIControlState) state{
    UIButton * btn = [UIButton new];
    [btn setTitle:title forState:state];
    [btn setTitleColor:titleColor forState:state];
    return btn;
}

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
                             state:(UIControlState) state{
    UIButton * btn = [self zn_createWithTitle:title titleColor:titleColor state:state];
    btn.titleLabel.font = font;
    return btn;
}

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
                   backgroundColor:(UIColor *) color{
    UIButton * btn = [self zn_createWithTitle:title titleColor:titleColor state:state];
    btn.backgroundColor = color;
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [btn setBackgroundImage:theImage forState:UIControlStateSelected];
    
    return btn;
}

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
                   backgroundImage:(UIImage *) image{
    UIButton * btn = [self zn_createWithTitle:title titleColor:titleColor state:state];
    [btn setImage:image forState:state];
    return btn;
}

@end

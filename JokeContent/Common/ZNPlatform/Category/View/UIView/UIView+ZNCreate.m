//
//  UIView+ZNCreate.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/4.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "UIView+ZNCreate.h"

@implementation UIView (ZNCreate)

+ (instancetype)zn_create{
    return [self new];
}

/**
 拷贝，并返回一个相同的对象
 */
+ (UIView * (^)(UIView * view))zn_copy{
    return ^(UIView * view){
        return [view copy];
    };
}

- (UIView * (^)(UIColor * color))zn_backgroundColor{
    return ^(UIColor * color){
        self.backgroundColor = color;
        return self;
    };
}

- (UIView * (^)(UIColor * color))zn_layerColor{
    return ^(UIColor * color){
        self.layer.backgroundColor = color.CGColor;
        return self;
    };
}

- (UIView * (^)(UIColor * color))zn_borderColor{
    return ^(UIColor * color){
        self.layer.borderColor = color.CGColor;
        return self;
    };
}

- (UIView * (^)(CGFloat width))zn_borderWidth{
    return ^(CGFloat width){
        self.layer.borderWidth = width;
        return self;
    };
}

- (UIView * (^)(CGFloat cornerRadius))zn_cornerRadius{
    return ^(CGFloat cornerRadius){
        self.layer.cornerRadius = cornerRadius;
        return self;
    };
}

/**
 设置view的frame
 */
- (UIView * (^)(CGRect frame))zn_SetFrame{
    return ^(CGRect frame){
        self.frame = frame;
        return self;
    };
}

/**
 设置x坐标
 */
- (UIView * (^)(CGFloat x))zn_SetX{
    return ^(CGFloat x){
        self.zn_x = x;
        return self;
    };
}

/**
 设置x坐标
 */
- (UIView * (^)(CGFloat y))zn_SetY{
    return ^(CGFloat y){
        self.zn_y = y;
        return self;
    };
}

/**
 设置坐标
 */
- (UIView * (^)(CGPoint point))zn_SetPoint{
    return ^(CGPoint point){
        self.zn_ponit = point;
        return self;
    };
}

/**
 设置大小
 */
- (UIView * (^)(CGSize size))zn_SetSize{
    return ^(CGSize size){
        self.zn_size = size;
        return self;
    };
}

/**
 根据颜色生成view
 
 @param color <#color description#>
 @return <#return value description#>
 */
+ (instancetype) zn_createWithColor:(UIColor *) color{
    UIView * view = [UIView new];
    view.backgroundColor = color;
    return view;
}

@end

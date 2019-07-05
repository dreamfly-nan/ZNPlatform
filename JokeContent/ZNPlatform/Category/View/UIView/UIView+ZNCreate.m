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

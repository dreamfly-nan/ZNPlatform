//
//  UIButton+ZNButton.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/18.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "UIButton+ZNButton.h"

@implementation UIButton (ZNButton)

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    //当前btn大小
    CGRect btnBounds = self.bounds;
    //扩大点击区域，想缩小就将-10设为正值
    btnBounds = CGRectInset(btnBounds, -zn_AutoWidth(self.expandWidth), -zn_AutoWidth(self.expandWidth));
    //若点击的点在新的bounds里，就返回YES
    return CGRectContainsPoint(btnBounds, point);
}

- (CGFloat)expandWidth{
   NSString * expand = objc_getAssociatedObject(self, _cmd);
    if (expand) {
        return [expand floatValue];
    }
    return 0;
}

- (void)setExpandWidth:(CGFloat)expandWidth{
    NSString * expand = [NSString stringWithFormat:@"%lf",expandWidth];
    objc_setAssociatedObject(self, @selector(expandWidth), expand, OBJC_ASSOCIATION_COPY);
}

@end

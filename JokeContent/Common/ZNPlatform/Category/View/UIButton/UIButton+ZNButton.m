//
//  UIButton+ZNButton.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/18.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "UIButton+ZNButton.h"

@implementation UIButton (ZNButton)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod([self class], @selector(setImage:forState:));
        Method replaceMethod = class_getInstanceMethod([self class], @selector(zn_setImage:forState:));
        method_exchangeImplementations(originalMethod, replaceMethod);
    });
}

- (void) zn_setImage:(UIImage *) image forState:(UIControlState) state{
    if (self.autoImageTinkColor) {
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    [self zn_setImage:image forState:state];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    //当前btn大小
    CGRect btnBounds = self.bounds;
    //扩大点击区域，想缩小就将-10设为正值
    btnBounds = CGRectInset(btnBounds, -zn_AutoWidth(self.expandWidth), -zn_AutoWidth(self.expandWidth));
    //若点击的点在新的bounds里，就返回YES
    return CGRectContainsPoint(btnBounds, point);
}

#pragma mark - get

- (CGFloat)expandWidth{
   NSString * expand = objc_getAssociatedObject(self, _cmd);
    if (expand) {
        return [expand floatValue];
    }
    return 0;
}

- (BOOL)autoImageTinkColor{
    id autoImage = objc_getAssociatedObject(self, _cmd);
    if (autoImage) {
        return [autoImage boolValue];
    }
    return NO;
}

#pragma mark - set


- (void)setExpandWidth:(CGFloat)expandWidth{
    NSString * expand = [NSString stringWithFormat:@"%lf",expandWidth];
    objc_setAssociatedObject(self, @selector(expandWidth), expand, OBJC_ASSOCIATION_COPY);
}

- (void)setAutoImageTinkColor:(BOOL)autoImageTinkColor{
    objc_setAssociatedObject(self, @selector(autoImageTinkColor), @(autoImageTinkColor), OBJC_ASSOCIATION_COPY);
}

@end

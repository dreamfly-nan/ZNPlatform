//
//  UIView+ZNView.m
//  TableViewCollectView
//
//  Created by 郑楠楠 on 2018/3/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "UIView+ZNView.h"
#import <objc/runtime.h>

@implementation UIView (ZNView)

#pragma mark - public

//这个方法转换出来的图片  文字图片会变模糊
- (UIImage *)zn_convertViewToImageVague{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//使用该方法不会模糊，根据屏幕密度计算
- (UIImage *)zn_convertViewToImage{
    UIImage *imageRet = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    UIGraphicsBeginImageContextWithOptions(self.frame.size, YES, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageRet;
}

- (CGRect)zn_screenRect{
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    CGRect rect = [self convertRect: self.bounds toView:window];
    return rect;
}

#pragma mark ------get-------

- (CGFloat)zn_x{
    return self.zn_ponit.x;
}

- (CGFloat)zn_y{
    return self.zn_ponit.y;
}

- (CGFloat)zn_width{
    return self.size.width;
}

- (CGFloat)zn_height{
    return self.size.height;
}

- (CGSize)zn_size{
    return self.frame.size;
}

- (CGPoint)zn_ponit{
    return self.frame.origin;
}

#pragma ------set-------

- (void)setZn_x:(CGFloat)zn_x{
    [self setZn_ponit:CGPointMake(zn_x, self.zn_ponit.y)];
}

- (void)setZn_y:(CGFloat)zn_y{
    [self setZn_ponit:CGPointMake(self.zn_ponit.x, zn_y)];
}

- (void)setZn_width:(CGFloat)zn_width{
    [self setZn_size:CGSizeMake(zn_width, self.zn_size.height)];
}

- (void)setZn_height:(CGFloat)zn_height{
    [self setZn_size:CGSizeMake(self.zn_size.width, zn_height)];
}

- (void)setZn_size:(CGSize)zn_size{
    CGRect rect = self.frame;
    rect.size = zn_size;
    self.frame = rect;
}

- (void)setZn_ponit:(CGPoint)zn_ponit{
    CGRect rect = self.frame;
    rect.origin = zn_ponit;
    self.frame = rect;
}

#pragma mark ------设置边框颜色，大小，视图背景，圆角--------

- (instancetype)zn_boradWidth:(CGFloat)width{
    [self.layer setBorderWidth:width];
    return self;
}

- (instancetype)zn_boradColor:(UIColor *)color{
    [self.layer setBorderColor:color.CGColor];
    return self;
}

- (instancetype)zn_boradCornerRadius:(CGFloat)cornerRadius{
    [self.layer setCornerRadius:cornerRadius];
    return self;
}

- (instancetype)zn_BackgroundColor:(UIColor *)color{
    [self setBackgroundColor:color];
    return self;
}

- (instancetype)zn_BezierRoundWithR:(CGFloat) r{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:r];
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.path = path.CGPath;
    self.layer.mask = layer;
    return self;
}

/**
 获取当前控制器
 
 @return <#return value description#>
 */
- (UIViewController *)zn_obtainController{
    for (UIView *next = self ; next ; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+ (instancetype)zn_getLineView{
    UIView *view = [UIView new];
    view.backgroundColor = Line_Color();
    return view;
}

@end

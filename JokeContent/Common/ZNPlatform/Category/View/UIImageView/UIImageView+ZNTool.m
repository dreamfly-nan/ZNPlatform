//
//  UIImageView+ZNTool.m
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2019/12/19.
//  Copyright © 2019 ttyx. All rights reserved.
//

#import "UIImageView+ZNTool.h"


@implementation UIImageView (ZNTool)

///imageView 圆角切圆角
+(UIImageView *)zn_pathImageView:(UIImageView *)imageView
                     connerRadii:(CGSize)connerRadii{
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:connerRadii];
     CAShapeLayer * maskLayer = [CAShapeLayer new];
     maskLayer.frame = imageView.bounds;
     maskLayer.path = maskPath.CGPath;
     imageView.layer.mask = maskLayer;
    return imageView;
}

@end

//
//  UIImageView+ZNTool.h
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2019/12/19.
//  Copyright © 2019 ttyx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//typedef NS_ENUM(NSInteger, DXRadianDirection) {
//    DXRadianDirectionBottom     = 0,
//    DXRadianDirectionTop        = 1,
//    DXRadianDirectionLeft       = 2,
//    DXRadianDirectionRight      = 3,
//};

@interface UIImageView (ZNTool)
//// 圆弧方向, 默认在下方
//@property (nonatomic) DXRadianDirection direction;
//// 圆弧半径
//@property (nonatomic) CGFloat radian;
///imageView 圆角切圆角
+(UIImageView *)zn_pathImageView:(UIImageView *)imageView
                     connerRadii:(CGSize)connerRadii;

@end

NS_ASSUME_NONNULL_END

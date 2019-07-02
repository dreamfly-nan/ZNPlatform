//
//  UIView+ZNView.h
//  TableViewCollectView
//
//  Created by 郑楠楠 on 2018/3/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZNView)

//位置大小获取设置
@property (assign , nonatomic) CGFloat zn_x;

@property (assign , nonatomic) CGFloat zn_y;

@property (assign , nonatomic) CGFloat zn_width;

@property (assign , nonatomic) CGFloat zn_height;

@property (assign , nonatomic) CGSize zn_size;

@property (assign , nonatomic) CGPoint zn_ponit;

//视图边框,背景设置
- (instancetype)zn_boradWidth:(CGFloat)width;
- (instancetype)zn_boradColor:(UIColor *)color;
- (instancetype)zn_boradCornerRadius:(CGFloat)cornerRadius;
- (instancetype)zn_BackgroundColor:(UIColor *)color;

/**
 使用这个方法获取到的截图，图片文字都会变模糊
 @return <#return value description#>
 */
- (UIImage *)zn_convertViewToImageVague;

/**
 使用该方法生成的图片不会模糊，根据屏幕密度计算
 @return <#return value description#>
 */
- (UIImage *)zn_convertViewToImage;

/**
 获取view相对屏幕的所在位置

 @return <#return value description#>
 */
- (CGRect)zn_screenRect;

/**
 使用贝塞尔曲线进行裁剪出圆形角

 @param r 圆的半径
 @return <#return value description#>
 */
- (instancetype)zn_BezierRoundWithR:(CGFloat) r;

/**
 获取当前控制器

 @return <#return value description#>
 */
- (UIViewController *)zn_obtainController;

/**
 获取分割线

 @return <#return value description#>
 */
+ (instancetype)zn_getLineView;



@end

//
//  UIView+ZNView.h
//  TableViewCollectView
//
//  Created by 郑楠楠 on 2018/3/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZNView)

/**
 x轴坐标
 */
@property (assign , nonatomic) CGFloat zn_x;

/**
 y轴坐标
 */
@property (assign , nonatomic) CGFloat zn_y;

/**
 控件宽度
 */
@property (assign , nonatomic) CGFloat zn_width;

/**
 控件高度
 */
@property (assign , nonatomic) CGFloat zn_height;

/**
 控件大小
 */
@property (assign , nonatomic) CGSize zn_size;

/**
 控件的坐标
 */
@property (assign , nonatomic) CGPoint zn_ponit;

/**
 获取分割线
 @param color 分割线的颜色
 @return <#return value description#>
 */
+ (instancetype)zn_getLineViewWithColor:(UIColor *) color;

/**
 使用贝塞尔曲线进行裁剪出圆形角
 
 @param r 圆的半径
 @return <#return value description#>
 */
- (instancetype)zn_BezierRoundWithR:(CGFloat) r;

/**
 获取类名

 @return <#return value description#>
 */
- (NSString *)zn_getClassName;

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
 获取当前控制器

 @return <#return value description#>
 */
- (UIViewController *)zn_obtainController;



/**
 设置底部的线条

 @param color 线条颜色
 @param edge 距离,只有左，右，下，这三个值有用
 */
- (void)zn_setBottomLineWithColor:(UIColor*) color
                    distance:(UIEdgeInsets)edge;

/**
 设置底部的线条
 
 @param color 线条颜色
 */
- (void)zn_setBottomLineWithColor:(UIColor*) color;

/**
 设置底部的线条

 @param edge <#edge description#>
 */
- (void)zn_setBottomLineWithDistance:(UIEdgeInsets)edge;

/**
 设置底部的线条
 
 @param bottom <#edge description#>
 */
- (void)zn_setBottomLineWithBottom:(CGFloat) bottom;
@end

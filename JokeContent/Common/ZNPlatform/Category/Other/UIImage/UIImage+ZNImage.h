//
//  UIImage+ZNImage.h
//  TableViewCollectView
//
//  Created by 郑楠楠 on 2018/4/20.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZNImage)

/**
 生成类似微信群一样的群头像图片
 图片组 本地
 @param array 原生image arr
 @param bgColor 新生成image 背景色
 @return image 组合
 */
+ (UIImage *)zn_groupIconWith:(NSArray *)array bgColor:(UIColor *)bgColor;

/**
 生成类似微信群一样的群头像图片
 图片组 本地
 @param corner 新生成组合图片背景圆角
 @param array 原生image arr
 @param bgColor 新生成image 背景色
 @return image 组合
 */
+ (UIImage *)zn_groupIconWith:(NSArray *)array corner:(CGFloat)corner bgColor:(UIColor *)bgColor;

/**
  生成类似微信群一样的群头像图片
 图片组合 网络请求，使用SD缓存到本地磁盘，请求前先去缓存中哈希查找是否有缓存
 @param URLArray 图片url 数组
 @param corner 新生成组合图片背景圆角
 @param bgColor 新生成组合图片背景颜色
 @param Success 组合成功回调
 @param Failed 组合失败回调
 */
+ (void )zn_groupIconWithURLArray:(NSArray *)URLArray
                        corner:(CGFloat)corner
                       bgColor:(UIColor *)bgColor
                       Success:(void(^)(UIImage *image))Success
                        Failed:(void(^)(NSString *fail))Failed;
/**
  生成类似微信群一样的群头像图片
 图片组合 网络请求，使用SD缓存到本地磁盘，请求前先去缓存中哈希查找是否有缓存
 @param URLArray 图片url 数组
 @param bgColor 新生成组合图片背景颜色
 @param Success 组合成功回调
 @param Failed 组合失败回调
 */
+ (void)zn_groupIconWithURLArray:(NSArray *)URLArray
                      bgColor:(UIColor *)bgColor
                      Success:(void(^)(UIImage *image))Success
                       Failed:(void(^)(NSString *fail))Failed;

/**
 根据颜色获取到纯色图片
 @param color 颜色
 @param size 图片大小
 @return <#return value description#>
 */
+ (UIImage *)zn_createImageWithColor:(UIColor *)color
                             size:(CGSize)size;

/**
 图片缩放
 @param size 要缩放的大小
 @return <#return value description#>
 */
- (UIImage *)zn_zoomWithSize:(CGSize)size;

/**
 根据宽比例进行缩放
 @param width <#width description#>
 @return <#return value description#>
 */
- (UIImage *)zn_zoomWithWidth:(CGFloat)width;

/**
 根据高比例进行缩放
 @param height <#width description#>
 @return <#return value description#>
 */
- (UIImage *)zn_zoomWithHeight:(CGFloat)height;

/**
 获取图片的主色调
 
 @return <#return value description#>
 */
- (UIColor *)zn_obtainMainColor;

/**
 裁剪图片,裁剪出来的是矩形的
 
 @param rect 裁剪的左上角坐标，及其要裁剪的大小
 @return <#return value description#>
 */
- (UIImage *)zn_catImageWithRect:(CGRect)rect;

/**
 裁剪图片，按图片的中心点进行裁剪，裁剪出来的是矩形的
 
 @param size 裁剪出来的图片大小
 @return <#return value description#>
 */
- (UIImage *)zn_catImageWithSize:(CGSize)size;

/**
 裁剪圆形图片
 @param point 圆心
 @param corcon 圆的半径
 @return <#return value description#>
 */
- (UIImage *)zn_catRoundWithPoint:(CGPoint)point
                           corcon:(CGFloat)corcon;

/**
 按该图片的最大半径进行裁剪，裁剪出来的图片是靠上进行裁剪，即图片的上端是原图片上端
 
 @return <#return value description#>
 */
- (UIImage *)zn_catRound;

/// 根据URL获取图片
/// @param url <#url description#>
+ (void)zn_obtainImageWithUrl:(NSString*) url
                        block:(void (^)(UIImage * image)) block;

@end

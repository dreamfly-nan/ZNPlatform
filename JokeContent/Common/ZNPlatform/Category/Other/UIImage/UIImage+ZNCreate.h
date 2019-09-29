//
//  UIImage+ZNCreate.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/4.
//  Copyright © 2019 南木南木. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZNCreate)

/**
 获取文件中的图片，返回UIImage对象

 @param name 文件名
 @param type 文件类型
 @return <#return value description#>
 */
+ (UIImage*)zn_createWithFileName:(NSString*) name
                             type:(NSString*) type;

/**
 根据url获取图片

 @param url <#url description#>
 @param block <#block description#>
 */
+ (void)zn_createWithUrl:(NSString*) url
                   block:(void (^)(UIImage * image)) block;

/**
  使用这个方法获取到的截图，图片文字都会变模糊

 @param view 需要截图的view
 @return <#return value description#>
 */
+ (UIImage *)zn_CreateImageVagueWithView:(UIView *) view;

/**
  使用该方法生成的图片不会模糊，根据屏幕密度计算

  @param view 需要截图的view
  @return <#return value description#>
 */
+ (UIImage *)zn_createImageWithView:(UIView *) view;

/**
 根据CIImage对象生成UIImage对象
 
 @param image ciimage对象
 @param size 生成的图片大小
 @return 生成的图片
 */
+ (UIImage *)zn_resizeCodeImage:(CIImage *)image withSize:(CGSize)size;

/**
 根据指定的颜色生成一张指定大小的纯色图片
 
 @param color 颜色
 @param size 大小
 @return 一张图片
 */
+ (UIImage *)zn_imageWithColor:(UIColor *)color size:(CGSize)size;

/** 根据颜色生成纯色图片 */
+ (UIImage *)zn_imageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END

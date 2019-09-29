//
//  UIImage+ZNCreate.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/4.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "UIImage+ZNCreate.h"

@implementation UIImage (ZNCreate)

/**
 获取文件中的图片，返回UIImage对象
 
 @param name 文件名
 @param type 文件类型
 @return <#return value description#>
 */
+ (UIImage*)zn_createWithFileName:(NSString*) name
                             type:(NSString*) type{
   NSString * path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    return [UIImage imageWithContentsOfFile:path];
}

/**
 根据url获取图片
 
 @param url <#url description#>
 @param block <#block description#>
 */
+ (void)zn_createWithUrl:(NSString*) url
                   block:(void (^)(UIImage * image)) block{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    if (block) {
        block([UIImage imageWithData:data]);
    }
}

/**
 使用这个方法获取到的截图，图片文字都会变模糊
 
 @param view 需要截图的view
 @return <#return value description#>
 */
+ (UIImage *)zn_CreateImageVagueWithView:(UIView *) view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 使用该方法生成的图片不会模糊，根据屏幕密度计算
 
 @param view 需要截图的view
 @return <#return value description#>
 */
+ (UIImage *)zn_createImageWithView:(UIView *) view{
    UIImage *imageRet = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    UIGraphicsBeginImageContextWithOptions(view.frame.size, YES, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageRet;
}

/**
 根据指定的颜色生成一张指定大小的纯色图片
 
 @param color 颜色
 @param size 大小
 @return 一张图片
 */
+ (UIImage *)zn_imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/** 根据颜色生成纯色图片 */
+ (UIImage *)zn_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 根据CIImage对象生成UIImage对象
 
 @param image ciimage对象
 @param size 生成的图片大小
 @return 生成的图片
 */
+ (UIImage *) zn_resizeCodeImage:(CIImage *)image withSize:(CGSize)size
{
    if (image) {
        CGRect extent = CGRectIntegral(image.extent);
        CGFloat scaleWidth = size.width/CGRectGetWidth(extent);
        CGFloat scaleHeight = size.height/CGRectGetHeight(extent);
        size_t width = CGRectGetWidth(extent) * scaleWidth;
        size_t height = CGRectGetHeight(extent) * scaleHeight;
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
        CGContextRef contentRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef imageRef = [context createCGImage:image fromRect:extent];
        CGContextSetInterpolationQuality(contentRef, kCGInterpolationNone);
        CGContextScaleCTM(contentRef, scaleWidth, scaleHeight);
        CGContextDrawImage(contentRef, extent, imageRef);
        CGImageRef imageRefResized = CGBitmapContextCreateImage(contentRef);
        CGContextRelease(contentRef);
        CGImageRelease(imageRef);
        return [UIImage imageWithCGImage:imageRefResized];
    }else{
        return nil;
    }
}

@end

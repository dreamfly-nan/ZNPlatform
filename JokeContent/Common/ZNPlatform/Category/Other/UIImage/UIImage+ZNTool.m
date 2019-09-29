//
//  UIImage+NNTool.m
//  GameGuestVidio
//
//  Created by 郑楠楠 on 2017/12/1.
//  Copyright © 2017年 郑楠楠. All rights reserved.
//

#import "UIImage+ZNTool.h"

@implementation UIImage (ZNTool)

/** 取图片某一像素的颜色 */
- (UIColor *)zn_colorWithAtPixel:(CGPoint)point
{
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point))
    {
        return nil;
    }
    
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.CGImage;
    NSUInteger width = self.size.width;
    NSUInteger height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

/** 获得灰度图 */
- (UIImage *)zn_convertToGrayImage
{
    int width = self.size.width;
    int height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL)
    {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), self.CGImage);
    CGImageRef contextRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:contextRef];
    CGContextRelease(context);
    CGImageRelease(contextRef);
    
    return grayImage;
}

/**
 
 对图片进行缩放的工具类
 @param image  需要缩放的图片
 @param size  需要的图片大小
 @return  返回的图片
 */
+(UIImage*)zn_originImage:(UIImage *)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

/**
 
 将图片按最大圆形进行裁剪，并返回裁剪后的图片
 @param image  要裁剪成圆形的图片
 @return  返回已经裁剪完的图片
 */
+(UIImage*)zn_originImage:(UIImage*) image{
    UIImage *finshImage;
    //获取图片尺寸
    CGSize size = image.size;
    
    //开启位图上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    //创建圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    //设置为裁剪区域
    [path addClip];
    
    //绘制图片
    [image drawAtPoint:CGPointZero];
    
    //获取裁剪后的图片
    finshImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return finshImage;
}

/**
 
 @param image  要进行缩放，并裁剪的图片
 @param size  要裁剪的大小
 @return  返回裁剪并缩小后的图片
 */
+(UIImage*)zn_originImage:(UIImage*) image roundSize:(CGSize) size{
    return [self zn_originImage:[self zn_originImage:image scaleToSize:size]];
}

/**
 对图标按一定标准进行缩放操作,按长宽中的最大值跟standard的比重进行缩放
 @param image 要缩放的图标
 @param standard 缩放的标准值，（就是正方形的边长）
 @return 缩放后的图片
 */
+(UIImage*)zn_zoomImage:(UIImage*) image standard:(CGFloat) standard{
    CGFloat sizeNumber = 1;
    CGFloat max = image.size.height > image.size.width ? image.size.height : image.size.width;
    CGFloat min = image.size.height > image.size.width ? image.size.width : image.size.height;
    if (max > standard) {
        sizeNumber = standard / max;
    }else{
        if (min < standard) {
            sizeNumber = standard / min;
        }
    }
    return [self zn_originImage:image scaleToSize:CGSizeMake(sizeNumber * image.size.width, sizeNumber * image.size.height)];
}

+ (UIImage*) zoomImagewith:(UIImage*) image standard:(CGFloat) standard{
    CGFloat sizenumber = standard/image.size.width;
    return [self zn_originImage:image scaleToSize:CGSizeMake(sizenumber * image.size.width, sizenumber * image.size.height)];
}

- (UIImage*)zn_imageZoomSize:(CGSize) size{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end

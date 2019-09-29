//
//  UIImage+ZNImage.m
//  TableViewCollectView
//
//  Created by 郑楠楠 on 2018/4/20.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "UIImage+ZNImage.h"
#import <SDImageCache.h>

@implementation UIImage (ZNImage)

/**
 图片组合 网络请求，使用SD缓存到本地磁盘，请求前先去缓存中哈希查找是否有缓存
 
 @param URLArray 图片url 数组
 @param corner 新生成组合图片背景圆角
 @param bgColor 新生成组合图片背景颜色
 @param Success 组合成功回调
 @param Failed 组合失败回调
 */
+(void)zn_groupIconWithURLArray:(NSArray *)URLArray
                      corner:(CGFloat)corner
                     bgColor:(UIColor *)bgColor
                     Success:(void(^)(UIImage *image))Success
                      Failed:(void(^)(NSString *fail))Failed
{
    UIImage *cacheImage;
    
    NSString *cacheKey = [URLArray componentsJoinedByString:@"-"];
    
    
    SDImageCache * cache = [SDImageCache sharedImageCache];
    //此方法会先从memory中取。
    cacheImage = [cache imageFromDiskCacheForKey:cacheKey];
    
    if (cacheImage) {
        if (Success) {
            Success(cacheImage);
        }
        return;
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    NSMutableArray *imageArray = [NSMutableArray array];
    
    dispatch_group_t g = dispatch_group_create();
    dispatch_queue_t globalQueue=dispatch_get_global_queue(0, 0);
    
    //3.添加任务,让队列调度,任务执行情况,最后通知调度组
    for (int i = 0; i<URLArray.count;  i++) {
        NSURL *url = [NSURL URLWithString:URLArray[i]];
        //请求
        dispatch_group_enter(g);
        dispatch_group_async(g, globalQueue, ^{
            NSLog(@"task %d%@",i,[NSThread currentThread]);
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                [imageArray addObject:image];
            }else{
                [imageArray addObject:[UIImage imageNamed:@"dr_placeholder_avatar_icon"]];
            }
            dispatch_group_leave(g);
        });
    }
    //4.所有任务执行完毕后,通知调度组
    //用一个调度组,可以监听全局队列的任务,主队列去执行最后的任务
    //dispatch_group_notify 本身也是异步的!
    dispatch_group_notify(g, dispatch_get_main_queue(), ^{
        //更新UI,通知用户
        //        NSLog(@"OK更新UI,通知用户 %@",[NSThread currentThread]);
        imageView.image = [UIImage zn_groupIconWith:imageArray corner:corner bgColor:[UIColor groupTableViewBackgroundColor]];
        [[SDImageCache sharedImageCache] storeImage:imageView.image forKey:cacheKey toDisk:YES completion:^{
            NSLog(@"缓存图片成功%@",[NSThread currentThread]);
        }];
        
        if (Success) {
            Success(imageView.image);
        }
        if (Failed) {
            Failed(@"头像下载失败");
        }
    });
    //    NSLog(@"come %@", [NSThread currentThread]);
}

+ (void)zn_groupIconWithURLArray:(NSArray *)URLArray
                      bgColor:(UIColor *)bgColor
                      Success:(void(^)(UIImage *image))Success
                       Failed:(void(^)(NSString *fail))Failed
{
    
    UIImage *cacheImage;
    
    NSString *cacheKey = [URLArray componentsJoinedByString:@"-"];
    
    SDImageCache* cache = [SDImageCache sharedImageCache];
    //此方法会先从memory中取。
    cacheImage = [cache imageFromDiskCacheForKey:cacheKey];
    
    if (cacheImage) {
        if (Success) {
            Success(cacheImage);
        }
        return;
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    NSMutableArray *imageArray = [NSMutableArray array];
    
    dispatch_group_t g = dispatch_group_create();
    dispatch_queue_t globalQueue=dispatch_get_global_queue(0, 0);
    //3.添加任务,让队列调度,任务执行情况,最后通知调度组
    for (int i = 0; i<URLArray.count;  i++) {
        NSURL *url = [NSURL URLWithString:URLArray[i]];
        //请求
        dispatch_group_enter(g);
        dispatch_group_async(g, globalQueue, ^{
            NSLog(@"task %d%@",i,[NSThread currentThread]);
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                [imageArray addObject:image];
            }else{
                [imageArray addObject:[UIImage imageNamed:@"dr_placeholder_avatar_icon"]];
            }
            dispatch_group_leave(g);
        });
    }
    //4.所有任务执行完毕后,通知调度组
    //用一个调度组,可以监听全局队列的任务,主队列去执行最后的任务
    //dispatch_group_notify 本身也是异步的!
    dispatch_group_notify(g, dispatch_get_main_queue(), ^{
        //更新UI,通知用户
        //        NSLog(@"OK更新UI,通知用户 %@",[NSThread currentThread]);
        imageView.image = [UIImage zn_groupIconWith:imageArray bgColor:[UIColor groupTableViewBackgroundColor]];
        [[SDImageCache sharedImageCache] storeImage:imageView.image forKey:cacheKey toDisk:YES completion:^{
            NSLog(@"缓存图片成功%@",[NSThread currentThread]);
        }];
        
        if (Success) {
            Success(imageView.image);
        }
        if (Failed) {
            Failed(@"头像下载失败");
        }
    });
    //    NSLog(@"come %@", [NSThread currentThread]);
}

+ (UIImage *)zn_groupIconWith:(NSArray *)array bgColor:(UIColor *)bgColor {
    
    CGSize finalSize = CGSizeMake(100, 100);
    CGRect rect = CGRectZero;
    rect.size = finalSize;
    
    UIGraphicsBeginImageContext(finalSize);
    
    if (bgColor) {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, bgColor.CGColor);
        CGContextSetFillColorWithColor(context, bgColor.CGColor);
        CGContextSetLineWidth(context, 1.0);
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, 0, 100);
        CGContextAddLineToPoint(context, 100, 100);
        CGContextAddLineToPoint(context, 100, 0);
        CGContextAddLineToPoint(context, 0, 0);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    
    if (array.count >= 2) {
        
        NSArray *rects = [self zn_eachRectInGroupWithCount2:array.count];
        int count = 0;
        for (id obj in array) {
            
            if (count > rects.count-1) {
                break;
            }
            
            UIImage *image;
            
            if ([obj isKindOfClass:[NSString class]]) {
                image = [UIImage imageNamed:(NSString *)obj];
            } else if ([obj isKindOfClass:[UIImage class]]){
                image = (UIImage *)obj;
            } else {
                NSLog(@"%s Unrecognizable class type", __FUNCTION__);
                break;
            }
            
            CGRect rect = CGRectFromString([rects objectAtIndex:count]);
            [image drawInRect:rect];
            count++;
        }
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)zn_groupIconWith:(NSArray *)array corner:(CGFloat)cornerRadius bgColor:(UIColor *)bgColor {
    
    CGSize finalSize = CGSizeMake(100, 100);
    CGRect rect = CGRectZero;
    rect.size = finalSize;
    
    UIGraphicsBeginImageContext(finalSize);
    
    if (bgColor) {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, bgColor.CGColor);
        CGContextSetFillColorWithColor(context, bgColor.CGColor);
        /*画圆角矩形*/
        CGSize rectSize = finalSize;
        CGContextMoveToPoint(context, rectSize.width, cornerRadius * 2);  // 开始坐标右边开始
        CGContextAddArcToPoint(context, rectSize.width, rectSize.height, rectSize.width - 10, rectSize.height, cornerRadius);  // 右下角
        CGContextAddArcToPoint(context, 0, rectSize.height, 0, rectSize.height - 10, cornerRadius); // 左下角
        CGContextAddArcToPoint(context, 0, 0, cornerRadius * 2, 0, cornerRadius); // 左上角
        CGContextAddArcToPoint(context, rectSize.width, 0, rectSize.width, cornerRadius * 2, cornerRadius); // 右上角
        
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    
    if (array.count >= 2) {
        
        NSArray *rects = [self zn_eachRectInGroupWithCount2:array.count];
        int count = 0;
        for (id obj in array) {
            
            if (count > rects.count-1) {
                break;
            }
            
            UIImage *image;
            
            if ([obj isKindOfClass:[NSString class]]) {
                image = [UIImage imageNamed:(NSString *)obj];
            } else if ([obj isKindOfClass:[UIImage class]]){
                image = (UIImage *)obj;
            } else {
                NSLog(@"%s Unrecognizable class type", __FUNCTION__);
                break;
            }
            
            CGRect rect = CGRectFromString([rects objectAtIndex:count]);
            [image drawInRect:rect];
            count++;
        }
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSArray *)zn_eachRectInGroupWithCount:(NSInteger)count {
    
    NSArray *rects = nil;
    
    CGFloat sizeValue = 100;
    CGFloat padding = 8;
    
    CGFloat eachWidth = (sizeValue - padding*3) / 2;
    
    CGRect rect1 = CGRectMake(sizeValue/2 - eachWidth/2, padding, eachWidth, eachWidth);
    
    CGRect rect2 = CGRectMake(padding, padding*2 + eachWidth, eachWidth, eachWidth);
    
    CGRect rect3 = CGRectMake(padding*2 + eachWidth, padding*2 + eachWidth, eachWidth, eachWidth);
    if (count == 3) {
        rects = @[NSStringFromCGRect(rect1), NSStringFromCGRect(rect2), NSStringFromCGRect(rect3)];
    } else if (count == 4) {
        CGRect rect0 = CGRectMake(padding, padding, eachWidth, eachWidth);
        rect1 = CGRectMake(padding*2, padding, eachWidth, eachWidth);
        rects = @[NSStringFromCGRect(rect0), NSStringFromCGRect(rect1), NSStringFromCGRect(rect2), NSStringFromCGRect(rect3)];
    }
    
    return rects;
}

+ (NSArray *)zn_eachRectInGroupWithCount2:(NSInteger)count {
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:count];
    
    CGFloat sizeValue = 100;
    CGFloat padding = 2;
    
    CGFloat eachWidth;
    
    if (count <= 4) {
        eachWidth = (sizeValue - padding*3) / 2;
        [self zn_getRects:array padding:padding width:eachWidth count:4];
    } else {
        padding = padding / 2;
        eachWidth = (sizeValue - padding*4) / 3;
        [self zn_getRects:array padding:padding width:eachWidth count:9];
    }
    
    if (count < 4) {
        [array removeObjectAtIndex:0];
        CGRect rect = CGRectFromString([array objectAtIndex:0]);
        rect.origin.x = (sizeValue - eachWidth) / 2;
        [array replaceObjectAtIndex:0 withObject:NSStringFromCGRect(rect)];
        if (count == 2) {
            [array removeObjectAtIndex:0];
            NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:2];
            
            for (NSString *rectStr in array) {
                CGRect rect = CGRectFromString(rectStr);
                rect.origin.y -= (padding+eachWidth)/2;
                [tempArray addObject:NSStringFromCGRect(rect)];
            }
            [array removeAllObjects];
            [array addObjectsFromArray:tempArray];
        }
    } else if (count != 4 && count <= 6) {
        [array removeObjectsInRange:NSMakeRange(0, 3)];
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:6];
        
        for (NSString *rectStr in array) {
            CGRect rect = CGRectFromString(rectStr);
            rect.origin.y -= (padding+eachWidth)/2;
            [tempArray addObject:NSStringFromCGRect(rect)];
        }
        [array removeAllObjects];
        [array addObjectsFromArray:tempArray];
        
        if (count == 5) {
            [tempArray removeAllObjects];
            [array removeObjectAtIndex:0];
            
            for (int i=0; i<2; i++) {
                CGRect rect = CGRectFromString([array objectAtIndex:i]);
                rect.origin.x -= (padding+eachWidth)/2;
                [tempArray addObject:NSStringFromCGRect(rect)];
            }
            [array replaceObjectsInRange:NSMakeRange(0, 2) withObjectsFromArray:tempArray];
        }
        
    } else if (count != 4 && count < 9) {
        if (count == 8) {
            [array removeObjectAtIndex:0];
            NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:2];
            for (int i=0; i<2; i++) {
                CGRect rect = CGRectFromString([array objectAtIndex:i]);
                rect.origin.x -= (padding+eachWidth)/2;
                [tempArray addObject:NSStringFromCGRect(rect)];
            }
            [array replaceObjectsInRange:NSMakeRange(0, 2) withObjectsFromArray:tempArray];
        } else {
            [array removeObjectAtIndex:2];
            [array removeObjectAtIndex:0];
        }
    }
    
    return array;
}

+ (void)zn_getRects:(NSMutableArray *)array padding:(CGFloat)padding width:(CGFloat)eachWidth count:(int)count {
    
    for (int i=0; i<count; i++) {
        int sqrtInt = (int)sqrt(count);
        int line = i%sqrtInt;
        int row = i/sqrtInt;
        CGRect rect = CGRectMake(padding * (line+1) + eachWidth * line, padding * (row+1) + eachWidth * row, eachWidth, eachWidth);
        [array addObject:NSStringFromCGRect(rect)];
    }
}


/**
 根据颜色获取到纯色图片
 
 @param color 颜色
 @param size 图片大小
 @return <#return value description#>
 */
+ (UIImage *)zn_createImageWithColor:(UIColor *)color
                             size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.width));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



/**
 图片缩放
 
 @param size 要缩放的大小
 @return <#return value description#>
 */
- (UIImage *)zn_zoomWithSize:(CGSize)size{
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if (CGSizeEqualToSize(imageSize, size) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) *0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) *0.5;
        }
        
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [self drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
        return self;
    }
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 根据宽进行缩放
 
 @param width <#width description#>
 @return <#return value description#>
 */
- (UIImage *)zn_zoomWithWidth:(CGFloat)width{
    return [self zn_zoomWithSize:CGSizeMake(width, width / self.size.width * self.size.height)];
}

/**
 根据高比例进行缩放
 
 @param height <#width description#>
 @return <#return value description#>
 */
- (UIImage *)zn_zoomWithHeight:(CGFloat)height{
    return [self zn_zoomWithSize:CGSizeMake(height / self.size.height * self.size.width, height)];
}

/**
 获取图片的主色调
 
 @return <#return value description#>
 */
- (UIColor *)zn_obtainMainColor{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize=CGSizeMake(self.size.width/2, self.size.height/2);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, self.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) return nil;
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            int offset = 4*(x*y);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            if (alpha>0) {//去除透明
                if (red==255&&green==255&&blue==255) {//去除白色
                }else{
                    NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
                    [cls addObject:clr];
                }
                
            }
        }
    }
    CGContextRelease(context);
    
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) continue;
        MaxCount=tmpCount;
        MaxColor=curColor;
        
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

/**
 裁剪图片,裁剪出来的是矩形的
 
 @param rect 裁剪的左上角坐标，及其要裁剪的大小
 @return <#return value description#>
 */
- (UIImage *)zn_catImageWithRect:(CGRect)rect{
    //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [self CGImage];
    
    //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    
    //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    //返回剪裁后的图片
    return newImage;
}

/**
 裁剪图片，按图片的中心点进行裁剪，裁剪出来的是矩形的
 
 @param size 裁剪出来的图片大小
 @return <#return value description#>
 */
- (UIImage *)zn_catImageWithSize:(CGSize)size{
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGSize imageSize = self.size;
    
    return [self zn_catImageWithRect:CGRectMake(imageSize.width/2 - width, imageSize.height/2 - height, width, height)];
}

/**
 裁剪圆形图片
 
 @param point 圆心
 @param corcon 圆的半径
 @return <#return value description#>
 */
- (UIImage *)zn_catRoundWithPoint:(CGPoint)point
                           corcon:(CGFloat)corcon{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillPath(context);
    CGContextSetLineWidth(context, .5);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGRect rect = CGRectMake(point.x, point.y, self.size.width - corcon * 2.0f, self.size.height - corcon * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    
    CGContextClip(context);
    
    [self drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

/**
 按该图片的最大半径进行裁剪，裁剪出来的图片是靠上进行裁剪，即图片的上端是原图片上端
 
 @return <#return value description#>
 */
- (UIImage *)zn_catRound{
    CGFloat corcon = self.size.width > self.size.height ? self.size.height : self.size.width;
    corcon = corcon / 2;
    return [self zn_catRoundWithPoint:CGPointMake(corcon, corcon) corcon:corcon];
}

@end

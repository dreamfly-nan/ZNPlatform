//
//  UIImageView+ZNCreate.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/4.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (ZNCreate)

/**
 根据资源图片名设置图片
 */
- (UIImageView * (^)(NSString * imageName))zn_imageName;

/**
 设置图片
 */
- (UIImageView * (^)(UIImage * image))zn_image;

/**
 设置图片显示模式
 */
- (UIImageView * (^)(UIViewContentMode mode))zn_contentMode;

@end

NS_ASSUME_NONNULL_END

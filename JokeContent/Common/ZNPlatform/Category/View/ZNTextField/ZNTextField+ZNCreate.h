//
//  ZNTextField+ZNCreate.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/18.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZNTextField (ZNCreate)

/**
 设置字体
 */
- (ZNTextField * (^)(UIFont * font) )zn_font;

/**
 设置字体颜色
 */
- (ZNTextField * (^)(UIColor * textColor))zn_textColor;

/**
 设置文本
 */
- (ZNTextField * (^)(NSString * text))zn_text;

/**
 设置占位符
 */
- (ZNTextField * (^)(NSString * placeStr))zn_place;

/**
 设置文本显示模式
 */
- (ZNTextField * (^)(NSTextAlignment alignment))zn_alignment;

/**
 设置图片与文本的间距
 */
- (ZNTextField * (^)(CGFloat imageSpace))zn_imageSpace;

/**
 设置左边要显示的图片
 */
- (ZNTextField * (^)(UIImage * image))zn_leftImage;

/**
 设置是否左边有图片存在
 */
- (ZNTextField * (^)(BOOL isLeftView))zn_isLeftView;

/**
 设置内容的边距
 */
- (ZNTextField * (^)(UIEdgeInsets insets))zn_inset;

/**
 设置左边图片的大小
 */
- (ZNTextField * (^)(CGSize size))zn_imageSize;

@end

NS_ASSUME_NONNULL_END

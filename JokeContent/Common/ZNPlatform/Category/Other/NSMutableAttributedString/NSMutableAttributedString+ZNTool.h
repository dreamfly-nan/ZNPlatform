//
//  NSMutableAttributedString+ZNTool.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/5.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (ZNTool)

/**
 获取富文本

 @param text <#text description#>
 @param font <#font description#>
 @param color <#color description#>
 @return <#return value description#>
 */
+ (NSMutableAttributedString *) zn_createWithText:(NSString *) text
                                             font:(UIFont *) font
                                            color:(UIColor*) color;

+ (NSMutableAttributedString *)zn_createWithText:(NSString *)str
                                            font:(UIFont *) font
                                           color:(UIColor*) color
                                      attachment:(NSTextAttachment *)attachment;

/**
 获取在字符串头部插入图片的富文本

 @param str <#str description#>
 @param font <#font description#>
 @param color <#color description#>
 @param image 插入的图片
 @param imageSize 图片需要的大小
 @return <#return value description#>
 */
+ (NSMutableAttributedString *)zn_insertImageTextHead:(NSString *)str
                                            font:(UIFont *) font
                                           color:(UIColor*) color
                                           image:(UIImage *) image
                                       imageSize:(CGSize) imageSize;

@end

NS_ASSUME_NONNULL_END

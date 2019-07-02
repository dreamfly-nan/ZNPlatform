//
//  UILabel+ZNLabel.h
//  TableViewCollectView
//
//  Created by 郑楠楠 on 2018/4/2.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ZNLabel)

/**
 根据位置进行设置字体以及文字的颜色

 @param range <#range description#>
 @param font <#font description#>
 @param color <#color description#>
 */
- (void)zn_setFontAndColorWithRanage:(NSRange) range
                             font:(UIFont *)font
                            color:(UIColor *)color;

/**
 根据字符串进行修改文字颜色字体

 @param string <#string description#>
 @param font <#font description#>
 @param color <#color description#>
 */
- (void)zn_setFontAndColorWithString:(NSString *) string
                             font:(UIFont *)font
                            color:(UIColor *)color;

/**
 批量设置字符串的字体

 @param arrayStr <#arrayStr description#>
 @param font <#font description#>
 @param color <#color description#>
 */
- (void)zn_setFontAndColorWithArrayStr:(NSArray<NSString*> *) arrayStr
                                font:(UIFont *)font
                               color:(UIColor *)color;

@end

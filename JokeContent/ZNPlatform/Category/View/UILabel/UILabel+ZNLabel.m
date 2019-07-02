//
//  UILabel+ZNLabel.m
//  TableViewCollectView
//
//  Created by 郑楠楠 on 2018/4/2.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "UILabel+ZNLabel.h"

@implementation UILabel (ZNLabel)

/**
 根据位置进行设置字体以及文字的颜色
 
 @param range <#range description#>
 @param font <#font description#>
 @param color <#color description#>
 */
- (void)zn_setFontAndColorWithRanage:(NSRange) range
                             font:(UIFont *)font
                            color:(UIColor *)color{
    NSString *text = self.text;
    NSMutableAttributedString *strArr = [[NSMutableAttributedString alloc] initWithString:text];
    [strArr addAttribute:NSForegroundColorAttributeName value:color range:range];
    [strArr addAttribute:NSFontAttributeName value:font range:range];
    self.attributedText = strArr;
}

/**
 根据字符串进行修改文字颜色字体
 
 @param string <#string description#>
 @param font <#font description#>
 @param color <#color description#>
 */
- (void)zn_setFontAndColorWithString:(NSString *) string
                             font:(UIFont *)font
                            color:(UIColor *)color{
    NSRange range = [self.text rangeOfString:string];
    [self zn_setFontAndColorWithRanage:range font:font color:color];
}

/**
 批量设置字符串的字体
 
 @param arrayStr <#arrayStr description#>
 @param font <#font description#>
 @param color <#color description#>
 */
- (void)zn_setFontAndColorWithArrayStr:(NSArray<NSString*> *) arrayStr
                                  font:(UIFont *)font
                                 color:(UIColor *)color{
    for (NSString * str in arrayStr) {
        [self zn_setFontAndColorWithString:str font:font color:color];
    }
}

@end

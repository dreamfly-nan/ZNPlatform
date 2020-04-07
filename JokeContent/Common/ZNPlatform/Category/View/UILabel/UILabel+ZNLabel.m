//
//  UILabel+ZNLabel.m
//  TableViewCollectView
//
//  Created by 郑楠楠 on 2018/4/2.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "UILabel+ZNLabel.h"

@implementation UILabel (ZNLabel)

//+ (void)load{
//    Method originalThodText = class_getInstanceMethod([self class], @selector(setText:));
//    Method newThodText = class_getInstanceMethod([self class], @selector(reSetText:));
//     method_exchangeImplementations(originalThodText, newThodText);
//}
//
///// 屏蔽 nil的设置存在
///// @param text <#text description#>
//- (void)reSetText:(NSString*) text{
//    if (text == nil) {
//        text = @"";
//    }
//    [self reSetText:text];
//}

/**
 根据位置进行设置字体以及文字的颜色
 
 @param range <#range description#>
 @param font <#font description#>
 @param color <#color description#>
 */
- (void)zn_setFontAndColorWithRanage:(NSRange) range
                             font:(UIFont *)font
                            color:(UIColor *)color{
    NSAttributedString *text = self.attributedText;
    NSMutableAttributedString *strArr = [[NSMutableAttributedString alloc] initWithAttributedString:text];
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

/// 设置中划线
- (void)zn_setCenterLine{
    if (self.text) {
        //中划线
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self.text attributes:attribtDic];
        // 赋值
        self.attributedText = attribtStr;
    }
}

@end

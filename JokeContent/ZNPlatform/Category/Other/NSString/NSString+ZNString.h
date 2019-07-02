//
//  NSString+ZNString.h
//  TableViewCollectView
//
//  Created by 郑楠楠 on 2018/4/3.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (ZNString)

/**
 只有字符串为YES时，返回为YES，其他都为NO
 字符串转布尔值
 @return <#return value description#>
 */
- (BOOL)zn_StringToBool;

/**
 根据给定高度和文字字体

 @param height <#height description#>
 @param font <#font description#>
 @return <#return value description#>
 */
- (CGRect)zn_obtainRectWithHeight:(CGFloat)height
                             font:(UIFont *)font;
/**
 根据高度和字体获取自适应宽度
 @param height <#height description#>
 @param font 字体
 @return <#return value description#>
 */
- (CGFloat)zn_obtainWidthWithHeight:(CGFloat)height
                              font:(UIFont*)font;

/**
 根据高度和字体获取自适应宽度
 @param height <#height description#>
 @param fontSize 文字大小
 @return <#return value description#>
 */
- (CGFloat)zn_obtainWidthWithHeight:(CGFloat)height
                          fontSize:(CGFloat)fontSize;


/**
 根据给定的字体和固定的宽度，算出高度值,且包含换行字符
 @param font <#font description#>
 @param width <#width description#>
 @return <#return value description#>
 */
- (CGFloat)zn_obtainHeightWithFont:(UIFont*) font
                             width:(CGFloat)width;

/**
 获取一个字符串，例如 99+ ,要求纯数字的字符串

 @param number <#number description#>
 @return <#return value description#>
 */
- (NSString*)zn_obtainNumber:(int) number;

@end

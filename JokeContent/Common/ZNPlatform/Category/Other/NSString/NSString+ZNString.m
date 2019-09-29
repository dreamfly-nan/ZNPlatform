//
//  NSString+ZNString.m
//  TableViewCollectView
//
//  Created by 郑楠楠 on 2018/4/3.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "NSString+ZNString.h"

@implementation NSString (ZNString)

/**
 只有字符串为YES时，返回为YES，其他都为NO
 字符串转布尔值
 @return <#return value description#>
 */
- (BOOL)zn_StringToBool{
    if ([self isEqualToString:@"YES"]) {
        return YES;
    }
    return NO;
}

- (CGRect)zn_obtainRectWithHeight:(CGFloat)height font:(UIFont *)font{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = font.lineHeight;
    // NSKernAttributeName字体间距
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:paraStyle,
                          NSKernAttributeName:@1.5f
                          };
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT,height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect;
}

- (CGFloat)zn_obtainWidthWithHeight:(CGFloat)height font:(UIFont *)font{
    return [self zn_obtainRectWithHeight:height font:font].size.width;
}

- (CGFloat)zn_obtainWidthWithHeight:(CGFloat)height
                          fontSize:(CGFloat)fontSize{
   return [self zn_obtainWidthWithHeight:height font:[UIFont systemFontOfSize:fontSize]];
}

/**
 根据给定的字体和固定的宽度，算出高度值
 @param font <#font description#>
 @param width <#width description#>
 @return <#return value description#>
 */
- (CGFloat)zn_obtainHeightWithFont:(UIFont*) font
                             width:(CGFloat)width{
    NSArray<NSString*> * strs = [self componentsSeparatedByString:@"\n"];
    CGFloat height = font.lineHeight;
    CGFloat resultHeight = 0;
    int number = 1;
    for (NSString * str in strs) {
        number = 1;
        CGFloat subWidth = [str zn_obtainWidthWithHeight:height font:font];
        if (subWidth > width) {
            //向上取整
            number =  ceilf(subWidth / width);
        }
        resultHeight = resultHeight + number * height;
    }
    return resultHeight;
}


/**
 获取一个字符串，例如 99+
 
 @param number <#number description#>
 @return <#return value description#>
 */
- (NSString*)zn_obtainNumber:(int) number{
    if ([self intValue] > number) {
        return [NSString stringWithFormat:@"%d+",number];
    }
    return self;
}

/**
 在该字符串头尾加 str 字符串
 
 @param str <#str description#>
 @return <#return value description#>
 */
- (NSString *)zn_headAndAdd:(NSString*) str{
    NSMutableString * string = [NSMutableString new];
    [string appendString:str];
    [string appendString:self];
    [string appendString:str];
    return string;
}

@end

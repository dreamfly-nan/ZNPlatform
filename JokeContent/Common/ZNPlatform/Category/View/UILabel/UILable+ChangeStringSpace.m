//
//  UILable+ChangeStringSpace.m
//  TuTuYouXuan
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 ttyx. All rights reserved.
//

#import "UILable+ChangeStringSpace.h"

@implementation UILabel(ChangeStringSpace)

/// 改变行距
/// @param lable <#lable description#>
/// @param space <#space description#>
+ (void)changeLineSpaceforLable:(UILabel *)lable WithSpace:(float)space{
    NSString * labletext =lable.text;
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc]initWithString:labletext];
    NSMutableParagraphStyle * paragraphStyle = [NSMutableParagraphStyle new];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labletext length])];
    [attributedString addAttribute:NSBaselineOffsetAttributeName value:@(0) range:NSMakeRange(0, [labletext length])];
    lable.attributedText = attributedString;
    [lable sizeToFit];
}

/// 改变字间距
/// @param lable <#lable description#>
/// @param space <#space description#>
+ (void)changeWordSpaceForLabel:(UILabel *)lable WithSpace:(float)space{
    NSString * lableText = lable.text;
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc]initWithString:lableText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle * paragraphStyle = [NSMutableParagraphStyle new];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [lableText length])];
    [attributedString addAttribute:NSBaselineOffsetAttributeName value:@(0) range:NSMakeRange(0, [lableText length])];
    lable.attributedText = attributedString;
    [lable sizeToFit];
}

/// 改变字行 间距
/// @param lable <#lable description#>
/// @param linkspace <#linkspace description#>
/// @param wordspace <#wordspace description#>
+ (void)changeSpaceForLable:(UILabel *)lable withLineSpace:(float)linkspace WordSpace:(float)wordspace{
    NSString * labletext= lable.text;
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc]initWithString:labletext];
    NSMutableParagraphStyle * paragraphStyle = [NSMutableParagraphStyle new];
    [paragraphStyle setLineSpacing:linkspace];
    [attributedString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(wordspace)} range:NSMakeRange(0, [labletext length])];
    [attributedString addAttribute:NSBaselineOffsetAttributeName value:@(0) range:NSMakeRange(0, [labletext length])];
    lable.attributedText = attributedString;
    [lable sizeToFit];
}

@end

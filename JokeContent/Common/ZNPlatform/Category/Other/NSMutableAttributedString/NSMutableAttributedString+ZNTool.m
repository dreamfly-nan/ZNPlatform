//
//  NSMutableAttributedString+ZNTool.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/5.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "NSMutableAttributedString+ZNTool.h"

@implementation NSMutableAttributedString (ZNTool)

+ (NSMutableAttributedString *) zn_createWithText:(NSString *) text
                                             font:(UIFont *) font
                                            color:(UIColor*) color{
    return [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName :font,NSForegroundColorAttributeName : color}];
}

+ (NSMutableAttributedString *)zn_createWithText:(NSString *)str
                                            font:(UIFont *) font
                                           color:(UIColor*) color
                                      attachment:(NSTextAttachment *)attachment{
    NSMutableAttributedString *attStr = [NSMutableAttributedString zn_createWithText:str font:font color:color];
    NSAttributedString * attachmentStr = [NSAttributedString attributedStringWithAttachment:attachment];
    [attStr insertAttributedString:attachmentStr atIndex:0];
    [attStr addAttributes:@{NSBaselineOffsetAttributeName : @(-2)} range:NSMakeRange(0, 1)];
    return attStr;
}

+ (NSMutableAttributedString *)zn_insertImageTextHead:(NSString *)str
                                                 font:(UIFont *) font
                                                color:(UIColor*) color
                                                image:(UIImage *) image
                                            imageSize:(CGSize) imageSize{
    NSTextAttachment * pointAt = [[NSTextAttachment alloc] init];
    pointAt.bounds = CGRectMake(0, -2, imageSize.width, imageSize.height);
    pointAt.image = image;
    return [self zn_createWithText:str font:font color:color attachment:pointAt];
}

@end

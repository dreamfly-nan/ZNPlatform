//
//  RPBaseTableViewCell.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/7.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaseTableViewCell.h"

@implementation RPBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark ------public------

+ (NSString *)idString{
    return NSStringFromClass(self);
}

- (NSMutableAttributedString*)createStr:(NSString*)str{
    return [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName :zn_font(12),NSForegroundColorAttributeName : zn_colorString(@"#BFBFBF")}];
}

- (NSMutableAttributedString *)createAttstr:(NSString *)str attachment:(NSTextAttachment *)attachment{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName :zn_font(12),NSForegroundColorAttributeName : zn_colorString(@"#BFBFBF")}];
    NSAttributedString * attachmentStr = [NSAttributedString attributedStringWithAttachment:attachment];
    [attStr insertAttributedString:attachmentStr atIndex:0];
    [attStr addAttributes:@{NSBaselineOffsetAttributeName : @(-2)} range:NSMakeRange(0, 1)];
    return attStr;
}

- (NSTextAttachment *)createAttachment:(NSString*)imageName{
    NSTextAttachment * pointAt = [[NSTextAttachment alloc] init];
    pointAt.bounds = CGRectMake(0, 0, zn_AutoWidth(13), zn_AutoWidth(13));
    pointAt.image = [UIImage imageNamed:imageName];
    return pointAt;
}

@end

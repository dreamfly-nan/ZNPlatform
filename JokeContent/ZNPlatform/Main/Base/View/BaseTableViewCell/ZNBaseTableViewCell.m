//
//  ZNBaseTableViewCell.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/25.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNBaseTableViewCell.h"

@implementation ZNBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)idString{
    return NSStringFromClass([self class]);
}

@end

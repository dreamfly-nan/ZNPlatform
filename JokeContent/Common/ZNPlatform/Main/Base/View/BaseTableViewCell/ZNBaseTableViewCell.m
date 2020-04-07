//
//  ZNBaseTableViewCell.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/25.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNBaseTableViewCell.h"

@implementation ZNBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

+ (NSString *)idString{
    return NSStringFromClass([self class]);
}

@end

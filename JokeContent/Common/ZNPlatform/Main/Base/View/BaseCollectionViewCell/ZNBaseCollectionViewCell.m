//
//  ZNBaseCollectionViewCell.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/11.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNBaseCollectionViewCell.h"

@implementation ZNBaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

+ (NSString *)idString{
    return NSStringFromClass([self class]);
}

@end

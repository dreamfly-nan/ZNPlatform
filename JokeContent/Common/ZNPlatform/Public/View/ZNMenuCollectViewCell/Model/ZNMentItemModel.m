//
//  ZNMentItemModel.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/8.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNMentItemModel.h"

@implementation ZNMentItemModel

+ (instancetype)initWithTitle:(NSString*) title image:(NSString*) name{
    ZNMentItemModel * model = [ZNMentItemModel new];
    model.title = title;
    model.imageName = name;
    model.isUrl = NO;
    return model;
}

+ (instancetype)initWithTitle:(NSString*) title url:(NSString*) url{
    ZNMentItemModel * model = [ZNMentItemModel new];
    model.title = title;
    model.imageUrl = url;
    model.isUrl = YES;
    return model;
}

@end

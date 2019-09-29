//
//  ZNPopoMenuItemModel.m
//  CityManagement
//
//  Created by 南木南木 on 2019/9/3.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "ZNPopoMenuItemModel.h"

@implementation ZNPopoMenuItemModel

+ (instancetype)initWithIconName:(NSString*) iconName
                            name:(NSString*) name{
    ZNPopoMenuItemModel * model = [ZNPopoMenuItemModel new];
    model.iconName = iconName;
    model.name = name;
    return model;
}

@end

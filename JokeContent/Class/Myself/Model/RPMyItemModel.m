//
//  RPMyItemModel.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPMyItemModel.h"

@implementation RPMyItemModel

+ (instancetype)initWihtName:(NSString*)name
                   iconImage:(NSString*)iconImage
              viewController:(NSString*)viewController{
    RPMyItemModel *model = [RPMyItemModel new];
    model.name = name;
    model.iconImage = iconImage;
    model.viewController = viewController;
    return model;
}

@end

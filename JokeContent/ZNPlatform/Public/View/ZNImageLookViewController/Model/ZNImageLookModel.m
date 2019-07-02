//
//  ZNImageLookModel.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/12.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNImageLookModel.h"

@implementation ZNImageLookModel

+ (instancetype)initWithUrl:(NSString*)url{
    ZNImageLookModel * model = [ZNImageLookModel new];
    model.type = ZNImageLookModelResourceURL;
    model.imageUrl = url;
    return model;
}

+ (instancetype)initWithImage:(UIImage*) image{
    ZNImageLookModel * model = [ZNImageLookModel new];
    model.type = ZNImageLookModelResourceImage;
    model.image = image;
    return model;
}

@end

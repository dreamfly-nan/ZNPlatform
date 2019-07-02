//
//  ZNCommentImageModel.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/11.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNCommentImageModel.h"

@implementation ZNCommentImageModel

#pragma mark - public

+ (instancetype)initWithImage:(UIImage*) image{
    ZNCommentImageModel * model = [ZNCommentImageModel new];
    model.cellType = ZNCommentImageCellTypeImage;
    model.image = image;
    model.resourceType = ZNCommentImageCellResourceImage;
    return model;
}

+ (instancetype)initWithImageUrl:(NSString*) imageUrl{
    ZNCommentImageModel * model = [ZNCommentImageModel new];
    model.cellType = ZNCommentImageCellTypeImage;
    model.imageUrl = imageUrl;
    model.resourceType = ZNCommentImageCellResourceURL;
    return model;
}

+ (instancetype)initWithAddType:(ZNCommentImageCellType) type{
    ZNCommentImageModel * model = [ZNCommentImageModel new];
    model.cellType = ZNCommentImageCellTypeAddImage;
    return model;
}

@end

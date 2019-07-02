//
//  ZNImageLookViewManager.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/12.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNImageLookViewManager.h"

@implementation ZNImageLookViewManager

#pragma mark - public

- (void)setImageUrls:(NSArray<NSString*>*) imageUrls{
    [self.imageModels removeAllObjects];
    for (NSString * url in imageUrls) {
        ZNImageLookModel * model = [ZNImageLookModel initWithUrl:url];
        [self.imageModels addObject:model];
    }
}

- (void)setImages:(NSArray<UIImage*>*) images{
    [self.imageModels removeAllObjects];
    for (UIImage * image in images) {
        ZNImageLookModel * model = [ZNImageLookModel initWithImage:image];
        [self.imageModels addObject:model];
    }
}

#pragma mark - get

- (NSMutableArray<ZNImageLookModel *> *)imageModels{
    if (!_imageModels) {
        _imageModels = [NSMutableArray new];
    }
    return _imageModels;
}

@end

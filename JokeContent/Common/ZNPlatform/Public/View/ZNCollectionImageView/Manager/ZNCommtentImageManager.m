//
//  ZNCommtentImageManager.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/11.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNCommtentImageManager.h"

@interface ZNCommtentImageManager()

//长按选中的cell
@property(nonatomic,strong) ZNBaseCollectionViewCell * longCellView;

//长按选择的cell的model
@property(nonatomic,strong) ZNCommentImageModel * longModel;

@end

@implementation ZNCommtentImageManager

#pragma mark - ZNCImageCollectionViewCellDelegate

- (void)longTouchAction:(ZNBaseCollectionViewCell *)cell model:(ZNCommentImageModel *)model{
    //10.0系统以上的做震动反馈
    if (@available(iOS 10.0 , *)) {
        //震动反馈
        UIImpactFeedbackGenerator *feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
        [feedBackGenertor impactOccurred];
    }
    
    self.longCellView = cell;
    self.longModel = model;
}

#pragma mark - public

- (void)setImageUrls:(NSArray<NSString*> *) urls{
    [self.imageModels removeAllObjects];
    for (NSString * url in urls) {
        ZNCommentImageModel * model = [ZNCommentImageModel initWithImageUrl:url];
        model.loadFeilImageName = self.loadFieldImageName;
        [self.imageModels addObject:model];
    }
    
    if (!self.onlyLook) {
        [self.imageModels addObject:self.addModel];
    }
    
}

- (void)setImages:(NSArray<UIImage*> *) images{
    [self.imageModels removeAllObjects];
    for (UIImage * image in images) {
        ZNCommentImageModel * model = [ZNCommentImageModel initWithImage:image];
        model.loadFeilImageName = self.loadFieldImageName;
        [self.imageModels addObject:model];
    }
    if (!self.onlyLook) {
        [self.imageModels addObject:self.addModel];
    }
}

- (void)checkMaxNum{
    if (!self.onlyLook) {
        if ([self.imageModels containsObject:self.addModel]) {
            if (self.maxNum != -1 && self.maxNum < self.imageModels.count) {
                [self.imageModels removeObject:self.addModel];
            }
        }else{
            if (self.maxNum != -1 && self.maxNum > self.imageModels.count) {
                [self.imageModels addObject:self.addModel];
            }
        }
        
    }
}

/// 添加图片
/// @param image <#image description#>
- (void)addImage:(UIImage*) image{
    ZNCommentImageModel * model = [ZNCommentImageModel initWithImage:image];
    model.loadFeilImageName = self.loadFieldImageName;
    [self.imageModels insertObject:model atIndex:self.imageModels.count-1];
}

#pragma mark - set

- (void)setOnlyLook:(BOOL)onlyLook{
    _onlyLook = onlyLook;
    if ([self.imageModels containsObject:self.addModel]) {
        if (onlyLook) {
            [self.imageModels removeObject:self.addModel];
        }
    }else{
        if (!onlyLook) {
            [self.imageModels addObject:self.addModel];
        }
    }
}

#pragma mark - get

- (ZNCommentImageModel *)addModel{
    if (!_addModel) {
        _addModel = [ZNCommentImageModel initWithAddType:ZNCommentImageCellTypeAddImage];
        _addModel.addImageName = self.addImageName;
    }
    return _addModel;
}

- (NSMutableArray<ZNCommentImageModel *> *)imageModels{
    if (!_imageModels) {
        _imageModels = [NSMutableArray new];
    }
    return _imageModels;
}

@end

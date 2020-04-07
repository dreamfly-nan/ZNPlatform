//
//  ZNCommtentImageManager.h
//  JokeContent
//
//  Created by 南木南木 on 2019/6/11.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZNCommentImageModel.h"
#import "ZNCImageCollectionViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZNCommtentImageManager : NSObject

/// 自定义的添加图片
@property (nonatomic , copy) NSString * addImageName;

/// 自定义的加载失败图片
@property (nonatomic , copy) NSString * loadFieldImageName;

@property(nonatomic,strong) NSMutableArray<ZNCommentImageModel*> * imageModels;

@property(nonatomic,strong) ZNCommentImageModel * addModel;

//图片最大数量 -1为不限制图片数量
@property (nonatomic , assign) int maxNum;

//只能查看
@property(nonatomic,assign) BOOL onlyLook;

- (void)setImageUrls:(NSArray<NSString*> *) urls;

- (void)setImages:(NSArray<UIImage*> *) images;

/// 检查是否达到最大图片数量
- (void)checkMaxNum;

/// 添加图片
/// @param image <#image description#>
- (void)addImage:(UIImage*) image;

@end

NS_ASSUME_NONNULL_END

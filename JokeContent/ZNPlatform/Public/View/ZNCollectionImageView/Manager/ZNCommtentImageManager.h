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

@interface ZNCommtentImageManager : NSObject <ZNCImageCollectionViewCellDelegate>

@property(nonatomic,strong) NSMutableArray<ZNCommentImageModel*> * imageModels;

@property(nonatomic,strong) NSMutableArray<UIImage*> * newAddImages;

@property(nonatomic,strong) ZNCommentImageModel * addModel;

- (void)setImageUrls:(NSArray<NSString*> *) urls;

- (void)setImages:(NSArray<UIImage*> *) images;

@end

NS_ASSUME_NONNULL_END

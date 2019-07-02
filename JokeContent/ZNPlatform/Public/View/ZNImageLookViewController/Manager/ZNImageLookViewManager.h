//
//  ZNImageLookViewManager.h
//  JokeContent
//
//  Created by 南木南木 on 2019/6/12.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZNImageLookModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZNImageLookViewManager : NSObject

@property(nonatomic,strong) NSMutableArray<ZNImageLookModel*> * imageModels;

//当前页码
@property(nonatomic,assign) int currentNumber;

- (void)setImageUrls:(NSArray<NSString*>*) imageUrls;

- (void)setImages:(NSArray<UIImage*>*) images;

@end

NS_ASSUME_NONNULL_END

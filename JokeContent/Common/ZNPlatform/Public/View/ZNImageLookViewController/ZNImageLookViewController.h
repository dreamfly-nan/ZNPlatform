//
//  ZNImageLookViewController.h
//  JokeContent
//
//  Created by 南木南木 on 2019/6/12.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNImageLookModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZNImageLookViewController : ZNBaseViewController

- (void)setImages:(NSArray<UIImage*> *) images;

- (void)setImageUrls:(NSArray<NSString*> *) imageUrls;

- (void)addImageWithModel:(ZNImageLookModel*) imageModel;

/**
 设置当前的页码

 @param numebr <#numebr description#>
 */
- (void)setCurrentpageNumber:(int) numebr;

@end

NS_ASSUME_NONNULL_END

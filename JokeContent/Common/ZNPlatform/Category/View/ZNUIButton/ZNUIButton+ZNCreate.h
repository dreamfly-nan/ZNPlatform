//
//  ZNUIButton+ZNCreate.h
//  JokeContent
//
//  Created by 南木南木 on 2019/9/29.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNUIButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZNUIButton (ZNCreate)

/**
 设置文字跟图片之间的距离
 */
- (ZNUIButton * (^)(CGFloat imageSpace))zn_imageSpace;

/**
 设置图片的位置
 */
- (ZNUIButton * (^)(UIButtonImagePositionType positionType))zn_positionType;

@end

NS_ASSUME_NONNULL_END

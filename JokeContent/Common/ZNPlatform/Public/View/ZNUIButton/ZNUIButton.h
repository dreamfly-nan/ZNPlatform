//
//  ZNUIButton.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/29.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 图片的位置类型
 
 - UIButtonImagePositionTypeTop: 图片在上
 - UIButtonImagePositionTypeBottom: 图片在下
 - UIButtonImagePositionTypeLeft: 图片在左
 - UIButtonImagePositionTypeRight: 图片在右
 */
typedef NS_ENUM(NSUInteger,UIButtonImagePositionType){
    UIButtonImagePositionTypeTop        =   1,
    UIButtonImagePositionTypeBottom     =   2,
    UIButtonImagePositionTypeLeft       =   3,
    UIButtonImagePositionTypeRight      =   4
};

@interface ZNUIButton : UIButton

/**
 图片位置
 */
@property(nonatomic,assign) UIButtonImagePositionType positionType;

/**
 图片跟标题的间隔
 */
@property(nonatomic,assign) CGFloat imageSpace;

@end

NS_ASSUME_NONNULL_END

//
//  ZNUIButton+ZNCreate.m
//  JokeContent
//
//  Created by 南木南木 on 2019/9/29.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNUIButton+ZNCreate.h"

@implementation ZNUIButton (ZNCreate)

/**
 设置文字跟图片之间的距离
 */
- (ZNUIButton * (^)(CGFloat imageSpace))zn_imageSpace{
    return ^(CGFloat imageSpace){
        self.imageSpace = imageSpace;
        return self;
    };
}

/**
 设置图片的位置
 */
- (ZNUIButton * (^)(UIButtonImagePositionType positionType))zn_positionType{
    return ^(UIButtonImagePositionType positionType){
        self.positionType = positionType;
        return self;
    };
}

@end

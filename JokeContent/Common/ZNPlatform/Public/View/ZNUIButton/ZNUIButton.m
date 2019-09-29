//
//  ZNUIButton.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/29.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNUIButton.h"

@implementation ZNUIButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self initImagePostion];
}

/**
 初始化基础数据
 */
- (void)config{
    self.positionType = UIButtonImagePositionTypeLeft;
    self.imageSpace = zn_AutoWidth(3);
}

/**
 根据数据进行布局
 */
- (void)initImagePostion{
    if (self.positionType != 0) {
        switch (self.positionType) {
            case UIButtonImagePositionTypeTop:
                if (self.imageSpace != 0) {
                    [self zn_setImageTopPositionSpace:self.imageSpace];
                }
                break;
            case UIButtonImagePositionTypeBottom:
                if (self.imageSpace != 0) {
                    [self zn_setImageBottomPositionSpace:self.imageSpace];
                }
                break;
            case UIButtonImagePositionTypeLeft:
                if (self.imageSpace != 0) {
                    [self zn_setImageLeftPositionSpace:self.imageSpace];
                }
                break;
            case UIButtonImagePositionTypeRight:
                if (self.imageSpace != 0) {
                    [self zn_setImageRightPositionSpace:self.imageSpace];
                }
                break;
        }
    }
}

/**
 图片在下
 
 @param space 图片和title的间隔
 */
- (void)zn_setImageBottomPositionSpace:(CGFloat) space{
    CGFloat x_title = self.width/2 - self.titleLabel.width/2;
    CGFloat x_image = self.width/2 - self.imageView.width/2;
    CGFloat height = self.height - (self.titleLabel.height + self.imageView.height + space);
    
    CGFloat y_title = 0;
    if (height > 0) {
        y_title = height / 2;
    }else{
        height = self.height - (self.titleLabel.height + self.imageView.height);
        if (height > 0) {
            y_title = height / 2;
        }else{
            y_title = 0;
        }
    }
    
    self.titleLabel.zn_ponit = CGPointMake(x_title, y_title);
    self.imageView.zn_ponit = CGPointMake(x_image, y_title + self.titleLabel.height + space);
}

/**
 图片在上
 
 @param space 图片和title的间隔
 */
- (void)zn_setImageTopPositionSpace:(CGFloat) space{
    CGFloat x_title = self.width/2 - self.titleLabel.width/2;
    CGFloat x_image = self.width/2 - self.imageView.width/2;
    CGFloat height = self.height - (self.titleLabel.height + self.imageView.height + space);
    
    CGFloat y_image = 0;
    if (height > 0) {
        y_image = height / 2;
    }else{
        height = self.height - (self.titleLabel.height + self.imageView.height);
        if (height > 0) {
            y_image = height / 2;
        }else{
            y_image = 0;
        }
    }
    self.imageView.zn_ponit = CGPointMake(x_image, y_image);
    self.titleLabel.zn_ponit = CGPointMake(x_title, y_image + self.imageView.height + space);
}

/**
 图片在右
 
 @param space 图片和title的间隔
 */
- (void)zn_setImageRightPositionSpace:(CGFloat) space{
    CGFloat y_image = (self.height - self.imageView.height)/2;
    CGFloat y_title = (self.height - self.titleLabel.height)/2;
    CGFloat width = self.width - (self.imageView.width + self.titleLabel.width + self.imageSpace);
    CGFloat x_title = 0;
    if (width > 0 ) {
        x_title = width / 2;
    }else{
        width = self.width - (self.imageView.width + self.titleLabel.width);
        if (width > 0) {
            x_title = width / 2;
        }else{
            x_title = 0;
        }
    }
    self.titleLabel.zn_ponit = CGPointMake(x_title, y_title);
    self.imageView.zn_ponit = CGPointMake(x_title + self.titleLabel.width + space, y_image);
}

/**
 图片在左
 
 @param space 图片和title的间隔
 */
- (void)zn_setImageLeftPositionSpace:(CGFloat) space{
    CGFloat y_image = (self.height - self.imageView.height)/2;
    CGFloat y_title = (self.height - self.titleLabel.height)/2;
    
    CGFloat width = self.width - (self.imageView.width + self.titleLabel.width + self.imageSpace);
    CGFloat x_image = 0;
    if (width > 0 ) {
        x_image = width / 2;
    }else{
        width = self.width - (self.imageView.width + self.titleLabel.width);
        if (width > 0) {
            x_image = width / 2;
        }else{
            x_image = 0;
        }
    }
    self.titleLabel.zn_ponit = CGPointMake(x_image + self.imageView.width + space, y_title);
    self.imageView.zn_ponit = CGPointMake(x_image, y_image);
}

@end

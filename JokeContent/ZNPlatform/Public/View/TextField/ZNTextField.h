//
//  ZNTextField.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/5.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZNTextField : UIView

@property(nonatomic,strong,readonly) UITextField * textField;

/**
 内容与视图的边距
 */
@property(nonatomic,assign) UIEdgeInsets inset;

/**
 图片距离输入框的距离
 */
@property(nonatomic,assign) CGFloat imageSpace;

/**
 左边的图片
 */
@property(nonatomic,strong) UIImage * leftImage;

/**
 设置图片的大小
 */
@property(nonatomic,assign) CGSize imageSize;

/**
 是否存在左边的视图
 */
@property(nonatomic,assign) BOOL isLeftView;

@end

NS_ASSUME_NONNULL_END

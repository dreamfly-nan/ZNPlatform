//
//  ZNMoveImageView.h
//  JokeContent
//  跟随手指移动的视图控件
//  Created by 南木南木 on 2019/6/11.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZNMoveImageView : UIView

@property(nonatomic,strong) UIImage * image;

@property(nonatomic,strong) UIImageView * moveImageView;

@property (copy , nonatomic) void (^endBlock)(CGPoint point);

@end

NS_ASSUME_NONNULL_END

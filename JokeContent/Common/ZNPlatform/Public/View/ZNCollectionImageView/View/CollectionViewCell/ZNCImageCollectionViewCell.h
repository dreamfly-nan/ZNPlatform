//
//  ZNCImageCollectionViewCell.h
//  JokeContent
//
//  Created by 南木南木 on 2019/6/10.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNCommentImageModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZNCImageCollectionViewCellDelegate <NSObject>

//长按的触发
- (void)longTouchAction:(ZNBaseCollectionViewCell*) cell
                  model:(ZNCommentImageModel*) model
              longPress:(UILongPressGestureRecognizer*) longPress;

//移动
- (void)touchMoveAction:(UILongPressGestureRecognizer*) longPress;

//移动结束
- (void)touchMoveEndAction:(UILongPressGestureRecognizer*) longPress;

//取消移动
- (void)touchMoveCancelAction:(UILongPressGestureRecognizer*) longPress;

@end

@interface ZNCImageCollectionViewCell : ZNBaseCollectionViewCell

@property(nonatomic,strong) ZNCommentImageModel * model;

@property(nonatomic,weak) id<ZNCImageCollectionViewCellDelegate> znDelegate;

@end

NS_ASSUME_NONNULL_END

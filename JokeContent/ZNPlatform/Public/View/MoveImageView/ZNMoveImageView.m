//
//  ZNMoveImageView.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/11.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNMoveImageView.h"

@interface ZNMoveImageView()

@property(nonatomic,assign) CGFloat znScreentWidth;

@end

@implementation ZNMoveImageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setInitUI];
    }
    return self;
}

- (void)setInitUI{
    self.znScreentWidth = screenWidth;
    [self addSubview:self.moveImageView];
    self.moveImageView.sd_layout
    .topEqualToView(self)
    .leftEqualToView(self)
    .rightEqualToView(self)
    .bottomEqualToView(self);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    //求偏移量 = 手指当前点的X - 手指上一个点的X
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint prePoint = [touch previousLocationInView:self];
    
    CGFloat offSetX = currentPoint.x - prePoint.x;
    CGFloat offSetY = currentPoint.y - prePoint.y;

    //平移
    self.transform = CGAffineTransformTranslate(self.transform, offSetX, offSetY);
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
//    if (currentPoint.x > self.znScreentWidth / 2) {
//        self.zn_x = self.znScreentWidth - self.width/2;
//    }else{
//        self.zn_x = - self.width/2;
//    }
}

#pragma mark - set

- (void)setImage:(UIImage *)image{
    _image = image;
    self.moveImageView.image = image;
}

#pragma mark - get

- (UIImageView *)moveImageView{
    if (!_moveImageView) {
        _moveImageView = [UIImageView new];
        _moveImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _moveImageView;
}

@end

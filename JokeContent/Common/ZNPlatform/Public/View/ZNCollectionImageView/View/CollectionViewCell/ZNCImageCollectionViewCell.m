//
//  ZNCImageCollectionViewCell.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/10.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNCImageCollectionViewCell.h"

@interface ZNCImageCollectionViewCell()

@property(nonatomic,strong) UIImageView * znImageView;

@property(nonatomic,strong) UIImageView * addImageView;

@end

@implementation ZNCImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setInitUI];
        [self setBingding];
    }
    return self;
}

- (void)setInitUI{
    [self.contentView addSubview:self.addImageView];
    [self.contentView addSubview:self.znImageView];
    
    self.addImageView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .topEqualToView(self.contentView);
    
    self.znImageView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .topEqualToView(self.contentView);
}

- (void)setBingding{
    UILongPressGestureRecognizer * recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTouchAction:)];
    [self addGestureRecognizer:recognizer];
}

- (void)longTouchAction:(UILongPressGestureRecognizer *)longPress{
    if (self.model.cellType == ZNCommentImageCellTypeAddImage) {
        return;
    }
    if (longPress.state == UIGestureRecognizerStateBegan) {
        if (self.znDelegate && [self.znDelegate respondsToSelector:@selector(longTouchAction:model:longPress:)]) {
            [self.znDelegate longTouchAction:self model:self.model longPress:longPress];
        }
    }else if(longPress.state == UIGestureRecognizerStateChanged){
        if (self.znDelegate && [self.znDelegate respondsToSelector:@selector(touchMoveAction:)]) {
            [self.znDelegate touchMoveAction:longPress];
        }
    }else if(longPress.state == UIGestureRecognizerStateEnded){
        if (self.znDelegate && [self.znDelegate respondsToSelector:@selector(touchMoveEndAction:)]) {
            [self.znDelegate touchMoveEndAction:longPress];
        }
    }else if(longPress.state == UIGestureRecognizerStateCancelled){
        if (self.znDelegate && [self.znDelegate respondsToSelector:@selector(touchMoveCancelAction:)]) {
            [self.znDelegate touchMoveCancelAction:longPress];
        }
    }else if(longPress.state == UIGestureRecognizerStateFailed){
        if (self.znDelegate && [self.znDelegate respondsToSelector:@selector(touchMoveCancelAction:)]) {
            [self.znDelegate touchMoveCancelAction:longPress];
        }
    }
}



#pragma mark - set

- (void)setModel:(ZNCommentImageModel *)model{
    _model = model;
    if (model.cellType == ZNCommentImageCellTypeImage) {
        self.znImageView.hidden = NO;
        self.addImageView.hidden = YES;
        UIImage * placeholderImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"znImageloadFail" ofType:@".png"]];
        if (model.resourceType == ZNCommentImageCellResourceImage) {
            if (model.image == nil) {
                self.znImageView.image = placeholderImage;
            }else{
                self.znImageView.image = model.image;
            }
            
        }else if(model.resourceType == ZNCommentImageCellResourceURL){
            [self.znImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:placeholderImage];
        }
    }else if(model.cellType == ZNCommentImageCellTypeAddImage){
        self.znImageView.hidden = YES;
        self.addImageView.hidden = NO;
    }
}

#pragma mark - get

- (UIImageView *)addImageView{
    if (!_addImageView) {
        _addImageView = [UIImageView new];
        _addImageView.contentMode = UIViewContentModeScaleToFill;
        [_addImageView setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"znImageAdd" ofType:@".png"]]];
    }
    return _addImageView;
}

- (UIImageView *)znImageView{
    if (!_znImageView) {
        _znImageView = [UIImageView new];
        _znImageView.contentMode = UIViewContentModeScaleAspectFill;
        _znImageView.clipsToBounds = YES;
    }
    return _znImageView;
}

@end

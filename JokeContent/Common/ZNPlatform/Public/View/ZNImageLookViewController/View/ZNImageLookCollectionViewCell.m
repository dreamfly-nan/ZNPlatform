//
//  ZNImageLookCollectionViewCell.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/12.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNImageLookCollectionViewCell.h"

@interface ZNImageLookCollectionViewCell()
<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView * contentScrollView;

@property(nonatomic,strong) UIImageView * curImageView;

@end

@implementation ZNImageLookCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setInitUI];
    }
    return self;
}

- (void)setInitUI{
    [self.contentView addSubview:self.contentScrollView];
    [self.contentScrollView addSubview:self.curImageView];
}

- (void)setModel:(ZNImageLookModel *)model{
    _model = model;
    if (model.type == ZNImageLookModelResourceImage) {
        self.curImageView.image = model.image;
        self.curImageView.size = CGSizeMake(screenWidth, screenWidth/model.image.size.width * model.image.size.height);
        self.curImageView.center = CGPointMake(self.contentScrollView.width/2, self.contentScrollView.height/2);
    }else if(model.type == ZNImageLookModelResourceURL){
        znWeakSelf(self)
        [self.curImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            znStrongSelf
            if (image) {
                weakSelf.curImageView.size = CGSizeMake(screenWidth, screenWidth/image.size.width * image.size.height);
                weakSelf.curImageView.center = CGPointMake(weakSelf.contentScrollView.width/2, weakSelf.contentScrollView.height/2);
            }
        }];
    }
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.curImageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    CGSize contentSize = self.contentScrollView.contentSize;
    if (contentSize.height > self.contentScrollView.height) {
        self.curImageView.center = CGPointMake(self.contentScrollView.contentSize.width/2, self.contentScrollView.contentSize.height/2);
    }else{
        self.curImageView.center = CGPointMake(self.contentScrollView.contentSize.width/2, self.contentScrollView.height/2);
    }
}

#pragma mark - get

- (UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:self.contentView.frame];
        _contentScrollView.delegate = self;
        _contentScrollView.maximumZoomScale = 3;
        _contentScrollView.minimumZoomScale = 1;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.showsVerticalScrollIndicator = NO;
    }
    return _contentScrollView;
}

- (UIImageView *)curImageView{
    if (!_curImageView) {
        _curImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        _curImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _curImageView;
}

@end

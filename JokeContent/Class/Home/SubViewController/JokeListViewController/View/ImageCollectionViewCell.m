//
//  ImageCollectionViewCell.m
//  MeetCarefree
//
//  Created by 郑楠楠 on 2018/4/16.
//  Copyright © 2018年 xxf. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@interface ImageCollectionViewCell()

@property (nonatomic , strong) UIImageView * imageView;

@end

@implementation ImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupInitUI];
    }
    return self;
}

- (void)setupInitUI{
    [self.contentView addSubview:self.imageView];
    self.imageView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
}

- (void)setImageURL:(NSString *)imageURL{
    _imageURL = imageURL;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
}

#pragma mark ------imageView-----

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

@end

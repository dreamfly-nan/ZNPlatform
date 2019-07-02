//
//  AdDialogView.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/5/18.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "AdDialogView.h"

@implementation AdDialogView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setInitUI];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)setInitUI{
    [self addSubview:self.imageView];
    [self addSubview:self.contextLabel];
    
    self.imageView.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topEqualToView(self)
    .heightEqualToWidth();
    
    self.contextLabel.sd_layout
    .topSpaceToView(self.imageView, zn_AutoHeight(10))
    .leftEqualToView(self)
    .rightEqualToView(self)
    .autoHeightRatio(0);
}

#pragma mark - get

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

- (UILabel *)contextLabel{
    if (!_contextLabel) {
        _contextLabel = [UILabel new];
        _contextLabel.textColor = [UIColor whiteColor];
        _contextLabel.font = zn_font(15);
        _contextLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contextLabel;
}

@end

//
//  ZNMenuCollectViewCell.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/8.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNMenuCollectViewCell.h"

@interface ZNMenuCollectViewCell()

@property(nonatomic,strong) UIImageView * iconImage;

@property(nonatomic,strong) UILabel * titleLabel;

@end

@implementation ZNMenuCollectViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setInitUI];
    }
    return self;
}

- (void)setInitUI{
    [self.contentView addSubview:self.iconImage];
    [self.contentView addSubview:self.titleLabel];
    
    CGFloat topSpace = (self.width - zn_AutoWidth(35))/2;
    
    self.iconImage.sd_layout
    .topSpaceToView(self.contentView, topSpace)
    .centerXEqualToView(self.contentView)
    .widthIs(zn_AutoWidth(35))
    .heightEqualToWidth();
    
    self.titleLabel.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topSpaceToView(self.iconImage, zn_AutoWidth(0))
    .bottomEqualToView(self.contentView);
}

#pragma mark - set

- (void)setModel:(ZNMentItemModel *)model{
    _model = model;
    if (model.isUrl) {
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
    }else{
        self.iconImage.image = [UIImage imageNamed:model.imageName];
    }
    
    self.titleLabel.text = model.title;
}

#pragma mark - get

- (UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = UIImageView.zn_create.zn_contentMode(UIViewContentModeScaleAspectFill);
    }
    return _iconImage;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = UILabel.zn_create
        .zn_font(zn_font(12))
        .zn_textColor(TITLE_COLOR)
        .zn_alignment(NSTextAlignmentCenter);
    }
    return _titleLabel;
}

@end

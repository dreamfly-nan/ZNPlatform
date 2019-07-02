//
//  RPMyItemCollectionViewCell.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPMyItemCollectionViewCell.h"

@interface RPMyItemCollectionViewCell()

@property (nonatomic , strong) UIImageView *iconImageView;

@property (nonatomic , strong) UILabel *nameLabel;

@end

@implementation RPMyItemCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpInitUI];
    }
    return self;
}

- (void)setUpInitUI{
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.nameLabel];
    
    CGFloat sepaceHeight = (self.height - zn_AutoWidth(55)) / 2;
    
    self.iconImageView.sd_layout
    .topSpaceToView(self.contentView,sepaceHeight)
    .centerXEqualToView(self.contentView)
    .widthIs(zn_AutoWidth(35))
    .heightEqualToWidth();
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.iconImageView, zn_AutoWidth(8))
    .centerXEqualToView(self.contentView)
    .widthIs(self.width)
    .heightIs(zn_AutoWidth(12));
}

- (void)setModel:(RPMyItemModel *)model{
    _model = model;
    self.iconImageView.image = [UIImage imageNamed:model.iconImage];
    self.nameLabel.text = model.name;
}

#pragma mark -------------get-------------

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView  = [UIImageView new];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = zn_font(13);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
//        _nameLabel.textColor = Big_background_Color();
    }
    return _nameLabel;
}

@end

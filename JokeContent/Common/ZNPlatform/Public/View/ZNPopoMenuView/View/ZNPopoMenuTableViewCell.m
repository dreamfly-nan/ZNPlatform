//
//  ZNPopoMenuTableViewCell.m
//  CityManagement
//
//  Created by 南木南木 on 2019/9/3.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "ZNPopoMenuTableViewCell.h"

@interface ZNPopoMenuTableViewCell()

@property(nonatomic,strong) UIImageView * iconImageView;

@property(nonatomic,strong) UILabel * titleLabel;

@end

@implementation ZNPopoMenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setInitUI];
    }
    return self;
}

- (void)setInitUI{
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
    self.iconImageView.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView, zn_AutoWidth(15))
    .widthIs(zn_AutoWidth(20))
    .heightEqualToWidth();
    
    self.titleLabel.sd_layout
    .centerYEqualToView(self.iconImageView)
    .leftSpaceToView(self.iconImageView, zn_AutoWidth(8))
    .rightSpaceToView(self.contentView, zn_AutoWidth(10))
    .heightIs(zn_AutoWidth(15));
}

#pragma mark - get

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = UILabel.zn_create
        .zn_font(zn_font(12))
        .zn_textColor([UIColor whiteColor])
        .zn_alignment(NSTextAlignmentLeft);
    }
    return _titleLabel;
}

@end

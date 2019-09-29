//
//  ZNChooseOneTableViewCell.m
//  CityManagement
//
//  Created by 南木南木 on 2019/8/29.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "ZNChooseOneTableViewCell.h"

@interface ZNChooseOneTableViewCell()

@property(nonatomic,strong) UILabel * titleLabel;

@property(nonatomic,strong) UIView * lineView;

@property(nonatomic,strong) UIImageView * arrowImageView;

@property(nonatomic,strong) UITextField * tipsLabel;

@end

@implementation ZNChooseOneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setInitUI];
    }
    return self;
}

- (void)setInitUI{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.tipsLabel];
    [self.contentView addSubview:self.lineView];
    
    CGFloat width = (screenWidth - zn_AutoWidth(30))/2;
    self.titleLabel.sd_layout
    .topSpaceToView(self.contentView, zn_AutoWidth(17))
    .leftSpaceToView(self.contentView, zn_AutoWidth(15))
    .heightIs(zn_AutoWidth(22))
    .widthIs(zn_AutoWidth(width));
    
    self.arrowImageView.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, zn_AutoWidth(15))
    .widthIs(zn_AutoWidth(10))
    .heightEqualToWidth();
    
    self.tipsLabel.sd_layout
    .centerYEqualToView(self.arrowImageView)
    .rightSpaceToView(self.arrowImageView, zn_AutoWidth(5))
    .leftSpaceToView(self.titleLabel, zn_AutoWidth(5))
    .heightIs(zn_AutoWidth(22));
    
    self.lineView.sd_layout
    .topSpaceToView(self.tipsLabel, zn_AutoWidth(17))
    .leftEqualToView(self.titleLabel)
    .rightEqualToView(self.contentView)
    .heightIs(0.5);
    
    [self setupAutoHeightWithBottomView:self.lineView bottomMargin:0.5];
}

- (void)setModel:(ZNChooseItemModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    self.tipsLabel.placeholder = model.tips;
    if (model.isExtend) {
        self.arrowImageView.image = zn_imageName(@"public_right");
    }else{
        self.arrowImageView.image = zn_imageName(@"public_right");
    }
    if (model.content) {
        self.tipsLabel.text = model.content;
    }
}

#pragma mark - get

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = UILabel.zn_create
        .zn_font(zn_font(16))
        .zn_textColor(TITLE_COLOR)
        .zn_alignment(NSTextAlignmentLeft);
    }
    return _titleLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = LINE_COlOR;
    }
    return _lineView;
}

- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        _arrowImageView.image = zn_imageName(@"");
    }
    return _arrowImageView;
}

- (UITextField *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = UITextField.zn_create
        .zn_font(zn_font(16))
        .zn_textColor(TITLE_COLOR)
        .zn_alignment(NSTextAlignmentRight);
        _tipsLabel.userInteractionEnabled = NO;
    }
    return _tipsLabel;
}

@end

//
//  ZNChooseTwoTableViewCell.m
//  CityManagement
//
//  Created by 南木南木 on 2019/8/29.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "ZNChooseTwoTableViewCell.h"

@interface ZNChooseTwoTableViewCell()

@property(nonatomic,strong) UIImageView * chooseImageView;

@property(nonatomic,strong) UILabel * contentLabel;

@property(nonatomic,strong) UIView * lineView;

@end

@implementation ZNChooseTwoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setInitUI];
    }
    return self;
}

- (void)setInitUI{
    [self.contentView addSubview:self.chooseImageView];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.lineView];
    
    self.chooseImageView.sd_layout
    .topSpaceToView(self.contentView, zn_AutoWidth(15))
    .leftSpaceToView(self.contentView, zn_AutoWidth(30))
    .widthIs(zn_AutoWidth(20))
    .heightEqualToWidth();
    
    self.contentLabel.sd_layout
    .centerYEqualToView(self.chooseImageView)
    .leftSpaceToView(self.chooseImageView, zn_AutoWidth(15))
    .rightSpaceToView(self.contentView, zn_AutoWidth(15))
    .heightIs(zn_AutoWidth(20));
    
    self.lineView.sd_layout
    .topSpaceToView(self.chooseImageView, zn_AutoWidth(15))
    .leftEqualToView(self.chooseImageView)
    .rightEqualToView(self.contentView)
    .heightIs(0.5);
    
    [self setupAutoHeightWithBottomView:self.lineView bottomMargin:0];
}

- (void)setModel:(ZNChooseItemModel *)model{
    _model = model;
    if (model.isChoose) {
        self.chooseImageView.image = zn_imageName(@"project_agress");
    }else{
        self.chooseImageView.image = zn_imageName(@"project_agress_no");
    }
    self.contentLabel.text = model.content;
}

#pragma mark - get

- (UIImageView *)chooseImageView{
    if (!_chooseImageView) {
        _chooseImageView = [UIImageView new];
    }
    return _chooseImageView;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = UILabel.zn_create
        .zn_font(zn_font(16))
        .zn_textColor(TITLE_COLOR)
        .zn_alignment(NSTextAlignmentLeft);
    }
    return _contentLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView zn_getLineViewWithColor:LINE_COlOR];
    }
    return _lineView;
}

@end

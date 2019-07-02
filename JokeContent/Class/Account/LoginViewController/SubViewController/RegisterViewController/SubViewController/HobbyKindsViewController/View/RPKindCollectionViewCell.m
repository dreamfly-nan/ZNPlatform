//
//  RPKindCollectionViewCell.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/5.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPKindCollectionViewCell.h"
@interface RPKindCollectionViewCell()

@property (nonatomic , strong) UIImageView *selectImageView;

@property (nonatomic , strong) UIImageView *kindImageView;

@property (nonatomic , strong) UILabel * kindNameLabel;

@end

@implementation RPKindCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpInitUI];
    }
    return self;
}

- (void)setUpInitUI{
    [self.contentView addSubview:self.kindImageView];
    [self.contentView addSubview:self.selectImageView];
    [self.contentView addSubview:self.kindNameLabel];
    
    self.kindImageView.sd_layout
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.contentView, zn_AutoHeight(5))
    .widthIs(zn_AutoWidth(65))
    .heightEqualToWidth();
    
    self.selectImageView.sd_layout
    .bottomEqualToView(self.kindImageView)
    .rightEqualToView(self.kindImageView)
    .widthIs(zn_AutoWidth(25))
    .heightEqualToWidth();
    
    self.kindNameLabel.sd_layout
    .topSpaceToView(self.kindImageView, zn_AutoHeight(5))
    .centerXEqualToView(self.kindImageView)
    .autoHeightRatio(0);
    [self.kindNameLabel setSingleLineAutoResizeWithMaxWidth:zn_AutoWidth(80)];
}

- (void)setModel:(RPKindsModel *)model{
    _model = model;
    self.kindImageView.image = [UIImage imageNamed:model.iconUrl];
    self.kindNameLabel.text = model.name;
    if (model.isSelect) {
        self.selectImageView.hidden = NO;
    }else{
        self.selectImageView.hidden = YES;
    }
}

#pragma mark ----------get---------

- (UIImageView *)selectImageView{
    if (!_selectImageView) {
        _selectImageView = [UIImageView new];
        _selectImageView.contentMode = UIViewContentModeScaleAspectFit;
        _selectImageView.image = [UIImage imageNamed:@"kinds_select"];
    }
    return _selectImageView;
}

- (UIImageView *)kindImageView{
    if (!_kindImageView) {
        _kindImageView = [UIImageView new];
        _kindImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _kindImageView;
}

- (UILabel *)kindNameLabel{
    if (!_kindNameLabel) {
        _kindNameLabel = [UILabel new];
        _kindNameLabel.textColor = Title_Color();
        _kindNameLabel.font = zn_font(15);
    }
    return _kindNameLabel;
}

@end

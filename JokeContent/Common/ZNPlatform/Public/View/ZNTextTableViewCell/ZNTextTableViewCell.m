//
//  ZNTextTableViewCell.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/1.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNTextTableViewCell.h"

@interface ZNTextTableViewCell()

/**
 经历过首次初始化
 */
@property(nonatomic,assign) BOOL isInitEnd;

@end

@implementation ZNTextTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryNone;
        [self setInitUI];
    }
    return self;
}

- (void)setInitUI{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.lineView];
    if (![self setUILayout]) {
    
        self.titleLabel.sd_layout
        .topSpaceToView(self.contentView, zn_AutoWidth(17))
        .leftSpaceToView(self.contentView, zn_AutoWidth(15))
        .widthIs(zn_AutoWidth(120))
        .heightIs(zn_AutoWidth(16));
        
        self.arrowImageView.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, zn_AutoWidth(15))
        .widthIs(zn_AutoWidth(10))
        .heightEqualToWidth();
        
        self.contentLabel.sd_layout
        .rightSpaceToView(self.contentView, zn_AutoWidth(30))
        .centerYEqualToView(self.titleLabel)
        .leftSpaceToView(self.titleLabel, zn_AutoWidth(50))
        .autoHeightRatio(0);
        
        [self setupAutoHeightWithBottomView:self.contentLabel bottomMargin:zn_AutoWidth(16)];
    }
}

- (BOOL) setUILayout{
    return NO;
}

- (void)setModel:(ZNTextCellModel *)model{
    _model = model;
    
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
    
    self.arrowImageView.hidden = !model.isShowArrow;
    
    if (model.selectType) {
        self.selectionStyle = UITableViewCellSelectionStyleGray;
    }else{
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (!self.isInitEnd) {
        if (model.lineType != ZNTextTableViewCellLineTypeNone) {
            [self.contentView addSubview:self.lineView];
            if (model.lineType == ZNTextTableViewCellLineTypeLeft) {
                self.lineView.sd_layout
                .bottomEqualToView(self.contentView)
                .leftSpaceToView(self.contentView, zn_AutoWidth(15))
                .rightSpaceToView(self.contentView, zn_AutoWidth(15))
                .heightIs(0.5);
            }else if(model.lineType == ZNTextTableViewCellLineTypeWithTitle){
                self.lineView.sd_layout
                .bottomEqualToView(self.contentView)
                .leftEqualToView(self.titleLabel)
                .rightSpaceToView(self.contentView, zn_AutoWidth(15))
                .heightIs(0.5);
            }else if(model.lineType == ZNTextTableViewCellLineTypeAll){
                self.lineView.sd_layout
                .bottomEqualToView(self.contentView)
                .leftEqualToView(self.contentView)
                .rightEqualToView(self.contentView)
                .heightIs(0.5);
            }
        }
        self.isInitEnd = YES;
    }
    
    if (!model.isShowArrow) {
        if(model.contentType == ZNTextTableViewCellContentRightSpaceWithSuperView){
            self.contentLabel.sd_layout
            .rightSpaceToView(self.contentView, zn_AutoWidth(15));
        }else if (model.contentType == ZNTextTableViewCellContentRightSpaceWithArrow) {
            self.contentLabel.sd_layout
            .rightSpaceToView(self.contentView, zn_AutoWidth(30));
        }
    }else{
        self.contentLabel.sd_layout
        .rightSpaceToView(self.contentView, zn_AutoWidth(30));
    }
    
    if (model.content && ![model.content isEqualToString:@""]) {
        [self setupAutoHeightWithBottomView:self.contentLabel bottomMargin:zn_AutoWidth(16)];
    }else{
        [self setupAutoHeightWithBottomView:self.titleLabel bottomMargin:zn_AutoWidth(17)];
    }
}

#pragma mark - get

- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
        _arrowImageView.image = zn_imageName(@"public_right");
    }
    return _arrowImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = TITLE_COLOR;
        _titleLabel.font = zn_font(16);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = TITLE_COLOR;
        _contentLabel.font = zn_font(16);
        _contentLabel.textAlignment = NSTextAlignmentRight;
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

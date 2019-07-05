//
//  ZNTextFieldTableViewCell.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/1.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNTextFieldTableViewCell.h"

@interface ZNTextFieldTableViewCell()

/**
 经历过首次初始化
 */
@property(nonatomic,assign) BOOL isInitEnd;

@end

@implementation ZNTextFieldTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryNone;
        [self setInitUI];
        [self setBangding];
    }
    return self;
}

- (void)setInitUI{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentField];
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.lineView];
    if (![self setUILayout]) {
        
        self.titleLabel.sd_layout
        .topSpaceToView(self.contentView, zn_AutoWidth(10))
        .leftSpaceToView(self.contentView, zn_AutoWidth(15))
        .widthIs(zn_AutoWidth(120))
        .heightIs(zn_AutoWidth(16));
        
        self.arrowImageView.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, zn_AutoWidth(15))
        .widthIs(zn_AutoWidth(5))
        .heightIs(zn_AutoWidth(15));
        
        self.contentField.sd_layout
        .rightSpaceToView(self.contentView, zn_AutoWidth(30))
        .topSpaceToView(self.contentView, zn_AutoWidth(10))
        .leftSpaceToView(self.titleLabel, zn_AutoWidth(50))
        .heightIs(zn_AutoWidth(20));
        
        [self setupAutoHeightWithBottomView:self.contentField bottomMargin:zn_AutoWidth(8)];
    }
}

- (void)setBangding{
    znWeakSelf(self)
    [[self.contentField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        znStrongSelf
        weakSelf.model.content = weakSelf.contentField.text;
    }];
}

- (BOOL) setUILayout{
    return NO;
}

- (void)setModel:(ZNTextCellModel *)model{
    _model = model;
    
    self.contentField.enabled = !model.look;
    
    self.titleLabel.text = model.title;
    
    self.arrowImageView.hidden = !model.isShowArrow;
    
    self.contentField.text = model.content;
    self.contentField.placeholder = model.placeStr;
    
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
            }
        }
        self.isInitEnd = YES;
    }
    
    if (model.content && ![model.content isEqualToString:@""]) {
        [self setupAutoHeightWithBottomView:self.contentField bottomMargin:zn_AutoWidth(10)];
    }else{
        [self setupAutoHeightWithBottomView:self.titleLabel bottomMargin:zn_AutoWidth(10)];
    }
}

#pragma mark - get

- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [UIImageView new];
        _arrowImageView.contentMode = UIViewContentModeScaleAspectFill;
        _arrowImageView.image = zn_ImagePath(@"zn_cell_arrow", @".png");
    }
    return _arrowImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = Title_Color();
        _titleLabel.font = zn_font(14);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UITextField *)contentField{
    if (!_contentField) {
        _contentField = [UITextField new];
        _contentField.textColor = Title_Color();
        _contentField.font = zn_font(14);
        _contentField.textAlignment = NSTextAlignmentRight;
    }
    return _contentField;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView zn_getLineViewWithColor:Line_Color()];
    }
    return _lineView;
}

@end

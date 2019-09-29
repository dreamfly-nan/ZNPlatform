//
//  ZNTextViewTableViewCell.m
//  CityManagement
//
//  Created by 南木南木 on 2019/9/4.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "ZNTextViewTableViewCell.h"
#import "WKTextView.h"

@interface ZNTextViewTableViewCell()

@property(nonatomic,strong) UILabel * titleLabel;

@property(nonatomic,strong) WKTextView * textView;

@end

@implementation ZNTextViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setInitUI];
        [self setBangding];
    }
    return self;
}

- (void)setInitUI{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textView];
    
    self.titleLabel.sd_layout
    .topSpaceToView(self.contentView, zn_AutoWidth(17))
    .leftSpaceToView(self.contentView, zn_AutoWidth(15))
    .widthIs(zn_AutoWidth(120))
    .heightIs(zn_AutoWidth(16));
    
    self.textView.sd_layout
    .topSpaceToView(self.titleLabel, zn_AutoWidth(18))
    .leftEqualToView(self.titleLabel)
    .rightSpaceToView(self.contentView, zn_AutoWidth(15))
    .heightIs(zn_AutoWidth(111));
    
    [self setupAutoHeightWithBottomView:self.textView bottomMargin:zn_AutoWidth(14)];
}

- (void)setBangding{
    znWeakSelf(self)
    self.textView.textDidChangeBlock = ^(WKTextView * _Nonnull textView) {
        znStrongSelf
        weakSelf.model.content = textView.text;
    };
}

- (void)setModel:(ZNTextCellModel *)model{
    _model = model;
    if (model.look) {
        self.contentView.userInteractionEnabled = NO;
    }else{
        self.contentView.userInteractionEnabled = YES;
    }
    self.titleLabel.text = model.title;
    self.textView.placeStr = model.placeStr;
    self.textView.text = model.content;
    [self setupAutoHeightWithBottomView:self.textView bottomMargin:zn_AutoWidth(14)];
}

#pragma mark - get

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = TITLE_COLOR;
        _titleLabel.font = zn_font(16);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (WKTextView *)textView{
    if (!_textView) {
        _textView = [[WKTextView alloc] init];
        _textView.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
        _textView.roundedCornerRadius = 5;
        _textView.borderWidth = 0.5;
        _textView.showBorder = YES;
        _textView.borderColor = CONTENT_COLOR;
        _textView.placeholderColor = PLACE_COLOR;
        _textView.placeholderFont = zn_font(16);
        _textView.font = zn_font(16);
        _textView.textColor = CONTENT_COLOR;
        _textView.maxLength = 300;
    }
    return _textView;
}

@end

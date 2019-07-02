//
//  ItemTableViewCell.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/23.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "ItemTableViewCell.h"

@interface ItemTableViewCell()

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , strong) UITextField * textField;

@end

@implementation ItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setInitUI];
        [self setBangding];
    }
    return self;
}

- (void)setInitUI{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textField];
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.contentView, zn_AutoWidth(15))
    .topSpaceToView(self.contentView, zn_AutoHeight(10))
    .heightIs(zn_AutoHeight(20))
    .widthIs(zn_AutoWidth(100));
    
    self.textField.sd_layout
    .topSpaceToView(self.contentView, zn_AutoHeight(10))
    .rightSpaceToView(self.contentView, zn_AutoWidth(15))
    .leftSpaceToView(self.titleLabel, zn_AutoWidth(80))
    .heightIs(zn_AutoHeight(20));
    
    [self setupAutoHeightWithBottomViewsArray:@[self.titleLabel,self.textField] bottomMargin:zn_AutoHeight(10)];
}

- (void)setBangding{
    znWeakSelf(self)
    [[self.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        znStrongSelf
        if (x && ![x isEqualToString:@""]) {
            weakSelf.model.context = weakSelf.textField.text;
        }
    }];
}

#pragma mark - set

- (void)setModel:(InformationItemModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    self.textField.text = model.context;
    [self setupAutoHeightWithBottomViewsArray:@[self.titleLabel,self.textField] bottomMargin:zn_AutoHeight(10)];
}

#pragma mark - get

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = zn_font(13);
        _titleLabel.textColor = Content_Color();
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [UITextField new];
        _textField.font = zn_font(13);
        _textField.textColor = Content_Color();
        _textField.textAlignment = NSTextAlignmentRight;
    }
    return _textField;
}

@end

//
//  CommentUserTableViewCell.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/3.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "CommentUserTableViewCell.h"

@interface CommentUserTableViewCell()

//头像
@property (nonatomic , strong) UIImageView * iconImageView;

//昵称
@property (nonatomic , strong) UILabel * nameLabel;

//时间
@property (nonatomic , strong) UILabel * timeLabel;

//评论内容
@property (nonatomic , strong) UILabel * contentLabel;

//点赞
@property (nonatomic , strong) UIButton * themUpBtn;

@end

@implementation CommentUserTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpInitUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpInitUI{
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.themUpBtn];
    [self.contentView addSubview:self.lineView];
    
    self.iconImageView.sd_layout
    .leftSpaceToView(self.contentView, zn_AutoWidth(42))
    .topSpaceToView(self.contentView, zn_AutoWidth(8))
    .widthIs(zn_AutoWidth(24))
    .heightEqualToWidth();
    self.iconImageView.layer.cornerRadius = zn_AutoWidth(12);
    
    self.nameLabel.sd_layout
    .topEqualToView(self.iconImageView).offset(-zn_AutoWidth(3))
    .leftSpaceToView(self.iconImageView, zn_AutoWidth(6))
    .rightSpaceToView(self.contentView, zn_AutoWidth(15))
    .autoHeightRatio(0);
    
    self.timeLabel.sd_layout
    .bottomEqualToView(self.iconImageView).offset(zn_AutoWidth(3))
    .leftSpaceToView(self.iconImageView, zn_AutoWidth(6))
    .rightSpaceToView(self.contentView, zn_AutoWidth(15))
    .autoHeightRatio(0);
    
    self.contentLabel.sd_layout
    .leftSpaceToView(self.contentView, zn_AutoWidth(58))
    .rightSpaceToView(self.contentView, zn_AutoWidth(16))
    .topSpaceToView(self.iconImageView, zn_AutoWidth(8))
    .autoHeightRatio(0);
    
    self.themUpBtn.sd_layout
    .topSpaceToView(self.contentLabel, zn_AutoWidth(3))
    .rightSpaceToView(self.contentView, zn_AutoWidth(10))
    .widthIs(zn_AutoWidth(20))
    .heightIs(zn_AutoWidth(20));
    
    self.lineView.sd_layout
    .topSpaceToView(self.themUpBtn, zn_AutoWidth(10))
    .leftEqualToView(self.iconImageView)
    .rightSpaceToView(self.contentView, zn_AutoWidth(15))
    .heightIs(0.5);
    
    [self setupAutoHeightWithBottomViewsArray:@[self.lineView] bottomMargin:zn_AutoWidth(5)];
}

- (void)setModel:(CommentUserModel *)model{
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.userIcon]];
    self.nameLabel.text = model.userNikeName;
    self.timeLabel.text = model.createTime;
    self.contentLabel.text = model.commentText;
    [self setupAutoHeightWithBottomViewsArray:@[self.lineView] bottomMargin:zn_AutoWidth(5)];
}

#pragma mark - get

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = Line_Color();
    }
    return _lineView;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.clipsToBounds = YES;
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = zn_font(13);
        _contentLabel.textColor = zn_colorString(@"#575555");
    }
    return _contentLabel;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = zn_font(13);
        _nameLabel.textColor = zn_colorString(@"#575555");
    }
    return _nameLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.textColor = zn_colorString(@"#575555");
        _timeLabel.font = zn_font(9);
    }
    return _timeLabel;
}

- (UIButton *)themUpBtn{
    if (!_themUpBtn) {
        _themUpBtn = [UIButton new];
        [_themUpBtn setTitleColor:Introduction_Color() forState:UIControlStateNormal];
        [_themUpBtn setImage:[UIImage imageNamed:@"thum_up"] forState:UIControlStateNormal];
        znWeakSelf(self)
        [[_themUpBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            znStrongSelf
            if (weakSelf.znDelegate && [weakSelf.znDelegate respondsToSelector:@selector(thumUp:)]) {
                [weakSelf.znDelegate thumUp:weakSelf.model];
            }
        }];
    }
    return _themUpBtn;
}

@end

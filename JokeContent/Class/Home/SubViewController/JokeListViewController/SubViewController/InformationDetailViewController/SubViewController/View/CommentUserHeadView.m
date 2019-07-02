//
//  CommentUserHeadView.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/3.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "CommentUserHeadView.h"

@interface CommentUserHeadView()

//头像
@property (nonatomic , strong) UIImageView * iconImageView;

//昵称
@property (nonatomic , strong) UILabel * nameLabel;

//时间
@property (nonatomic , strong) UILabel * timeLabel;

//评论内容
@property (nonatomic , strong) UILabel * contentLabel;

@end

@implementation CommentUserHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(0, 0, screenWidth, 50)]) {
        [self setInitUI];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)setInitUI{
    [self addSubview:self.iconImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.contentLabel];
    
    self.iconImageView.sd_layout
    .leftSpaceToView(self, zn_AutoWidth(18))
    .topSpaceToView(self, zn_AutoWidth(8))
    .widthIs(zn_AutoWidth(24))
    .heightEqualToWidth();
    self.iconImageView.layer.cornerRadius = zn_AutoWidth(12);
    
    self.nameLabel.sd_layout
    .topEqualToView(self.iconImageView).offset(-zn_AutoWidth(3))
    .leftSpaceToView(self.iconImageView, zn_AutoWidth(6))
    .rightSpaceToView(self, zn_AutoWidth(15))
    .autoHeightRatio(0);
    
    self.timeLabel.sd_layout
    .bottomEqualToView(self.iconImageView).offset(zn_AutoWidth(3))
    .leftSpaceToView(self.iconImageView, zn_AutoWidth(6))
    .rightSpaceToView(self, zn_AutoWidth(15))
    .autoHeightRatio(0);
    
    self.contentLabel.sd_layout
    .leftSpaceToView(self, zn_AutoWidth(34))
    .rightSpaceToView(self, zn_AutoWidth(16))
    .topSpaceToView(self.iconImageView, zn_AutoWidth(8))
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:self.contentLabel bottomMargin:zn_AutoWidth(10)];
}

#pragma mark - set

- (void)setModel:(CommentArticleModel *)model{
    _model = model;
    [self.iconImageView sd_setImageWithURL: [NSURL URLWithString:model.fromUserIcon]];
    self.nameLabel.text = model.fromUserName;
    self.timeLabel.text = model.createTime;
    self.contentLabel.text = model.commentText;
    [self setupAutoHeightWithBottomView:self.contentLabel bottomMargin:zn_AutoWidth(10)];
}

#pragma mark - get

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

@end

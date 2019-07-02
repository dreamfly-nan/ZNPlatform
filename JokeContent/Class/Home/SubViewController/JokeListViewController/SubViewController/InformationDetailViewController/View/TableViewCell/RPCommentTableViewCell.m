//
//  RPCommentTableViewCell.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/12.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPCommentTableViewCell.h"

@interface RPCommentTableViewCell()

//头像
@property (nonatomic , strong) UIImageView * iconImageView;

//昵称
@property (nonatomic , strong) UILabel * nameLabel;

//时间
@property (nonatomic , strong) UILabel * timeLabel;

//评论内容
@property (nonatomic , strong) UILabel * contentLabel;

//回复
@property(nonatomic,strong) UILabel * replyLabel;

//点赞
@property (nonatomic , strong) UIButton * themUpBtn;

//留言
@property (nonatomic , strong) UIButton * msgBtn;

@end

@implementation RPCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpInitUI];
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpInitUI{
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.replyLabel];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.msgBtn];
    [self.contentView addSubview:self.themUpBtn];
    
    self.iconImageView.sd_layout
    .leftSpaceToView(self.contentView, zn_AutoWidth(18))
    .topSpaceToView(self.contentView, zn_AutoWidth(8))
    .widthIs(zn_AutoWidth(24))
    .heightEqualToWidth();
    self.iconImageView.layer.cornerRadius = zn_AutoWidth(12);
    
    self.replyLabel.sd_layout
    .centerYEqualToView(self.iconImageView)
    .rightSpaceToView(self.contentView, zn_AutoWidth(15))
    .widthIs(zn_AutoWidth(100))
    .heightIs(zn_AutoWidth(15));
    
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
    .leftSpaceToView(self.contentView, zn_AutoWidth(34))
    .rightSpaceToView(self.contentView, zn_AutoWidth(16))
    .topSpaceToView(self.iconImageView, zn_AutoWidth(8))
    .autoHeightRatio(0);
    
    self.themUpBtn.sd_layout
    .topSpaceToView(self.contentLabel, zn_AutoWidth(3))
    .rightSpaceToView(self.contentView, zn_AutoWidth(10))
    .widthIs(zn_AutoWidth(20))
    .heightIs(zn_AutoWidth(20));
    
    self.msgBtn.sd_layout
    .topSpaceToView(self.contentLabel, zn_AutoWidth(3))
    .rightSpaceToView(self.themUpBtn, zn_AutoWidth(15))
    .widthIs(zn_AutoWidth(20))
    .heightIs(zn_AutoWidth(20));
    
    [self setupAutoHeightWithBottomViewsArray:@[self.themUpBtn,self.msgBtn] bottomMargin:zn_AutoWidth(5)];
}

- (void)setModel:(CommentArticleModel *)model{
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.fromUserIcon]];
    self.nameLabel.text = model.fromUserName;
    self.timeLabel.text = model.createTime;
    self.contentLabel.text = model.commentText;
//    [self.themUpBtn setTitle:[model.thumUp obtainNumber:99] forState:UIControlStateNormal];
//    [self.msgBtn setTitle:[model.messageNum obtainNumber:99] forState:UIControlStateNormal];
    
    [self setupAutoHeightWithBottomViewsArray:@[self.themUpBtn,self.msgBtn] bottomMargin:zn_AutoWidth(5)];
}

#pragma mark ---------------get--------------

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.clipsToBounds = YES;
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}

- (UILabel *)replyLabel{
    if (!_replyLabel) {
        _replyLabel = [UILabel new];
        _replyLabel.textAlignment = NSTextAlignmentRight;
        _replyLabel.font = zn_font(12);
        _replyLabel.textColor = zn_colorString(@"#575555");
        _replyLabel.text = @"回复";
    }
    return _replyLabel;
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
        _themUpBtn.hidden = YES;
        [_themUpBtn setTitleColor:Introduction_Color() forState:UIControlStateNormal];
        [_themUpBtn setImage:[UIImage imageNamed:@"thum_up"] forState:UIControlStateNormal];
        znnBlockSelf(self)
        [[_themUpBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (blockSelf.znDelegate && [blockSelf.znDelegate respondsToSelector:@selector(thumUpBtnAction:)]) {
                [blockSelf.znDelegate thumUpBtnAction:blockSelf.model];
            }
        }];
    }
    return _themUpBtn;
}

- (UIButton *)msgBtn{
    if (!_msgBtn) {
        _msgBtn = [UIButton new];
        _msgBtn.hidden = YES;
        [_msgBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
        [_msgBtn setTitleColor:Introduction_Color() forState:UIControlStateNormal];
        znnBlockSelf(self)
        [[_msgBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (blockSelf.znDelegate && [blockSelf.znDelegate respondsToSelector:@selector(messageBtnAction:)]) {
                [blockSelf.znDelegate messageBtnAction:blockSelf.model];
            }
        }];
    }
    return _msgBtn;
}

@end

//
//  RPDetailCommentView.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/27.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPDetailCommentView.h"

@interface RPDetailCommentView()

@end

@implementation RPDetailCommentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpInit];
        [self setBangding];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)setUpInit{
    [self addSubview:self.lineView];
    [self addSubview:self.commentTextView];
    [self addSubview:self.commentFieldBtn];
    [self addSubview:self.messageBtn];
    [self addSubview:self.thumUpBtn];
    [self addSubview:self.sendCommentBtn];
    
    self.lineView.sd_layout
    .topEqualToView(self)
    .rightEqualToView(self)
    .leftEqualToView(self)
    .heightIs(1);
    
    self.commentTextView.sd_layout
    .leftSpaceToView(self, zn_AutoWidth(15))
    .topSpaceToView(self, zn_AutoHeight(10))
    .rightSpaceToView(self, zn_AutoWidth(15))
    .heightIs(zn_AutoWidth(25));
    self.commentTextView.layer.cornerRadius = zn_AutoHeight(3);
    
    self.commentFieldBtn.sd_layout
    .topEqualToView(self.commentTextView)
    .leftEqualToView(self.commentTextView)
    .rightEqualToView(self.commentTextView)
    .bottomEqualToView(self.commentTextView);
    
    self.messageBtn.sd_layout
    .topSpaceToView(self.commentTextView, zn_AutoWidth(5))
    .leftSpaceToView(self, zn_AutoWidth(15))
    .widthIs(zn_AutoWidth(20))
    .heightIs(zn_AutoWidth(20));
    
    self.messageBtn.sd_layout
    .topEqualToView(self.thumUpBtn)
    .leftSpaceToView(self.thumUpBtn, zn_AutoWidth(10))
    .widthIs(zn_AutoWidth(20))
    .heightIs(zn_AutoWidth(20));

    self.sendCommentBtn.sd_layout
    .centerYEqualToView(self.messageBtn)
    .rightSpaceToView(self, zn_AutoWidth(15))
    .widthIs(zn_AutoWidth(50))
    .heightIs(zn_AutoWidth(20));
    [self.sendCommentBtn setSd_cornerRadius:@5];
    
    [self setupAutoHeightWithBottomViewsArray:@[self.sendCommentBtn,self.thumUpBtn,self.messageBtn] bottomMargin:zn_AutoHeight(10)];
}

- (void)setBangding{
    znWeakSelf(self)
    [[self.commentFieldBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        if (weakSelf.znDelegate && [weakSelf.znDelegate respondsToSelector:@selector(showInputComment)]) {
            [weakSelf.znDelegate showInputComment];
        }
    }];
    
    [[self.sendCommentBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        if (weakSelf.znDelegate && [weakSelf.znDelegate respondsToSelector:@selector(commitComment:)]) {
            [weakSelf.znDelegate commitComment:weakSelf.commentTextView.text];
        }
    }];
    
    [[self.thumUpBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        if (weakSelf.znDelegate && [weakSelf.znDelegate respondsToSelector:@selector(thumUpAritcleBtnAction)]) {
            [weakSelf.znDelegate thumUpAritcleBtnAction];
        }
    }];
    
    [[self.messageBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        if (weakSelf.znDelegate && [weakSelf.znDelegate respondsToSelector:@selector(messageAritcleBtnAction)]) {
            [weakSelf.znDelegate messageAritcleBtnAction];
        }
    }];
}

#pragma mark ------public-------

/**
 更新高度
 */
- (void)upHeight{
    [self setupAutoHeightWithBottomViewsArray:@[self.sendCommentBtn,self.thumUpBtn,self.messageBtn] bottomMargin:zn_AutoHeight(10)];
}

#pragma mark -----------get-----------

- (UIButton *)commentFieldBtn{
    if (!_commentFieldBtn) {
        _commentFieldBtn = [UIButton new];
    }
    return _commentFieldBtn;
}

- (UITextView *)commentTextView{
    if (!_commentTextView) {
        _commentTextView = [UITextView new];
        _commentTextView.userInteractionEnabled = NO;
        [_commentTextView setContentInset: UIEdgeInsetsMake(3, 3, 3, 3)];
        _commentTextView.font = zn_font(12);
        _commentTextView.text = commentPlaceText;
        _commentTextView.textColor = Content_Color();
        _commentTextView.layer.backgroundColor = Big_background_Color().CGColor;
    }
    return _commentTextView;
}

- (UIButton *)messageBtn{
    if (!_messageBtn) {
        _messageBtn = [UIButton new];
        [_messageBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    }
    return _messageBtn;
}

- (UIButton *)thumUpBtn{
    if (!_thumUpBtn) {
        _thumUpBtn = [UIButton new];
        [_thumUpBtn setImage:[UIImage imageNamed:@"thum_up"] forState:UIControlStateNormal];
    }
    return _thumUpBtn;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView zn_getLineView];
        _lineView.backgroundColor = Big_background_Color();
    }
    return _lineView;
}

- (UIButton *)sendCommentBtn{
    if (!_sendCommentBtn) {
        _sendCommentBtn = [UIButton new];
        [_sendCommentBtn setTitle:@"发布" forState:UIControlStateNormal];
        _sendCommentBtn.titleLabel.font = zn_font(12);
        [_sendCommentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendCommentBtn.backgroundColor = Main_Color();
    }
    return _sendCommentBtn;
}

@end

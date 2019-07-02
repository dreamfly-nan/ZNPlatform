//
//  RPDtailFootCommentView.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/12.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPDtailCommentHeadView.h"

@interface RPDtailCommentHeadView()

@property (nonatomic , strong) UILabel * commentLabel;

@property (nonatomic , strong) UIView * lineView;

@end

@implementation RPDtailCommentHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = Big_background_Color();
        [self setUpInitUI];
    }
    return self;
}

- (void)setUpInitUI{
    [self addSubview:self.lineView];
    [self addSubview:self.commentLabel];
    
    self.lineView.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self, zn_AutoWidth(15))
    .rightSpaceToView(self, zn_AutoWidth(15))
    .heightIs(zn_AutoWidth(1));
    
    self.sd_layout
    .centerYEqualToView(self)
    .centerXEqualToView(self)
    .heightIs(zn_AutoWidth(20))
    .widthIs(zn_AutoWidth(50));
}

#pragma mark ---------------get---------------

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = Line_Color();
    }
    return _lineView;
}

- (UILabel *)commentLabel{
    if (!_commentLabel) {
        _commentLabel = [UILabel new];
        _commentLabel.font = zn_Bold_font(16);
        _commentLabel.textColor = Title_Color();
        _commentLabel.backgroundColor = Big_background_Color();
        _commentLabel.text = @"评论";
    }
    return _commentLabel;
}

@end

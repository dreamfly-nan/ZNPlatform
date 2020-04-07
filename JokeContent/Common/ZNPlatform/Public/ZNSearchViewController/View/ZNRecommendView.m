//
//  ZNRecommendView.m
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2019/11/23.
//  Copyright © 2019 ttyx. All rights reserved.
//

#import "ZNRecommendView.h"

@implementation ZNRecommendView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(0, 0, screenWidth, zn_AutoWidth(94))]) {
        [self setInitUI];
        [self setBangding];
    }
    return self;
}

- (void)setInitUI{
    [self addSubview:self.recommendLabel];
    [self addSubview:self.deleteBtn];
    
    self.recommendLabel.sd_layout
    .topSpaceToView(self, zn_AutoWidth(25))
    .leftSpaceToView(self, zn_AutoWidth(15))
    .widthIs(zn_AutoWidth(80))
    .heightIs(zn_AutoWidth(15));
    
    self.deleteBtn.sd_layout
    .centerYEqualToView(self.recommendLabel)
    .rightSpaceToView(self, zn_AutoWidth(15))
    .widthIs(zn_AutoWidth(18))
    .heightEqualToWidth();
}

- (void)setBangding{
    znWeakSelf(self)
    [[self.deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        if (weakSelf.clearHistory) {
            weakSelf.clearHistory();
        }
    }];
}

#pragma mark - set

- (void)setIsShowClear:(BOOL)isShowClear{
    _isShowClear = isShowClear;
    self.deleteBtn.hidden = !isShowClear;
}

#pragma mark - get

- (UILabel *)recommendLabel{
    if (!_recommendLabel) {
        _recommendLabel = [UILabel new];
        _recommendLabel.zn_text(@"推荐搜索")
        .zn_font(zn_font(15))
        .zn_textColor(CONTENT_COLOR)
        .zn_alignment(NSTextAlignmentLeft);
    }
    return _recommendLabel;
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton new];
        _deleteBtn.zn_image(zn_imageName(@"public_trash"),UIControlStateNormal)
        .zn_font(zn_font(12));
        _deleteBtn.zn_expandWidth(zn_AutoWidth(10));
    }
    return _deleteBtn;
}

@end

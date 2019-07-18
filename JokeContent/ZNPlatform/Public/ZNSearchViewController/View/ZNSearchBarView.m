//
//  ZNSearchBarView.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/18.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNSearchBarView.h"


@interface ZNSearchBarView()

@property(nonatomic,strong) UIButton * backBtn;

@end

@implementation ZNSearchBarView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addView];
        [self setInitUI];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)addView{
    [self addSubview:self.searchText];
    [self addSubview:self.backBtn];
}

- (void)setInitUI{
    self.backBtn.sd_layout
    .topSpaceToView(self, zn_AutoWidth(5))
    .bottomSpaceToView(self, zn_AutoWidth(5))
    .leftSpaceToView(self,0)
    .widthIs(zn_AutoWidth(60));
    
    self.searchText.sd_layout
    .centerYEqualToView(self)
    .heightIs(zn_AutoWidth(25))
    .leftSpaceToView(self.backBtn, self.leftSpace)
    .rightSpaceToView(self, zn_AutoWidth(20));
}

#pragma mark - get

- (ZNTextField *)searchText{
    if (!_searchText) {
        _searchText = [[ZNTextField alloc] init];
    }
    return _searchText;
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = UIButton.zn_create
        .zn_title(@"返回",UIControlStateNormal)
        .zn_titleColor(Title_Color(),UIControlStateNormal)
        .zn_font(zn_font(13));
        znWeakSelf(self)
       [[_backBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
           znStrongSelf
           if (weakSelf.backBlock) {
               weakSelf.backBlock();
           }
       }];
    }
    return _backBtn;
}

@end

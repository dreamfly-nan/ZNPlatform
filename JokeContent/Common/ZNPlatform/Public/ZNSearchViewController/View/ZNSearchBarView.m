//
//  ZNSearchBarView.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/18.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNSearchBarView.h"

@interface ZNSearchBarView() <UITextFieldDelegate>

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
    .centerYEqualToView(self)
    .leftSpaceToView(self,0)
    .heightIs(zn_AutoWidth(20))
    .widthIs(zn_AutoWidth(40));
    
    self.searchText.sd_layout
    .centerYEqualToView(self)
    .heightIs(zn_AutoWidth(25))
    .leftSpaceToView(self.backBtn, self.leftSpace)
    .rightSpaceToView(self, zn_AutoWidth(20));
}

#pragma mark - get

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length > 0) {
        if(self.searchBlock){
            self.searchBlock(textField.text);
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - get

- (ZNTextField *)searchText{
    if (!_searchText) {
        _searchText = [[ZNTextField alloc] init];
        _searchText.textField.delegate = self;
        _searchText.zn_font(zn_font(13));
    }
    return _searchText;
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = UIButton.zn_create
        .zn_titleColor(TITLE_COLOR,UIControlStateNormal)
        .zn_font(zn_font(13))
        .zn_image(zn_ImagePath(@"zn_search_back", @".png"),UIControlStateNormal)
        .zn_ImageContentMode(UIViewContentModeScaleAspectFit);
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

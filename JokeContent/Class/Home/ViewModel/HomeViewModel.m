//
//  HomeViewModel.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/18.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "HomeViewModel.h"

@interface HomeViewModel()
<ZNTextTabBarViewDelegate,
ZNTabBarContentViewDelegate>

@end

@implementation HomeViewModel

- (void) setUpInitUI{
    
    self.controller.view.backgroundColor = [UIColor whiteColor];
    [self.controller.view addSubview:self.tableViewHeadView];
    [self.controller.view addSubview:self.textBarView];
    [self.controller.view addSubview:self.contentView];
    [self.controller.view addSubview:self.moreFunctionBtn];
    
    self.tableViewHeadView.sd_layout
    .topSpaceToView(self.controller.view, znStateHeight)
    .leftEqualToView(self.controller.view)
    .rightEqualToView(self.controller.view)
    .autoHeightRatio(0);
    
    self.textBarView.sd_layout
    .topSpaceToView(self.tableViewHeadView, zn_AutoHeight(0))
    .leftEqualToView(self.controller.view)
    .rightSpaceToView(self.controller.view, zn_AutoWidth(40))
    .heightIs(zn_AutoHeight(40));
    
    self.contentView.sd_layout
    .topSpaceToView(self.textBarView, zn_AutoHeight(0))
    .leftEqualToView(self.controller.view)
    .rightEqualToView(self.controller.view)
    .bottomEqualToView(self.controller.view);
    
    self.moreFunctionBtn.sd_layout
    .rightEqualToView(self.controller.view)
    .leftSpaceToView(self.textBarView, 0)
    .centerYEqualToView(self.textBarView)
    .heightIs(zn_AutoHeight(40));
    [self setBangding];
}

- (void)setBangding{
    znWeakSelf(self)
    [RACObserve([RPConfig sharedInstance].userData, iconUrl) subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        if (x && ![x isEqualToString:@""]) {
            [weakSelf.logoImageView sd_setImageWithURL:[NSURL URLWithString:[RPConfig sharedInstance].userData.iconUrl] placeholderImage:[UIImage imageNamed:UserIconPlaceHoldImage]];
        }
    }];
}

#pragma mark ---------ZNTextTabBarViewDelegate----------

/**
 被选中的时候进行调用
 
 @param index 选中项的序号
 @param model 选中项的数据
 */
- (void)selectItemWithIndex:(int) index
                      model:(ZNTitleModel *)model{
    [self.contentView scrollToIndex:index];
}

#pragma mark ---------ZNTabBarContentViewDelegate----------

- (void)scrollToindex:(int)index{
    [self.textBarView scrollToIndex:index];
}

#pragma mark ----------get-----------

- (UIButton *)searchBtn{
    if (!_searchBtn) {
        _searchBtn = [UIButton new];
    }
    return _searchBtn;
}

- (ZNTextTabBarView *)textBarView{
    if (!_textBarView) {
        _textBarView = [[ZNTextTabBarView alloc] init];
        _textBarView.lineType = ZNTextTabBarViewLineStypeWithText;
        _textBarView.lineColor = Main_Color();
        _textBarView.interval = zn_AutoWidth(10);
        _textBarView.znDelegate = self;
        _textBarView.isRoundLine = YES;
        _textBarView.backgroundColor = [UIColor whiteColor];
    }
    return _textBarView;
}

- (ZNTabBarContentView *)contentView{
    if (!_contentView) {
        _contentView = [[ZNTabBarContentView alloc] init];
        _contentView.znDelegate = self;
        _contentView.superViewController = self.controller;
    }
    return _contentView;
}

- (UIView *)tableViewHeadView{
    if (!_tableViewHeadView) {
        _tableViewHeadView = [UIView new];
        _tableViewHeadView.backgroundColor = [UIColor whiteColor];
        [_tableViewHeadView addSubview:self.logoImageView];
        [_tableViewHeadView addSubview:self.searchTextField];
        [_tableViewHeadView addSubview:self.accountBtn];
        [_tableViewHeadView addSubview:self.searchBtn];
        
        self.logoImageView.sd_layout
        .leftSpaceToView(_tableViewHeadView, zn_AutoWidth(10))
        .topSpaceToView(_tableViewHeadView, zn_AutoWidth(13))
        .widthIs(zn_AutoHeight(20))
        .heightIs(zn_AutoHeight(20));
        self.logoImageView.layer.cornerRadius = zn_AutoHeight(10);
        
        self.searchTextField.sd_layout
        .topSpaceToView(_tableViewHeadView, zn_AutoWidth(10))
        .leftSpaceToView(self.logoImageView, zn_AutoWidth(15))
        .rightSpaceToView(_tableViewHeadView, zn_AutoWidth(15))
        .heightIs(zn_AutoHeight(27));
        
        self.accountBtn.sd_layout
        .topEqualToView(self.logoImageView)
        .leftEqualToView(_tableViewHeadView)
        .rightSpaceToView(self.searchTextField, 0)
        .bottomEqualToView(self.logoImageView);
        
        self.searchBtn.sd_layout
        .topEqualToView(self.searchTextField)
        .leftEqualToView(self.searchTextField)
        .rightEqualToView(self.searchTextField)
        .bottomEqualToView(self.searchTextField);
        
        [_tableViewHeadView setupAutoHeightWithBottomView:self.searchTextField bottomMargin:zn_AutoHeight(5)];
        
        [_tableViewHeadView setupAutoHeightWithBottomViewsArray:@[self.logoImageView] bottomMargin:zn_AutoHeight(10)];
        [_tableViewHeadView layoutSubviews];
    }
    return _tableViewHeadView;
}

- (UIButton *)accountBtn{
    if (!_accountBtn) {
        _accountBtn = [UIButton new];
    }
    return _accountBtn;
}

- (UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [UIImageView new];
        _logoImageView.image = [UIImage imageNamed:UserIconPlaceHoldImage];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _logoImageView.clipsToBounds = YES;
    }
    return _logoImageView;
}

- (UIButton *)moreFunctionBtn{
    if (!_moreFunctionBtn) {
        _moreFunctionBtn = [UIButton new];
        [_moreFunctionBtn setImage:[UIImage imageNamed:@"more_function"] forState:UIControlStateNormal];
    }
    return _moreFunctionBtn;
}

- (UIImageView *)leftSearchTextImageView{
    if (!_leftSearchTextImageView) {
        _leftSearchTextImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
        _leftSearchTextImageView.frame = CGRectMake(zn_AutoWidth(8), zn_AutoHeight(6), zn_AutoHeight(15), zn_AutoHeight(15));
    }
    return _leftSearchTextImageView;
}

- (RPSearchTextField *)searchTextField{
    if (!_searchTextField) {
        _searchTextField = [RPSearchTextField new];
        _searchTextField.leftView = self.leftSearchTextImageView;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        _searchTextField.left_distance = zn_AutoWidth(8);
        _searchTextField.placeholder = @"请输入关键字";
        _searchTextField.backgroundColor = Big_background_Color();
        _searchTextField.layer.cornerRadius = 5;
        _searchTextField.font = zn_font(12);
        _searchTextField.textAlignment = NSTextAlignmentCenter;
    }
    return _searchTextField;
}

@end

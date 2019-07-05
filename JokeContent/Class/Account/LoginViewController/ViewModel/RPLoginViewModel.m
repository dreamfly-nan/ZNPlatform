//
//  RPLoginViewModel.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/22.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPLoginViewModel.h"

@interface RPLoginViewModel ()

@property (nonatomic , strong) UIImageView *accountImage;

@property (nonatomic , strong) UIImageView *passworldImage;

@end

@implementation RPLoginViewModel

- (void)setupInitUI{
    [self.controller.view addSubview:self.titleLabel];
    [self.controller.view addSubview:self.accountText];
    UIView *accountLine = [UIView zn_getLineViewWithColor:Line_Color()];
    [self.controller.view addSubview:accountLine];
    [self.controller.view addSubview:self.passworldText];
    UIView *passworldLine = [UIView zn_getLineViewWithColor:Line_Color()];
    [self.controller.view addSubview:passworldLine];
    [self.controller.view addSubview:self.loginBtn];
    [self.controller.view addSubview:self.registerBtn];
    [self.controller.view addSubview:self.forgetBtn];
    
    self.titleLabel.sd_layout
    .topSpaceToView(self.controller.view, zn_AutoHeight(150))
    .centerXEqualToView(self.controller.view)
    .autoHeightRatio(0);
    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:screenWidth];
    
    self.accountText.sd_layout
    .leftSpaceToView(self.controller.view, zn_AutoWidth(30))
    .rightSpaceToView(self.controller.view, zn_AutoWidth(30))
    .topSpaceToView(self.titleLabel, zn_AutoHeight(65))
    .heightIs(zn_AutoHeight(50));
    
    accountLine.sd_layout
    .leftEqualToView(self.accountText)
    .rightEqualToView(self.accountText)
    .topSpaceToView(self.accountText, 0)
    .heightIs(1);
    
    self.passworldText.sd_layout
    .leftEqualToView(self.accountText)
    .rightEqualToView(self.accountText)
    .topSpaceToView(accountLine, zn_AutoHeight(10))
    .heightIs(zn_AutoHeight(50));
    
    passworldLine.sd_layout
    .leftEqualToView(self.accountText)
    .rightEqualToView(self.accountText)
    .topSpaceToView(self.passworldText, 0)
    .heightIs(1);
    
    self.loginBtn.sd_layout
    .leftEqualToView(self.passworldText)
    .rightEqualToView(self.passworldText)
    .topSpaceToView(passworldLine, zn_AutoHeight(50))
    .heightIs(zn_AutoHeight(34));
    self.loginBtn.layer.cornerRadius = zn_AutoHeight(17);
    
    self.registerBtn.sd_layout
    .leftSpaceToView(self.controller.view, zn_AutoWidth(25))
    .bottomSpaceToView(self.controller.view, zn_AutoHeight(18))
    .widthIs(zn_AutoWidth(40))
    .heightIs(zn_AutoWidth(20));
    
    self.forgetBtn.sd_layout
    .rightSpaceToView(self.controller.view, zn_AutoWidth(25))
    .topEqualToView(self.registerBtn)
    .bottomEqualToView(self.registerBtn)
    .widthIs(zn_AutoWidth(80));
    
    [self setBingding];
}

//绑定界面的相关操作
- (void)setBingding{
    znWeakSelf(self)
    [[self.accountText rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        znStrongSelf
        [weakSelf isEnableBtn];
    }];
    
    [[self.passworldText rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        znStrongSelf
        [weakSelf isEnableBtn];
    }];
}

/**
 判断是否具备登录的条件
 */
- (void)isEnableBtn{
    NSString * account = self.accountText.text;
    NSString * password = self.passworldText.text;
    if (account == nil || password == nil || [account isEqualToString:@""] || [password isEqualToString:@""]) {
        self.loginBtn.alpha = 0.6;
        self.loginBtn.enabled = NO;
    }else{
        self.loginBtn.alpha = 1;
        self.loginBtn.enabled = YES;
    }
}

#pragma mark -------get--------

- (UIImageView *)accountImage{
    if (!_accountImage) {
        _accountImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, zn_AutoWidth(20), zn_AutoWidth(20))];
        _accountImage.image = [UIImage imageNamed:@"account_select"];
    }
    return _accountImage;
}

- (UIImageView *)passworldImage{
    if (!_passworldImage) {
        _passworldImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, zn_AutoWidth(20), zn_AutoWidth(20))];
        _passworldImage.image = [UIImage imageNamed:@"passworld_select"];
    }
    return _passworldImage;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = zn_font(25);
        _titleLabel.text = @"栗子新闻";
        _titleLabel.textColor = Title_Color();
    }
    return _titleLabel;
}

- (RPSearchTextField *)accountText{
    if (!_accountText) {
        _accountText = [RPSearchTextField new];
        _accountText.left_distance = zn_AutoWidth(10);
        _accountText.font = zn_font(15);
        _accountText.placeholder = @"请输入账号";
        _accountText.text = @"15005934304";
        _accountText.textColor = Content_Color();
        _accountText.leftView = self.accountImage;
        _accountText.leftViewMode = UITextFieldViewModeAlways;
        _accountText.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _accountText;
}

- (RPSearchTextField *)passworldText{
    if (!_passworldText) {
        _passworldText = [RPSearchTextField new];
        _passworldText.left_distance = zn_AutoWidth(10);
        _passworldText.font = zn_font(15);
        _passworldText.textColor = Content_Color();
        _passworldText.placeholder = @"请输入密码";
        _passworldText.text = @"123456";
        _passworldText.secureTextEntry = YES;
        _passworldText.leftView = self.passworldImage;
        _passworldText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passworldText.leftViewMode = UITextFieldViewModeAlways;
    }
    return _passworldText;
}

- (UIButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn = [UIButton new];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = zn_font(15);
        [_registerBtn setTitleColor:zn_colorString(@"#263238") forState:UIControlStateNormal];
    }
    return _registerBtn;
}

- (UIButton *)forgetBtn{
    if (!_forgetBtn) {
        _forgetBtn = [UIButton new];
        [_forgetBtn setTitleColor:zn_colorString(@"#263238") forState:UIControlStateNormal];
        [_forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        _forgetBtn.titleLabel.font = zn_font(15);
    }
    return _forgetBtn;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton new];
        _loginBtn.backgroundColor = Main_Color();
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setTitle:@"登  陆" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = zn_font(18);
    }
    return _loginBtn;
}

@end

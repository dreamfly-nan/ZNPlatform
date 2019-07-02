//
//  RPForgetPassworldViewModel.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/25.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPForgetPassworldViewModel.h"

@implementation RPForgetPassworldViewModel

#pragma mark -------public--------

- (void)setupInit{
    [self.viewController.view addSubview:self.accountText];
    UIView *accountLine = [self getLineView];
    [self.viewController.view addSubview:accountLine];
    
    [self.viewController.view addSubview:self.codeText];
    [self.viewController.view addSubview:self.getCodeBtn];
    
    UIView *codeLine = [self getLineView];
    [self.viewController.view addSubview:codeLine];
    
    [self.viewController.view addSubview:self.passworldText];
    UIView * passworldLine = [self getLineView];
    [self.viewController.view addSubview:passworldLine];
    
    [self.viewController.view addSubview:self.aginPassworldText];
    UIView * aginPassworldLine = [self getLineView];
    [self.viewController.view addSubview:aginPassworldLine];
    
    [self.viewController.view addSubview:self.sureBtn];
    
    self.accountText.sd_layout
    .topSpaceToView(self.viewController.view, zn_AutoHeight(37) + [RPConfig sharedInstance].navigationHeight + znStateHeight)
    .leftSpaceToView(self.viewController.view, zn_AutoWidth(24))
    .rightSpaceToView(self.viewController.view, zn_AutoWidth(17))
    .heightIs(zn_AutoHeight(35));
    
    accountLine.sd_layout
    .topSpaceToView(self.accountText, 0)
    .leftEqualToView(self.accountText)
    .rightEqualToView(self.accountText)
    .heightIs(0.5);
    
    self.codeText.sd_layout
    .topSpaceToView(accountLine, zn_AutoHeight(14))
    .leftEqualToView(self.accountText)
    .heightIs(zn_AutoHeight(35))
    .widthIs(zn_AutoWidth(223));
    
    codeLine.sd_layout
    .topSpaceToView(self.codeText, 0)
    .leftEqualToView(self.codeText)
    .rightEqualToView(self.codeText)
    .heightIs(0.5);
    
    self.getCodeBtn.sd_layout
    .leftSpaceToView(self.codeText, zn_AutoWidth(10))
    .rightEqualToView(self.accountText)
    .centerYEqualToView(self.codeText)
    .heightIs(zn_AutoWidth(35));
    
    self.passworldText.sd_layout
    .leftEqualToView(self.accountText)
    .rightEqualToView(self.accountText)
    .heightIs(zn_AutoHeight(35))
    .topSpaceToView(codeLine, zn_AutoHeight(14));
    
    passworldLine.sd_layout
    .leftEqualToView(self.passworldText)
    .rightEqualToView(self.passworldText)
    .topSpaceToView(self.passworldText, 0)
    .heightIs(0.5);
    
    self.aginPassworldText.sd_layout
    .leftEqualToView(self.accountText)
    .rightEqualToView(self.accountText)
    .topSpaceToView(passworldLine, zn_AutoHeight(14))
    .heightIs(zn_AutoHeight(35));
    
    aginPassworldLine.sd_layout
    .topSpaceToView(self.aginPassworldText, 0)
    .leftEqualToView(self.aginPassworldText)
    .rightEqualToView(self.aginPassworldText)
    .heightIs(0.5);
    
    self.sureBtn.sd_layout
    .bottomSpaceToView(self.viewController.view, zn_AutoHeight(149))
    .leftEqualToView(self.accountText)
    .rightEqualToView(self.accountText)
    .heightIs(zn_AutoHeight(35));
    
    [self setBingding];
}

//获取线条
- (UIView *)getLineView{
    UIView *view = [UIView new];
    view.backgroundColor = Line_Color();
    return view;
}

- (void)setBingding{
    znWeakSelf(self)
    [[[[[self.accountText rac_textSignal] merge:[self.codeText rac_textSignal]] merge:[self.passworldText rac_textSignal]] merge:[self.aginPassworldText rac_textSignal]] subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        NSString * account = weakSelf.accountText.text;
        NSString * password = weakSelf.passworldText.text;
        NSString * ageinPassword = weakSelf.aginPassworldText.text;
        NSString * code = weakSelf.codeText.text;
        if (account == nil || password == nil || ageinPassword == nil || ageinPassword == nil || [account isEqualToString:@""] || [password isEqualToString:@""] || [ageinPassword isEqualToString:@""] || [code isEqualToString:@""]) {
            self.sureBtn.enabled = NO;
            self.sureBtn.alpha = 0.6;
        }else{
            self.sureBtn.alpha = 1;
            self.sureBtn.enabled = YES;
        }
    }];
}

#pragma mark --------get---------

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton new];
        _sureBtn.titleLabel.font = zn_font(15);
        _sureBtn.backgroundColor = Main_Color();
        _sureBtn.layer.cornerRadius = 5;
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _sureBtn;
}

- (RPTimeButton *)getCodeBtn{
    if (!_getCodeBtn) {
        _getCodeBtn = [RPTimeButton new];
        _getCodeBtn.timeNumber = 60;
        _getCodeBtn.backgroundColor = Main_Color();
        _getCodeBtn.layer.cornerRadius = 5;
        _getCodeBtn.titleLabel.font = zn_font(13);
        [_getCodeBtn setTitle:@"验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _getCodeBtn;
}

- (UITextField *)passworldText{
    if (!_passworldText) {
        _passworldText = [UITextField new];
        _passworldText.font = zn_font(13);
        _passworldText.placeholder = @"请输入密码";
        _passworldText.secureTextEntry = YES;
    }
    return _passworldText;
}

- (UITextField *)aginPassworldText{
    if (!_aginPassworldText) {
        _aginPassworldText = [UITextField new];
        _aginPassworldText.font = zn_font(13);
        _aginPassworldText.secureTextEntry = YES;
        _aginPassworldText.placeholder = @"请再次输入密码";
    }
    return _aginPassworldText;
}

- (UITextField *)accountText{
    if (!_accountText) {
        _accountText = [UITextField new];
        _accountText.font = zn_font(13);
        _accountText.placeholder = @"请输入手机号";
    }
    return _accountText;
}

- (UITextField *)codeText{
    if (!_codeText) {
        _codeText = [UITextField new];
        _codeText.font = zn_font(13);
        _codeText.placeholder = @"验证码";
    }
    return _codeText;
}

@end

//
//  RPRegisterViewController.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/21.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPRegisterViewController.h"
#import "RPHobbyKindsViewController.h"
#import "NewsKindsChooseController.h"
#import "RPRegisterViewModel.h"
#import "RPRegisterDataModel.h"

@interface RPRegisterViewController ()
    
@property (nonatomic , strong) RPRegisterViewModel *viewmodel;

@property (nonatomic , strong) RPRegisterDataModel * datamodel;

@end

@implementation RPRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.viewmodel setupInit];
    [self setBingding];
}

- (void)setBingding{
    znWeakSelf(self)
    [[self.viewmodel.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        if ([weakSelf isCondictionRegis]) {
            [weakSelf.datamodel.isExitCommamd execute:@{@"username":weakSelf.viewmodel.accountText.text}];
        }
    }];
    
    //获取验证码
    [[self.viewmodel.getCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        NSString * username = weakSelf.viewmodel.accountText.text;
        if (![username zn_isMobile]) {
            [weakSelf showError:@"手机号格式不对！"];
            return;
        }
        [weakSelf.viewmodel.getCodeBtn startTimer];
    }];
    
    [self.datamodel.registerCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       znStrongSelf
        if ([x[0] boolValue]) {
            [weakSelf showSuccess:@"注册成功"];
            //进行用户的新闻类别选择
            NewsKindsChooseController * controller = [NewsKindsChooseController new];
            controller.isPreRegisterController = YES;
            [weakSelf.navigationController pushViewController:controller animated:YES];
        }else{
            [weakSelf showError:x[1]];
        }
    }];
    
    [self.datamodel.isExitCommamd.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       znStrongSelf
        if ([x[0] boolValue]) {
            [weakSelf regisAccount];
        }else{
            [weakSelf showError:x[1]];
        }
    }];
    
}

- (BOOL)isCondictionRegis{
    NSString *account = self.viewmodel.accountText.text;
    NSString *passworld = self.viewmodel.passworldText.text;
    NSString *againPassworld = self.viewmodel.aginPassworldText.text;
    NSString *code = self.viewmodel.codeText.text;
    
    if (![account zn_isMobile]) {
        [self showError:@"手机号格式不对！"];
        return NO;
    }
    
    if (passworld == nil || [passworld isEqualToString:@""]) {
        [self showError:@"密码不能为空！"];
        return NO;
    }
    
    if (![againPassworld isEqualToString:passworld]) {
        [self showError:@"两次密码不一致"];
        return NO;
    }
    
    if ([code isEqualToString:@""]) {
        [self showError:@"验证码不能为空"];
        return NO;
    }
    return YES;
}

/**
 注册用户信息
 */
- (void)regisAccount{
    //验证码
    NSString *code = self.viewmodel.codeText.text;
    if (![self isCondictionRegis]) {
        return;
    }
    
    UserData * userModel = [UserData new];
    userModel.username = self.viewmodel.accountText.text;
    userModel.password = self.viewmodel.passworldText.text;
    userModel.mobilePhoneNum = self.viewmodel.accountText.text;
    self.datamodel.userModel = userModel;
    [self.datamodel.registerCommand execute:nil];
}

#pragma mark ---------get-----------

- (RPRegisterViewModel *)viewmodel{
    if (!_viewmodel) {
        _viewmodel = [RPRegisterViewModel new];
        _viewmodel.viewController = self;
    }
    return _viewmodel;
}

- (RPRegisterDataModel *)datamodel{
    if (!_datamodel) {
        _datamodel = [RPRegisterDataModel new];
    }
    return _datamodel;
}

@end

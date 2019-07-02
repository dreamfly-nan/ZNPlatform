//
//  RPLoginViewController.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/21.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPLoginViewController.h"
#import "RPRegisterViewController.h"
#import "RPBaceTabBarController.h"
#import "RPForgetPassworldViewController.h"

#import "RPLoginViewModel.h"
#import "RPLoginDataModel.h"

@interface RPLoginViewController ()

@property (nonatomic , strong) RPLoginViewModel * viewmodel;

@property (nonatomic , strong) RPLoginDataModel * datamodel;

@end

@implementation RPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.viewmodel setupInitUI];
    [self setupBingding];
//    if (self.navigationController) {
//        self.navigationController.navigationBar.hidden = YES;
//    }
    
    if ([RPConfig sharedInstance].userData) {
        self.viewmodel.accountText.text = [RPConfig sharedInstance].userData.mobilePhoneNum;
        self.viewmodel.passworldText.text = [RPConfig sharedInstance].userData.password;
        [self.viewmodel.loginBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    // Do any additional setup after loading the view.
}

- (void)setupBingding{
    znWeakSelf(self)
    //登录
    [[self.viewmodel.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        NSString * username = weakSelf.viewmodel.accountText.text;
        NSString * password = weakSelf.viewmodel.passworldText.text;
        [weakSelf showLoading];
        [weakSelf.datamodel.loginCommand execute:@{@"username":username,@"password":password}];
    }];
    
    //注册
    [[self.viewmodel.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        RPRegisterViewController * controller = [RPRegisterViewController new];
        [weakSelf.rt_navigationController pushViewController:controller animated:YES];
    }];
    
    //忘记密码
    [[self.viewmodel.forgetBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        RPForgetPassworldViewController * controller = [RPForgetPassworldViewController new];
        [weakSelf.rt_navigationController pushViewController:controller animated:YES];
    }];
    
    //登录请求处理
    [self.datamodel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        [weakSelf hideLoading];
        if ([x[0] boolValue]) {
            [UIApplication sharedApplication].delegate.window.rootViewController = [[RPNavigationController alloc] initWithRootViewController:[RPBaceTabBarController new]];
            [weakSelf showSuccess:@"登录成功"];
        }else{
            NSString * message = [NSString stringWithFormat:@"%@",x[1]];
            [weakSelf showError:message];
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.viewmodel.accountText resignFirstResponder];
    [self.viewmodel.passworldText resignFirstResponder];
}

#pragma mark -------get--------

- (RPLoginViewModel *)viewmodel{
    if (!_viewmodel) {
        _viewmodel = [RPLoginViewModel new];
        _viewmodel.controller = self;
    }
    return _viewmodel;
}

- (RPLoginDataModel *)datamodel{
    if (!_datamodel) {
        _datamodel = [RPLoginDataModel new];
    }
    return _datamodel;
}
@end

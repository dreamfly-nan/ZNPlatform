//
//  RPForgetPassworldViewController.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/25.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPForgetPassworldViewController.h"
#import "RPLoginViewController.h"
#import "RPForgetPassworldViewModel.h"
#import "RPForgetPassworldDataModel.h"


@interface RPForgetPassworldViewController ()

@property (nonatomic , strong) RPForgetPassworldViewModel * viewmodel;

@property (nonatomic , strong) RPForgetPassworldDataModel * datamodel;

@end

@implementation RPForgetPassworldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    [self.viewmodel setupInit];
    [self setupBingding];
    // Do any additional setup after loading the view.
}

- (void)setupBingding{
    znWeakSelf(self)
    [self.datamodel.selectCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        znStrongSelf
            [weakSelf hideLoading];
            if ([x[0] boolValue]) {
                NSString * password = weakSelf.viewmodel.aginPassworldText.text;
                weakSelf.datamodel.userdata.password = password;
                [weakSelf.datamodel.updataCommand execute:@{@"password":password}];
            }else{
                [weakSelf showError:x[1]];
            }
        
    }];
    
    [self.datamodel.updataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        znStrongSelf
            if ([x[0] boolValue]) {
                [weakSelf.navigationController pushViewController:[RPLoginViewController new] animated:YES];
                [weakSelf showSuccess:x[1]];
            }else{
                [weakSelf showError:x[1]];
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
    
    //确认修改密码
    [[self.viewmodel.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        if ([weakSelf isCondiction]) {
            [weakSelf showLoading];
            NSString * username = weakSelf.viewmodel.accountText.text;
            [weakSelf.datamodel.selectCommand execute:@{@"username":username}];
        }
    }];
}

//是否满足发起请求的条件
- (BOOL)isCondiction{
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

#pragma mark ---------get-------

- (RPForgetPassworldViewModel *)viewmodel{
    if (!_viewmodel) {
        _viewmodel = [RPForgetPassworldViewModel new];
        _viewmodel.viewController = self;
    }
    return _viewmodel;
}

- (RPForgetPassworldDataModel *)datamodel{
    if (!_datamodel) {
        _datamodel = [RPForgetPassworldDataModel new];
    }
    return _datamodel;
}

@end

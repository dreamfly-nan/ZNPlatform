//
//  RPBaseViewController.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/7.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaseViewController.h"
#import <WebKit/WebKit.h>
#import "RPLoginViewController.h"

@interface RPBaseViewController ()

@property (nonatomic , strong) UIButton * backBtn;

@property (nonatomic , strong) UIBarButtonItem * backBtnItem;

//用来做加载动画
@property (nonatomic , strong) WKWebView * webViewLoading;

@end

@implementation RPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpInitUI];
}

- (void)setUpInitUI{
    [RPConfig sharedInstance].navigationHeight = self.navigationController.navigationBar.height;
    
    self.view.backgroundColor = Big_background_Color();
    if (self.navigationController) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:zn_font(15),
                                                                          NSForegroundColorAttributeName:Main_Color()}];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage zn_createImageWithColor:[UIColor whiteColor] size:CGSizeMake(10, 10)] forBarMetrics:UIBarMetricsDefaultPrompt];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
    
    [self.view addSubview:self.noNetView];
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    [self.backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return self.backBtnItem;
}

#pragma mark - private

#pragma mark - public

/**
 重新进行请求
 */
- (void)reloadRequest{
    
}

/**
 提示错误信息
 
 @param error <#error description#>
 */
- (void)showError:(NSString*) error{
    if (error) {
        [MBProgressHUD zn_showError:error];
    }
}

/**
 提示成功信息
 
 @param message <#message description#>
 */
- (void)showSuccess:(NSString*) message{
    if (message) {
        [MBProgressHUD zn_showSuccess:message];
    }
}

- (void)showNoNet{
    self.noNetView.hidden = NO;
}

- (void)hideNoNet{
    self.noNetView.hidden = YES;
}

/**
 显示加载动画
 */
- (void)showLoading{
    [SVProgressHUD showWithStatus:@""];
}

/**
 隐藏加载动画
 */
- (void)hideLoading{
    [SVProgressHUD dismiss];
}


/**
 跳转到登录页面
 */
- (BOOL)toLoginController{
    if ([RPConfig sharedInstance].userData == nil) {
        if (self.navigationController) {
            [self.navigationController pushViewController:[RPLoginViewController new] animated:YES];
        }else{
            [self presentViewController:[RPLoginViewController new] animated:YES completion:nil];
        }
        return YES;
    }
    return NO;
}

#pragma mark ------TableViewBackgroundNoDataDetelgate-------

- (UIView *)getNoDataView{
    return self.noDataView;
}

#pragma mark -------------get--------------

- (UIBarButtonItem *)backBtnItem{
    if (!_backBtnItem) {
        _backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    }
    return _backBtnItem;
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
//        _backBtn.zn_title(@"返回",UIControlStateNormal).zn_titleColor([UIColor redColor],UIControlStateNormal);
//        _backBtn.autoImageTinkColor = YES;
//        [_backBtn setTintColor:[UIColor yellowColor]];
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        _backBtn.bounds = CGRectMake(0, 0, zn_AutoWidth(22), zn_AutoWidth(22));
    }
    return _backBtn;
}
                                                                      
- (RPNoNetView *)noNetView{
    if (!_noNetView) {
        _noNetView = [RPNoNetView CreateRPNoNetView];
        _noNetView.hidden = YES;
        znWeakSelf(self)
        _noNetView.reloadBlock = ^{
            znStrongSelf
            [weakSelf reloadRequest];
        };
    }
    return _noNetView;
}

- (RPNoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [RPNoDataView CreateRPNoDataView];
    }
    return _noDataView;
}

@end

//
//  ZNBaseViewController.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/26.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNBaseViewController.h"

@interface ZNBaseViewController ()

@property (nonatomic , strong) UIBarButtonItem * backBtnItem;

@end

@implementation ZNBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setInitUI];
}

- (void)setInitUI{
    self.view.backgroundColor = Big_background_Color();
    if (self.navigationController) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:zn_font(15),
                                                                          NSForegroundColorAttributeName:Main_Color()}];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage zn_createImageWithColor:[UIColor whiteColor] size:CGSizeMake(10, 10)] forBarMetrics:UIBarMetricsDefaultPrompt];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
        
        self.navigationHeight = self.navigationController.navigationBar.height;
    }
    
    [self.view addSubview:self.noNetWorkView];
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action{
    [self.backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return self.backBtnItem;
}

#pragma mark - public

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
    self.noNetWorkView.hidden = NO;
}

- (void)hideNoNet{
    self.noNetWorkView.hidden = YES;
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
 展示信息，并提供代码块处理
 @param message <#message description#>
 @param btnTitle <#btnTitle description#>
 @param block <#block description#>
 */
- (void)showMessage:(NSString*) message
           btnTitle:(NSString*) btnTitle
              block:(void (^)(void)) block{
    [ZNAlertDialogTool zn_showController:self title:nil message:message sureStr:btnTitle block:block];
}

#pragma mark - set

- (void)setReloadBlock:(void (^)(void))reloadBlock{
    _reloadBlock = reloadBlock;
    self.noNetWorkView.reloadBlock = reloadBlock;
}

#pragma mark - get

- (UIBarButtonItem *)backBtnItem{
    if (!_backBtnItem) {
        _backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
    }
    return _backBtnItem;
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        _backBtn.bounds = CGRectMake(0, 0, zn_AutoWidth(22), zn_AutoWidth(22));
    }
    return _backBtn;
}

- (ZNNoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [ZNNoDataView createRPNoDataView];
    }
    return _noDataView;
}

- (ZNNoNetWorkView *)noNetWorkView{
    if (!_noNetWorkView) {
        _noNetWorkView = [ZNNoNetWorkView createRPNoNetView];
        _noNetWorkView.hidden = YES;
        if (self.reloadBlock) {
            _noNetWorkView.reloadBlock = self.reloadBlock;
        }
    }
    return _noNetWorkView;
}

@end

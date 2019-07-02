//
//  RPBaseViewController.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/7.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RPNoNetView.h"
#import "RPNoDataView.h"

@interface RPBaseViewController : UIViewController
<TableViewBackgroundNoDataDetelgate>

@property (nonatomic , strong) RPNoNetView *noNetView;

@property (nonatomic , strong) RPNoDataView *noDataView;

/**
 重新进行请求
 */
- (void)reloadRequest;

/**
 显示加载动画
 */
- (void)showLoading;

/**
 隐藏加载动画
 */
- (void)hideLoading;

/**
 展示网络请求出错视图
 */
- (void)showNoNet;

/**
 隐藏网络请求出错视图
 */
- (void)hideNoNet;

/**
 提示错误信息

 @param error <#error description#>
 */
- (void)showError:(NSString*) error;

/**
 提示成功信息

 @param message <#message description#>
 */
- (void)showSuccess:(NSString*) message;

/**
 跳转到登录页面
 @return 是否有进行跳转登录页
 */
- (BOOL)toLoginController;

@end

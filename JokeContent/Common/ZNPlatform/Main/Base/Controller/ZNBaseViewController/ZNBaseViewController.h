//
//  ZNBaseViewController.h
//  JokeContent
//
//  Created by 南木南木 on 2019/6/26.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNNoDataView.h"
#import "ZNNoNetWorkView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZNBaseViewController : UIViewController

/**
 没有数据的展示视图
 */
@property(nonatomic,strong) ZNNoDataView * noDataView;

/**
 没有网络的展示视图
 */
@property(nonatomic,strong) ZNNoNetWorkView * noNetWorkView;

/**
 返回键
 */
@property (nonatomic , strong) UIButton * backBtn;

/**
 导航栏高度
 */
@property(nonatomic,assign) CGFloat navigationHeight;

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

/// 网络出错重载
- (void)netErrorReload;

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
  展示信息，并提供代码块处理

 @param message <#message description#>
 @param btnTitle <#btnTitle description#>
 @param block <#block description#>
 */
- (void)showMessage:(NSString*) message
           btnTitle:(NSString*) btnTitle
              block:(void (^)(void)) block;

@end

NS_ASSUME_NONNULL_END

//
//  MBProgressHUD+ZN.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/5.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (ZN)


/**
 *  =======显示信息
 *  @param text 信息内容
 *  @param icon 图标
 *  @param view 显示的视图
 */
+ (void)zn_show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;

+ (void)zn_showSuccess:(NSString *)success;
+ (void)zn_showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)zn_showError:(NSString *)error;
+ (void)zn_showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)zn_showMessage:(NSString *)message;
+ (MBProgressHUD *)zn_showMessage:(NSString *)message toView:(UIView *)view;

+ (void)zn_hideHUD;
+ (void)zn_hideHUDForView:(UIView *)view;

@end

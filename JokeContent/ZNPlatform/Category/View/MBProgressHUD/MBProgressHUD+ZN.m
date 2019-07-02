//
//  MBProgressHUD+ZN.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/5.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "MBProgressHUD+ZN.h"

@implementation MBProgressHUD (ZN)

/**
 *  =======显示信息
 *  @param text 信息内容
 *  @param icon 图标
 *  @param view 显示的视图
 */
+ (void)zn_show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    
    hud.label.textColor = Title_Color();
    //hud.bezelView.style = MBProgressHUDBackgroundStyleSolidCo;
    hud.label.font = [UIFont systemFontOfSize:17.0];
    hud.userInteractionEnabled= NO;
    
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 3.5秒之后再消失
    [hud hideAnimated:YES afterDelay:2];
}

/**
 *  =======显示 提示信息
 *  @param success 信息内容
 */
+ (void)zn_showSuccess:(NSString *)success
{
    [self zn_showSuccess:success toView:nil];
}

/**
 *  =======显示
 *  @param success 信息内容
 */
+ (void)zn_showSuccess:(NSString *)success toView:(UIView *)view
{
    [self zn_show:success icon:@"success.png" view:view];
}

/**
 *  =======显示错误信息
 */
+ (void)zn_showError:(NSString *)error
{
    [self zn_showError:error toView:nil];
}

+ (void)zn_showError:(NSString *)error toView:(UIView *)view{
    [self zn_show:error icon:@"error.png" view:view];
}
/**
 *  显示提示 + 菊花
 *  @param message 信息内容
 *  @return 直接返回一个MBProgressHUD， 需要手动关闭(  ?
 */
+ (MBProgressHUD *)zn_showMessage:(NSString *)message
{
    return [self zn_showMessage:message toView:nil];
}

/**
 *  显示一些信息
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)zn_showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    
    return hud;
}

/**
 *  手动关闭MBProgressHUD
 */
+ (void)zn_hideHUD
{
    [self zn_hideHUDForView:nil];
}
/**
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)zn_hideHUDForView:(UIView *)view
{
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    
    [self hideHUDForView:view animated:YES];
}

@end

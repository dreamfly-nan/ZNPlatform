//
//  UIViewController+ZNViewController.h
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2020/3/23.
//  Copyright © 2020 ttyx. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ZNViewController)

/// 获取最顶层的控制器
- (UIViewController *)topViewController;

@end

NS_ASSUME_NONNULL_END

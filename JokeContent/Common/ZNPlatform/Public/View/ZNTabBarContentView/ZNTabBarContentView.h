//
//  ZNTabBarContentView.h
//  MeetCarefree
//
//  Created by 郑楠楠 on 2018/4/16.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZNTabBarContentViewDelegate <NSObject>

@optional

//滑动到第几个controller
- (void)scrollToindex:(int)index;

/// 滑动完成
/// @param index <#index description#>
- (void)didScrollToindex:(int) index;

/// 将开始滑动
- (void)willScroll;

/// 滑动动作结束
- (void)didScroll;

@end

@interface ZNTabBarContentView : UIView

//当前页
@property (nonatomic, assign) int index;

@property (nonatomic , strong) NSArray <UIViewController *>* controllers;

@property (nonatomic , weak) id<ZNTabBarContentViewDelegate> znDelegate;

//内容的宽度
@property (nonatomic , assign) CGFloat widthContent;

//父控制器
@property (nonatomic , strong) UIViewController *superViewController;

//滑动到某一项
- (void)scrollToIndex:(int)index;

@end

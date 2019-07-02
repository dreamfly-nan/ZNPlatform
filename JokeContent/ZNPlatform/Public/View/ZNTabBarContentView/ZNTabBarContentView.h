//
//  ZNTabBarContentView.h
//  MeetCarefree
//
//  Created by 郑楠楠 on 2018/4/16.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZNTabBarContentViewDelegate <NSObject>

//滑动到第几个controller
- (void)scrollToindex:(int)index;

@end

@interface ZNTabBarContentView : UIView

@property (nonatomic , strong) NSArray <UIViewController *>* controllers;

@property (nonatomic , weak) id<ZNTabBarContentViewDelegate> znDelegate;

//父控制器
@property (nonatomic , strong) UIViewController *superViewController;

//滑动到某一项
- (void)scrollToIndex:(int)index;

@end

//
//  ZNTabView.h
//  MeetCarefree
//
//  Created by 郑楠楠 on 2018/7/19.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZNTabViewDelegate <NSObject>

//滑动到第几个controller
- (void)scrollToindex:(int)index;

@end

@interface ZNTabView : UIView

@property (nonatomic , strong) NSArray <UIView *>* views;

@property (nonatomic , weak) id<ZNTabViewDelegate> znDelegate;

//父控制器
@property (nonatomic , strong) UIViewController *superViewController;

//内容大小
@property (nonatomic , assign) CGSize contentSize;

//滑动到某一项
- (void)scrollToIndex:(int)index;

@end

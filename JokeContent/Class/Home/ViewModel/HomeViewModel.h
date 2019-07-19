//
//  HomeViewModel.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/18.
//  Copyright © 2019 社会人. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RPSearchTextField.h"
#import "ZNTextTabBarView.h"
#import "ZNTabBarContentView.h"
#import "HomeViewController.h"
#import "ZNMoveImageView.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeViewModel : NSObject

@property (nonatomic , weak) HomeViewController * controller;

@property(nonatomic,strong) ZNMoveImageView * moveImageView;

@property (nonatomic , strong) UIImageView * logoImageView;

//个人中心
@property (nonatomic , strong) UIButton * accountBtn;

//加号，更多功能
@property (nonatomic , strong) UIButton * moreFunctionBtn;

//搜索框的左边放大镜图
@property (nonatomic , strong) UIImageView * leftSearchTextImageView;

//搜索框
@property (nonatomic , strong) RPSearchTextField * searchTextField;

//覆盖在检索框上面
@property (nonatomic , strong) UIButton * searchBtn;

//头部视图
@property (nonatomic , strong) UIView * tableViewHeadView;

//标题
@property (nonatomic , strong) ZNTextTabBarView * textBarView;
//内容
@property (nonatomic , strong) ZNTabBarContentView * contentView;

- (void) setUpInitUI;

@end

NS_ASSUME_NONNULL_END

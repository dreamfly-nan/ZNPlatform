//
//  RPBaceTabBarController.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/7.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaceTabBarController.h"
#import "HomeViewController.h"
#import "ZNDialogPage.h"

@interface RPBaceTabBarController ()

@property (nonatomic , strong) UIView *lineView;

@end

@implementation RPBaceTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpInitUI];
    [self setController];
    self.tabBar.hidden = YES;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setUpInitUI{
     self.tabBar.backgroundImage = [UIImage zn_imageWithColor:[UIColor whiteColor] size:self.tabBar.size];
    [self.tabBar addSubview:self.lineView];
    [RPConfig sharedInstance].tabBarHeight = self.tabBar.height;
    [RPConfig sharedInstance].navigationHeight = self.navigationController.navigationBar.height;
}

- (void)setController{
    HomeViewController * homeVC = [HomeViewController new];
    homeVC.title = @"首页";
    homeVC.tabBarItem.image = [UIImage imageNamed:@"information_no"];
    homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"information_select"];
    homeVC.tabBarItem.badgeColor = [UIColor whiteColor];
    self.viewControllers = @[homeVC];
}

#pragma mark ----------get------------

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.size.width, zn_AutoHeight(2))];
//        _lineView.backgroundColor = Big_background_Color();
    }
    return _lineView;
}

@end

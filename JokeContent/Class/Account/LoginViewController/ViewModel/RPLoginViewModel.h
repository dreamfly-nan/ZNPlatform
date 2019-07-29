//
//  RPLoginViewModel.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/22.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaseViewController.h"
#import "RPLoginViewController.h"
#import "RPSearchTextField.h"
#import "ZNTextField.h"
#import "ZNUIButton.h"

@interface RPLoginViewModel : RPBaseObject

@property (nonatomic , weak) RPLoginViewController *controller;

@property (nonatomic , strong) ZNTextField * accountText;

@property (nonatomic , strong) ZNTextField * passworldText;

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , strong) ZNUIButton * loginBtn;

@property (nonatomic , strong) UIButton * registerBtn;

@property (nonatomic , strong) UIButton * forgetBtn;

- (void)setupInitUI;

@end

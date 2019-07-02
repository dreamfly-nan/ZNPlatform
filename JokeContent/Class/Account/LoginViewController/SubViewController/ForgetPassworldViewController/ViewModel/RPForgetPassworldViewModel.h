//
//  RPForgetPassworldViewModel.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/25.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaseObject.h"
#import "RPTimeButton.h"
#import "RPForgetPassworldViewController.h"

@interface RPForgetPassworldViewModel : RPBaseObject

@property (nonatomic , strong) UITextField *accountText;

@property (nonatomic , strong) UITextField *codeText;

@property (nonatomic , strong) UITextField *passworldText;

@property (nonatomic , strong) UITextField *aginPassworldText;

@property (nonatomic , strong) RPTimeButton * getCodeBtn;

//下一步
@property (nonatomic , strong) UIButton *sureBtn;

@property (nonatomic , weak) RPForgetPassworldViewController *viewController;

- (void)setupInit;
@end

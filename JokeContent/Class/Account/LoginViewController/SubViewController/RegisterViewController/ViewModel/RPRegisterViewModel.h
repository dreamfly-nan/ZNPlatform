//
//  RPRegisterViewModel.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/21.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaseObject.h"
#import "RPRegisterViewController.h"
#import "RPTimeButton.h"

@interface RPRegisterViewModel : RPBaseObject

@property (nonatomic , strong) UITextField *accountText;

@property (nonatomic , strong) UITextField *codeText;

@property (nonatomic , strong) UITextField *passworldText;

@property (nonatomic , strong) UITextField *aginPassworldText;

@property (nonatomic , strong) RPTimeButton * getCodeBtn;

//下一步
@property (nonatomic , strong) UIButton *nextBtn;

@property (nonatomic , weak) RPRegisterViewController *viewController;

- (void)setupInit;

@end

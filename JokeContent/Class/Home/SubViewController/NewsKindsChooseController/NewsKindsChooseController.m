//
//  NewsKindsChooseController.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/19.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "NewsKindsChooseController.h"
#import "NewsKindsChooseViewModel.h"
#import "NewsKindsChooseDataModel.h"
@interface NewsKindsChooseController()

@property (nonatomic , strong) NewsKindsChooseViewModel * viewModel;

@property (nonatomic , strong) NewsKindsChooseDataModel * dataModel;

@end
@implementation NewsKindsChooseController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"类别";
    
    [self.viewModel setInitUI];
    [self setBingding];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //初始化数据
    [self.dataModel setInitData];
}

- (void)setBingding{
    znWeakSelf(self)
    [self.dataModel.kindsCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        if ([x[0] boolValue]) {
            [weakSelf.viewModel setInitBtn];
        }else{
            [weakSelf showError:x[1]];
        }
    }];
    
    [self.dataModel.upChooseCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        if ([x[0] boolValue]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:homeKindsChange object:nil];
            
            if (weakSelf.znDelegate && [weakSelf.znDelegate respondsToSelector:@selector(chooseFinish:)]) {
                [weakSelf.znDelegate chooseFinish:[RPConfig sharedInstance].chooseKinds];
            }
            
            if (weakSelf.isPreRegisterController) {
                [UIApplication sharedApplication].delegate.window.rootViewController = [[RPNavigationController alloc] initWithRootViewController:[RPBaceTabBarController new]];
            }else{
                if (weakSelf.navigationController) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }else{
                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                }
            }
        }else{
            [weakSelf showError:x[1]];
        }
    }];
    
    [[self.viewModel.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        //整理选中项
        [weakSelf.viewModel setChooseItem];
        if (weakSelf.viewModel.chooseKinds.count > 0) {
            [[RPConfig sharedInstance].userData setKinds:weakSelf.viewModel.chooseKinds];
            [weakSelf.dataModel.upChooseCommand execute:nil];
        }else{
            if (weakSelf.navigationController) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }];
}

#pragma mark - get

- (NewsKindsChooseViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [NewsKindsChooseViewModel new];
        _viewModel.controller = self;
    }
    return _viewModel;
}

- (NewsKindsChooseDataModel *)dataModel{
    if (!_dataModel) {
        _dataModel = [NewsKindsChooseDataModel new];
    }
    return _dataModel;
}

@end

//
//  FeedBackViewController.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/22.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "FeedBackViewController.h"
#import "FeedBackViewModel.h"
#import "FeedBackDataModel.h"
#import "FeedBackModel.h"
@interface FeedBackViewController ()

@property(nonatomic,strong) FeedBackViewModel * viewModel;

@property(nonatomic,strong) FeedBackDataModel * dataModel;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈";
    [self.viewModel setInitUI];
    [self setBangding];
    // Do any additional setup after loading the view.
}
- (void)setBangding{
    znWeakSelf(self)
    [[self.viewModel.commitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        NSString * text  = weakSelf.viewModel.textView.text;
        if (text.length <= 10) {
            [weakSelf showError:@"反馈信息最少10个字！"];
            return;
        }
        [weakSelf showLoading];
        FeedBackModel * model = [FeedBackModel new];
        model.userId = [RPConfig sharedInstance].userData.objectId;
        model.content = weakSelf.viewModel.textView.text;
        model.createTime = [ZNTimeTool getCurrentTimes];
        [weakSelf.dataModel.commitFeedCommand execute: model];
    }];
    
    [self.dataModel.commitFeedCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       znStrongSelf
        [weakSelf hideLoading];
        if ([x[0] boolValue]) {
            [weakSelf showSuccess:@"很高兴能收到您的反馈，谢谢您的支持！"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [weakSelf showError:@"反馈提交失败！"];
        }
    }];
    
}

#pragma mark - get

- (FeedBackDataModel *)dataModel{
    if (!_dataModel) {
        _dataModel = [FeedBackDataModel new];
    }
    return _dataModel;
}

- (FeedBackViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [FeedBackViewModel new];
        _viewModel.controller = self;
    }
    return _viewModel;
}

@end

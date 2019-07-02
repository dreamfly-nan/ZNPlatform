//
//  RPMySystemMessageViewController.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/7.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPMySystemMessageViewController.h"

@interface RPMySystemMessageViewController ()

@end

@implementation RPMySystemMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知";
    self.noDataView.refreshBtn.hidden = YES;
    self.noDataView.titleLabel.text = @"空空如也~";
    [self.view addSubview:self.noDataView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

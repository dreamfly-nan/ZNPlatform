//
//  RPMySetViewModel.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/7.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPMySetViewModel.h"

@implementation RPMySetViewModel

- (void)setUpInitUI{
    [self.controller.view addSubview:self.tableview];
    
    __block RPMySetViewController * controller = self.controller;
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(controller.view);
        make.top.equalTo(controller.view);
    }];
}

#pragma mark ---------get----------

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.controller.view.bounds style:UITableViewStylePlain];
        _tableview.delegate = self.controller;
        _tableview.dataSource = self.controller;
        _tableview.backgroundColor = Big_background_Color();
        _tableview.tableFooterView = [UIView new];
        [_tableview registerClass:[RPBaseTableViewCell class] forCellReuseIdentifier:[RPBaseTableViewCell idString]];
        if (@available(iOS 11.0 ,*)) {
            _tableview.estimatedSectionFooterHeight = 0;
            _tableview.estimatedSectionHeaderHeight = 0;
        }
    }
    return _tableview;
}

@end

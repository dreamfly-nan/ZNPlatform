//
//  UITableView+ZNCreate.m
//  CityManagement
//
//  Created by 郑楠楠 on 2019/9/13.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "UITableView+ZNCreate.h"

@implementation UITableView (ZNCreate)

/**
 初始化
 */
+ (instancetype)zn_createWithFrame:(CGRect) frame
                             style:(UITableViewStyle)style{
    return [[self alloc] initWithFrame:frame style:style];
}

/**
 初始化
 */
+ (UITableView * (^)(CGRect frame,UITableViewStyle style))zn_init{
    return ^(CGRect frame,UITableViewStyle style){
        return [[UITableView alloc] initWithFrame:frame style:style];
    };
}

/**
 注册cell
 */
- (UITableView * (^)(Class cellClass))zn_registerCell{
    return ^(Class cellClass){
        [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
        return self;
    };
}

/**
 设置代理
 */
- (UITableView * (^)(id<UITableViewDelegate> znDelegate))zn_delegate{
    return ^(id<UITableViewDelegate> znDelegate){
        self.delegate = znDelegate;
        return self;
    };
}

/**
 设置数据源代理
 */
- (UITableView * (^)(id<UITableViewDataSource> znDelegate))zn_dataSource{
    return ^(id<UITableViewDataSource> znDelegate){
        self.dataSource = znDelegate;
        return self;
    };
}

/**
 设置分割线的风格
 */
- (UITableView * (^)(UITableViewCellSeparatorStyle style))zn_separatorStyle{
    return ^(UITableViewCellSeparatorStyle style){
        self.separatorStyle = style;
        return self;
    };
}

/**
 设置内容边距
 */
- (UITableView * (^)(UIEdgeInsets insets))zn_contentInset{
    return ^(UIEdgeInsets insets){
        self.contentInset = insets;
        return self;
    };
}

/**
 设置尾部视图
 */
- (UITableView * (^)(UIView * view))zn_footerView{
    return ^(UIView * view){
        [view layoutSubviews];
        self.tableFooterView = view;
        return self;
    };
}

/**
 设置头部视图
 */
- (UITableView * (^)(UIView * view))zn_headerView{
    return ^(UIView * view){
        [view layoutSubviews];
        self.tableHeaderView = view;
        return self;
    };
}
@end

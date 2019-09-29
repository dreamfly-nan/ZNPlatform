//
//  UITableView+ZNCreate.h
//  CityManagement
//
//  Created by 郑楠楠 on 2019/9/13.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (ZNCreate)

/**
 初始化
 */
+ (instancetype)zn_createWithFrame:(CGRect) frame
                             style:(UITableViewStyle)style;

/**
 初始化
 */
+ (UITableView * (^)(CGRect frame,UITableViewStyle style))zn_init;

/**
 注册cell
 */
- (UITableView * (^)(Class cellClass))zn_registerCell;

/**
 设置代理
 */
- (UITableView * (^)(id<UITableViewDelegate> znDelegate))zn_delegate;

/**
 设置数据源代理
 */
- (UITableView * (^)(id<UITableViewDataSource> znDelegate))zn_dataSource;

/**
 设置分割线的风格
 */
- (UITableView * (^)(UITableViewCellSeparatorStyle style))zn_separatorStyle;

/**
 设置内容边距
 */
- (UITableView * (^)(UIEdgeInsets insets))zn_contentInset;

/**
 设置尾部视图
 */
- (UITableView * (^)(UIView * view))zn_footerView;

/**
 设置头部视图
 */
- (UITableView * (^)(UIView * view))zn_headerView;

@end

NS_ASSUME_NONNULL_END

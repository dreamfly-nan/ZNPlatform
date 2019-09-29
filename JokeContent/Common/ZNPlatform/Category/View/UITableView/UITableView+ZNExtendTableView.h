//
//  UITableView+ExtendTableView.h
//  TableViewCollectView
//
//  Created by 郑楠楠 on 2018/3/29.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableViewBackgroundNoDataDetelgate <UITableViewDelegate>

@optional

/**
 没有数据的时候返回的视图
 */
- (UIView *)getNoDataView;

@end

@interface UITableView (ZNExtendTableView)

- (UITableViewCell *)zn_dequeueReusableCellWithIdentifier:(Class) className;

@end

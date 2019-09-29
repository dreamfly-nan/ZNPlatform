//
//  ZNPopoMenuTableViewCell.h
//  CityManagement
//
//  Created by 南木南木 on 2019/9/3.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "ZNBaseTableViewCell.h"
#import "ZNPopoMenuItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZNPopoMenuTableViewCell : ZNBaseTableViewCell

@property(nonatomic,strong) ZNPopoMenuItemModel * model;

@end

NS_ASSUME_NONNULL_END

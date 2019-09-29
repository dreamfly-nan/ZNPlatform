//
//  ZNTextViewTableViewCell.h
//  CityManagement
//
//  Created by 南木南木 on 2019/9/4.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "ZNBaseTableViewCell.h"
#import "ZNTextCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZNTextViewTableViewCell : ZNBaseTableViewCell

@property(nonatomic,strong) ZNTextCellModel * model;

@end

NS_ASSUME_NONNULL_END

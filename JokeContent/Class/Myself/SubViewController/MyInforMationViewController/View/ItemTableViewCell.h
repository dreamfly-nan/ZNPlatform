//
//  ItemTableViewCell.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/23.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "RPBaseTableViewCell.h"
#import "InformationItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ItemTableViewCell : RPBaseTableViewCell

@property (nonatomic , strong) InformationItemModel * model;

@end

NS_ASSUME_NONNULL_END

//
//  TextTableViewCell.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/18.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "RPBaseTableViewCell.h"
#import "NewsDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TextTableViewCell : RPBaseTableViewCell

@property (nonatomic , strong) NewsDetailModel *model;

@end

NS_ASSUME_NONNULL_END

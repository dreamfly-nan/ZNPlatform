//
//  JokeListViewController.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/17.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "RPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JokeListViewController : RPBaseViewController
<UITableViewDelegate ,
UITableViewDataSource>

@property (nonatomic , copy) NSString  * typeId;

@property (nonatomic , copy) NSString  * searchText;

@end

NS_ASSUME_NONNULL_END

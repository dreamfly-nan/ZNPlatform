//
//  RPInformationDetailViewController.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaseViewController.h"
#import "NewsDetailModel.h"
#import "RPDetailCommentView.h"
@interface RPInformationDetailViewController : RPBaseViewController
<UITableViewDelegate,
UITableViewDataSource,
RPDetailCommentViewDelegate>

@property (nonatomic , strong) NewsDetailModel *information;

@end

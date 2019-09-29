//
//  ZNTitleItem.h
//  TableViewCollectView
//
//  Created by 郑楠楠 on 2018/4/2.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNTitleModel.h"

@protocol ZNTitleLabelDelegate;

@interface ZNTitleLabel : UILabel

@property (nonatomic , strong)ZNTitleModel *model;

@property (nonatomic , weak) id<ZNTitleLabelDelegate> znDelegate;

@end

@protocol ZNTitleLabelDelegate <NSObject>

- (void)selectAction:(ZNTitleLabel *)label;

@end

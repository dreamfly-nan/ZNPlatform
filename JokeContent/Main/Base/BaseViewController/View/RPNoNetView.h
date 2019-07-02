//
//  RPNoNetView.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/22.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPNoNetView : UIView

@property (nonatomic , strong) UILabel * titleLabel;

@property (nonatomic , copy) void (^reloadBlock)(void);

+ (instancetype)CreateRPNoNetView;

@end

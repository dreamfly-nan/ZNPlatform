//
//  RPDetailHeadView.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/5.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsDetailModel.h"
#import <WebKit/WebKit.h>

@interface RPDetailHeadView : UIView

@property (nonatomic , strong) UIImageView *iconImageView;

@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) UILabel *timeLabel;

@property (nonatomic , strong) UIButton *shareBtn;

//关注
@property (nonatomic , strong) UIButton *attentionBtn;

@property (nonatomic , strong) WKWebView * webView;

@property (nonatomic , strong) NewsDetailModel *model;

@property (nonatomic , assign) BOOL isLoadFinish;

//是否成功加载
@property (nonatomic , assign) BOOL isSuccess;

/**
 返回 YES 则跳转到上个页面，NO则不进行跳转
 
 @return <#return value description#>
 */
- (BOOL)isBackViewControllerOrWeb;

@end

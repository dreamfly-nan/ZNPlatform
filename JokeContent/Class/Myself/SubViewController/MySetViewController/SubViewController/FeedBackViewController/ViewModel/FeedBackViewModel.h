//
//  FeedBackViewModel.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/22.
//  Copyright © 2019 社会人. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXTextView.h"
#import "FeedBackViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface FeedBackViewModel : NSObject

@property(nonatomic,weak) FeedBackViewController * controller;

@property(nonatomic,strong) UILabel * titleLabel;

@property(nonatomic,strong) CXTextView * textView;

@property(nonatomic,strong) UIButton * commitBtn;

- (void)setInitUI;

@end

NS_ASSUME_NONNULL_END

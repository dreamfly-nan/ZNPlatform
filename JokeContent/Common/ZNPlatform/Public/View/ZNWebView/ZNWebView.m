//
//  ZNWebView.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "ZNWebView.h"

@interface ZNWebView() <WKUIDelegate>

@end

@implementation ZNWebView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpInitUI];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)setUpInitUI{
    znWeakSelf(self)
    [RACObserve(self, estimatedProgress) subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        if ([x doubleValue] >= 100) {
            weakSelf.height = weakSelf.scrollView.contentSize.height;
        }
    }];
}

@end

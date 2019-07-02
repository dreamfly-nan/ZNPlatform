//
//  ZNTabView.m
//  MeetCarefree
//
//  Created by 郑楠楠 on 2018/7/19.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "ZNTabView.h"

@interface ZNTabView() <UIScrollViewDelegate>

@property (nonatomic , strong) UIScrollView *contentScrollView;

//是否加载完数据
@property (nonatomic , assign) BOOL isfinishLoadData;

//当前页
@property (nonatomic, assign) int index;

@end

@implementation ZNTabView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupInitUI];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)setupInitUI{
    self.userInteractionEnabled = YES;
    self.index = 0;
    [self addSubview:self.contentScrollView];
    self.contentScrollView.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topEqualToView(self)
    .bottomEqualToView(self);
}

#pragma mark ------private-------

- (void)isExitViews{
    if (self.views.count > 0) {
        for (UIView *view in self.views) {
            [view removeFromSuperview];
        }
    }
}

#pragma mark --------public----------

- (void)scrollToIndex:(int)index{
    self.index = index;
    CGPoint offset = CGPointMake(index * self.contentScrollView.width, 0);
    [self.contentScrollView setContentOffset:offset animated:YES];
}

#pragma mark -------UIScrollViewDelegate--------

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int index = (scrollView.contentOffset.x + scrollView.width * 0.5)/scrollView.width;
    if (self.index != index) {
        self.index = index;
        if (self.znDelegate && [self.znDelegate respondsToSelector:@selector(scrollToindex:)]) {
            [self.znDelegate scrollToindex:index];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = (scrollView.contentOffset.x + scrollView.width * 0.5)/scrollView.width;
    [self scrollToIndex:index];
}

#pragma mark ---------set--------

- (void)setViews:(NSArray<UIView *> *)views{
    _views = views;
    self.contentScrollView.contentSize = CGSizeMake(self.contentSize.width * views.count, 0);
    [self isExitViews];
    for (int i = 0; i < self.views.count; i ++) {
        UIView *view = views[i];
        view.frame = CGRectMake(i * self.contentSize.width, 0, self.contentSize.width, self.contentSize.height);
        [self.contentScrollView addSubview:view];
    }
}

#pragma mark ---------get---------

- (UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.delegate = self;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.maximumZoomScale = 1;
        _contentScrollView.minimumZoomScale = 1;
        _contentScrollView.bounces = NO;
    }
    return _contentScrollView;
}

@end

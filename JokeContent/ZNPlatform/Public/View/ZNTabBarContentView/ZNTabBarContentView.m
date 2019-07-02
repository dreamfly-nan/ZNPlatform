//
//  ZNTabBarContentView.m
//  MeetCarefree
//
//  Created by 郑楠楠 on 2018/4/16.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "ZNTabBarContentView.h"

@interface ZNTabBarContentView() <UIScrollViewDelegate>

@property (nonatomic , strong) UIScrollView *contentScrollView;

//是否加载完数据
@property (nonatomic , assign) BOOL isfinishLoadData;

//当前页
@property (nonatomic, assign) int index;

@end

@implementation ZNTabBarContentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupInitUI];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setupInitUI{
    self.userInteractionEnabled = YES;
    self.index = 0;
    [self addSubview:self.contentScrollView];
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
}

- (void)setupDateWithControllers:(NSArray<UIViewController *> *)controllers{
    self.contentScrollView.contentSize = CGSizeMake(screenWidth * controllers.count, self.height);
    
    UIView * lastView = nil;
    for (int i = 0; i < controllers.count; i ++) {
        
        [self.superViewController addChildViewController:controllers[i]];
        UIView *view = controllers[i].view;
         [self.contentScrollView addSubview:view];
        
        if (lastView) {
            if (i == controllers.count - 1) {
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.top.width.equalTo(lastView);
                    make.left.equalTo(lastView.mas_right);
                    make.right.equalTo(self.contentScrollView);
                }];
            }else{
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.top.width.equalTo(lastView);
                    make.left.equalTo(lastView.mas_right);
                }];
            }
        }else{
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.bottom.width.height.equalTo(self.contentScrollView);
            }];
        }
        lastView = view;
    }
}

#pragma mark ------private-------

- (void)isExitController{
    if (self.controllers.count > 0) {
        for (UIViewController *controller in self.controllers) {
            [controller.view removeFromSuperview];
        }
    }
}

#pragma mark --------public----------

- (void)scrollToIndex:(int)index{
    self.index = index;
    CGPoint offset = CGPointMake(index * screenWidth, 0);
    [self.contentScrollView setContentOffset:offset];
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

#pragma mark ---------set--------

- (void)setControllers:(NSArray<UIViewController *> *)controllers{
    [self isExitController];
    _controllers = controllers;
    [self setupDateWithControllers:controllers];
}

#pragma mark ---------get---------

- (UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] init];
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.bounces = NO;
        _contentScrollView.delegate = self;
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.maximumZoomScale = 1;
        _contentScrollView.minimumZoomScale = 1;
    }
    return _contentScrollView;
}

@end

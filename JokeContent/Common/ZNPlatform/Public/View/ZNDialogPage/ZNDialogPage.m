//
//  ZNDialogPage.m
//  MeetAll
//
//  Created by 郑楠楠 on 2018/4/26.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "ZNDialogPage.h"

@interface ZNDialogPage() <ZNTabViewDelegate>

@property (nonatomic , strong) UIButton *closeBtn;

@property (nonatomic , strong) UIView *backgroundView;

//是否是第一次初始化
@property (nonatomic , assign) BOOL isfrist;

@end

@implementation ZNDialogPage

#pragma mark --------public---------

+ (instancetype)createDialogPageWithSize:(CGSize)size views:(NSArray<UIView *>*)views{
    ZNDialogPage *dialogPage = [[ZNDialogPage alloc] init];
    [dialogPage setContentSize:size];
    dialogPage.views = views;
    return dialogPage;
}

+ (void)createDialogPageOnWindWithSize:(CGSize)size views:(NSArray<UIView *>*)views{
    ZNDialogPage * dialogPage = [ZNDialogPage createDialogPageWithSize:size views:views];
    UIWindow * window = [[[UIApplication sharedApplication] windows] lastObject];
    
    [window addSubview:dialogPage];
    [window bringSubviewToFront:dialogPage];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)]) {
        self.isfrist = YES;
        _contentSize = CGSizeMake(zn_AutoWidth(295), zn_AutoHeight(362));
        [self setUpInitUI];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)setUpInitUI{
    self.isfrist = NO;
    [self addSubview:self.backgroundView];
    [self addSubview:self.pageControl];
    [self addSubview:self.contentView];
    [self addSubview:self.closeBtn];
    
    self.pageControl.sd_layout
    .topSpaceToView(self, zn_AutoHeight(79) + zn_stateHeight())
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(zn_AutoHeight(36));
    
    self.contentView.sd_layout
    .centerXEqualToView(self)
    .topSpaceToView(self.pageControl, 0)
    .widthIs(self.contentSize.width)
    .heightIs(self.contentSize.height);

    self.closeBtn.sd_layout
    .topSpaceToView(self.contentView,0)
    .centerXEqualToView(self)
    .widthIs(zn_AutoWidth(30))
    .heightIs(zn_AutoWidth(60));
}

- (void)setContentSize:(CGSize) contentSize{
    _contentSize = contentSize;
    self.contentView.contentSize = contentSize;
    
    self.contentView.sd_layout
    .centerXEqualToView(self)
    .topSpaceToView(self.pageControl, 0)
    .widthIs(self.contentSize.width)
    .heightIs(self.contentSize.height);
}

- (void)setViews:(NSArray<UIView *> *)views{
    _views = views;
    self.pageControl.numberOfPages = views.count;
    [self.contentView setViews:views];
    if (views.count <= 1) {
        [self.pageControl setHidden:YES];
    }else{
        [self.pageControl setHidden:NO];
    }
}

#pragma mark --------ZNTabBarContentViewDelegate---------

- (void)scrollToindex:(int)index{
    self.pageControl.currentPage = index;
}

#pragma mark --------get-------

- (UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.6;
    }
    return _backgroundView;
}

- (ZNTabView *)contentView{
    if (!_contentView) {
        _contentView = [ZNTabView new];
        _contentView.contentSize = self.contentSize;
        _contentView.znDelegate = self;
        _contentView.layer.cornerRadius = 5;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}

- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [UIPageControl new];
        _pageControl.numberOfPages = 2;
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setImage:[UIImage imageNamed:@"upgrade_close"] forState:UIControlStateNormal];
        znWeakSelf(self)
        [[_closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            znStrongSelf
            [weakSelf removeFromSuperview];
            if (weakSelf.closeBlock) {
                weakSelf.closeBlock();
            }
        }];
    }
    return _closeBtn;
}

@end

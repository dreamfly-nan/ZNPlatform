//
//  ZNTextTabBarView.m
//  TableViewCollectView
//
//  Created by 郑楠楠 on 2018/4/2.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//
#import "ZNTitleLabel.h"
#import "ZNTextTabBarView.h"
#import "NSString+ZNString.h"
#import "UIView+ZNView.h"
#import <objc/runtime.h>

#define labelIndex @"index"

@interface ZNTextTabBarView() <ZNTitleLabelDelegate>

/**
 标题下的线条
 */
@property (nonatomic , strong) UIView *lineView;

/**
 标题的载体
 */
@property (nonatomic , strong) UIScrollView *scrollView;

/**
 存放所有的标题
 */
@property (nonatomic , strong) NSMutableArray<ZNTitleLabel*> *labelArray;

//是否已经达到最大宽度
@property (nonatomic , assign) BOOL isScrollViewWidthMax;

//选中项
@property (nonatomic , assign) int chooseIndex;

//角标
@property (nonatomic, strong) UIView * CountView;


@end

@implementation ZNTextTabBarView

#pragma mark -----life-----

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self config];
        [self setupInitUI];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.width > 0 && self.chooseIndex <= 0) {
        [self setUIWithTitle];
    }
}

/**
 配置默认数据项
 */
- (void)config{
    _lineColor = [UIColor redColor];
    _lineType = ZNTextTabBarViewLineStypeWithText;
    _titleNumber = 6;
    _isSelectOnCenterX = YES;
    _isOnCenterX = YES;
    _isSelectOnCenterX = YES;
    _isScrollViewWidthMax = NO;
    _interval = 10;
    _lineHeight = 3;
}

- (void)setupInitUI{
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.lineView];
    
    znWeakSelf(self)
    [RACObserve(self.scrollView, bounds) subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        CGRect rect = [x CGRectValue];
        [weakSelf setUpdateItemHeight:rect.size.height];
    }];
}

/**
 重新更新每一项的高度
 */
- (void)setUpdateItemHeight:(CGFloat)height{
    for (ZNTitleLabel *label in self.labelArray) {
        label.height = height;
    }
}

/**
 是否已存在label，存在则进行移除
 */
- (void)isExitLabel{
    if (self.labelArray.count > 0 ) {
        for (ZNTitleLabel *label in self.labelArray) {
            [label removeFromSuperview];
        }
        [self.labelArray removeAllObjects];
        self.scrollView.contentSize = CGSizeZero;
    }
}

/**
 根据数据重建视图
 */
- (void)setUIWithTitle{
    if (self.titles.count <= 0) {
        return;
    }
    
    [self isExitLabel];
    
    if (_lineType ==  ZNTextTabBarViewLineStypeLong) {
        CGFloat itemWidth = self.width / self.titleNumber;
        self.scrollView.contentSize = CGSizeMake(itemWidth * self.titles.count, 0);
    }
    
    CGFloat width = 0;
    for (int i = 0;i < self.titles.count; i++) {
        ZNTitleLabel * title = [[ZNTitleLabel alloc] init];
        title.textAlignment = NSTextAlignmentCenter;
        title.znDelegate = self;
        //初始化的选中第一个
        if (i == 0) {
            self.chooseIndex = 0;
            self.titles[i].isSelect = YES;
        }
        title.model = self.titles[i];
        [self.labelArray addObject:title];
        [self setLabelPositionWithIndex:i label:title];
        if (self.lineType == ZNTextTabBarViewLineStypeWithText) {
            width += (self.titles[i].width + self.interval);
        }else{
            width = self.width  / self.titleNumber;
        }
        objc_setAssociatedObject(title, labelIndex, @(i), OBJC_ASSOCIATION_ASSIGN);
    }
    [self setScrollViewWithWidth:width];
}

- (void)setScrollViewWithWidth:(CGFloat)width{
    if (self.lineType == ZNTextTabBarViewLineStypeWithText) {
        if (self.labelArray.count > 0) {
            if (self.isOnCenterX) {
                if (self.scrollView.contentSize.width < self.width) {
                    self.scrollView.bounds = CGRectMake(0, 0, width, self.height);
                    self.scrollView.center = CGPointMake(self.width / 2, self.height / 2);
                }else{
                    self.scrollView.frame = self.bounds;
                }
            }else{
                self.scrollView.frame = self.bounds;
            }
            self.lineView.frame = CGRectMake(0, self.labelArray[0].height - self.lineHeight, self.labelArray[0].width, self.lineHeight);
        }
    }else if(self.lineType == ZNTextTabBarViewLineStypeLong){
        CGFloat width = self.width / self.titleNumber - 2*self.interval;
        self.scrollView.frame = self.bounds;
        self.lineView.frame = CGRectMake(self.interval, self.labelArray[0].height - self.lineHeight, width, self.lineHeight);
        self.lineView.layer.cornerRadius = self.lineHeight / 2;
    }
}

/**
 根据顺序进行设置布局

 @param index <#index description#>
 */
- (void)setLabelPositionWithIndex:(int)index label:(ZNTitleLabel*)label{
    CGFloat itemWidth;
    ZNTitleModel *model = self.titles[index];
    if (_lineType ==  ZNTextTabBarViewLineStypeLong) {
        itemWidth = self.width  / self.titleNumber;
        label.frame =CGRectMake(index * itemWidth, 0, itemWidth, self.height);
    }else if(_lineType ==  ZNTextTabBarViewLineStypeWithText){
        itemWidth = [model widthWithHeight:self.height] + self.interval;
        CGSize size = self.scrollView.contentSize;
        CGFloat x = self.interval;
        if (index != 0) {
            x = size.width;
        }else{
//            size.width += self.interval;
            x = size.width;
        }
        label.frame =CGRectMake(x, 0, itemWidth, self.height);
        size.width += itemWidth;
        if(index == (self.titles.count - 1)){
//            size.width += self.interval;
        }
        size.height = 0;
        self.scrollView.contentSize = size;
    }
    
    [self.scrollView addSubview:label];
}

- (void)scrollToLabel:(ZNTitleLabel*)label{
    [self reloadData:label];
    [UIView animateWithDuration:0.5 animations:^{
        if (self.lineType == ZNTextTabBarViewLineStypeLong) {
            self.lineView.zn_x = label.zn_x + self.interval;
        }else{
            CGRect rect = self.lineView.frame;
            rect.origin.x = label.zn_x;
            rect.size.width = label.width;
            self.lineView.frame = rect;
        }
        
        //将选中项移动到控件中间位置
        if (self.isSelectOnCenterX) {
            CGFloat x = label.zn_x + label.width/2;
            CGFloat contentWidth = self.scrollView.contentSize.width;
            CGFloat width = self.scrollView.width;
            if (contentWidth > self.scrollView.width) {
                if (x < width / 2) {
                    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                }else if(x > (contentWidth - width/2))
                {
                    [self.scrollView setContentOffset:CGPointMake(contentWidth - width, 0) animated:YES];
                }else{
                    [self.scrollView setContentOffset:CGPointMake(x - width/2, 0) animated:YES];
                }
            }
        }
    }];
}

#pragma mark ------public------

//滑动到某一项
- (void)scrollToIndex:(int)index{
    if(self.titles.count > 0){
        [self scrollToLabel:self.labelArray[index]];
    }
}

#pragma mark -------ZNTitleLabelDelegate-------

- (void)selectAction:(ZNTitleLabel *)label{
    if(self.znDelegate && [self.znDelegate respondsToSelector:@selector(selectItemWithIndex:model:)]){
        int index = [objc_getAssociatedObject(label, labelIndex) intValue];
        [self.znDelegate selectItemWithIndex:index model:self.titles[index]];
    }
    [self scrollToLabel:label];
}

- (void)reloadData:(ZNTitleLabel*)label{
    int index = [objc_getAssociatedObject(label, labelIndex) intValue];
    self.titles[self.chooseIndex].isSelect = NO;
    self.labelArray[self.chooseIndex].model = self.titles[self.chooseIndex];
    self.titles[index].isSelect = YES;
    self.labelArray[index].model = self.titles[index];
    self.chooseIndex = index;
}

#pragma mark ------set------

- (void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    self.lineView.backgroundColor = lineColor;
}

- (void)setLineHidden:(BOOL)lineHidden{
    _lineHidden = lineHidden;
    [self.lineView setHidden:lineHidden];
}

- (void)setTitles:(NSArray<ZNTitleModel *> *)titles{
    _titles = titles;
    [self setUIWithTitle];
    self.chooseIndex = 0;
}

- (void)setIsRoundLine:(BOOL)isRoundLine{
    _isRoundLine = isRoundLine;
    [self setupDateLineView];
}

- (void)setLineHeight:(CGFloat)lineHeight{
    _lineHeight = lineHeight;
    [self setupDateLineView];
}

/**
 更新线条视图的样式
 */
- (void)setupDateLineView{
    self.lineView.height = self.lineHeight;
    if (self.isRoundLine) {
        self.lineView.layer.cornerRadius = self.lineHeight / 2;
    }else{
        self.lineView.layer.cornerRadius = 0;
    }
}

#pragma mark ------get-----

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (NSMutableArray<ZNTitleLabel*> *)labelArray{
    if (!_labelArray) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = self.lineColor;
    }
    return _lineView;
}


@end

//
//  RPNoDataView.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/22.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPNoDataView.h"

@interface RPNoDataView()

@property (nonatomic , strong) UIImageView *imageView;

@end

@implementation RPNoDataView

+ (instancetype)CreateRPNoDataView{
    RPNoDataView *view = [[RPNoDataView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setInitUI];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)setInitUI{
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.refreshBtn];
    
    self.imageView.sd_layout
    .topSpaceToView(self,zn_AutoHeight(100))
    .centerXEqualToView(self)
    .heightIs(zn_AutoWidth(150))
    .widthIs(zn_AutoWidth(150));
    
    self.titleLabel.sd_layout
    .topSpaceToView(self.imageView, zn_AutoHeight(20))
    .centerXEqualToView(self)
    .leftSpaceToView(self, zn_AutoWidth(30))
    .rightSpaceToView(self, zn_AutoWidth(30))
    .autoHeightRatio(0);
    
    self.refreshBtn.sd_layout
    .topSpaceToView(self.titleLabel, zn_AutoHeight(10))
    .centerXEqualToView(self.titleLabel)
    .widthIs(zn_AutoWidth(80))
    .heightIs(zn_AutoHeight(30));
    
    znWeakSelf(self)
    [[self.refreshBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        if (weakSelf.reloadBlock) {
            weakSelf.reloadBlock();
        }
    }];
}

#pragma mark ------get-------

- (UIButton *)refreshBtn{
    if (!_refreshBtn) {
        _refreshBtn = [UIButton new];
        [_refreshBtn setTitle:@"刷新一下" forState:UIControlStateNormal];
        [_refreshBtn setTitleColor:Main_Color() forState:UIControlStateNormal];
        _refreshBtn.titleLabel.font = zn_font(15);
    }
    return _refreshBtn;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"no_all_data"];
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = zn_font(15);
        _titleLabel.textColor = Title_Color();
        _titleLabel.text = @"数据跑丢拉？？";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end

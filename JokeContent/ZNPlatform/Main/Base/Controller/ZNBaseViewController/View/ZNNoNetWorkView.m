//
//  ZNNoNetWorkView.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/26.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNNoNetWorkView.h"

@interface ZNNoNetWorkView()

@property (nonatomic , strong) UIButton *reloadBtn;

@property (nonatomic , strong) UIImageView *imageView;

@end

@implementation ZNNoNetWorkView

+ (instancetype)createRPNoNetView{
    ZNNoNetWorkView *noNetView = [[ZNNoNetWorkView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    return noNetView;
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
    [self addSubview:self.reloadBtn];
    
    self.imageView.sd_layout
    .topSpaceToView(self, zn_AutoHeight(150))
    .centerXEqualToView(self)
    .heightIs(zn_AutoWidth(64))
    .widthIs(zn_AutoWidth(64));
    
    self.titleLabel.sd_layout
    .centerXEqualToView(self)
    .topSpaceToView(self.imageView, zn_AutoHeight(30))
    .autoHeightRatio(0);
    [self.titleLabel setSingleLineAutoResizeWithMaxWidth:screenWidth];
    
    self.reloadBtn.sd_layout
    .topSpaceToView(self.titleLabel, zn_AutoHeight(30))
    .centerXEqualToView(self)
    .heightIs(zn_AutoWidth(30))
    .widthIs(zn_AutoWidth(64));
    
    znWeakSelf(self)
    [[self.reloadBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        if (weakSelf.reloadBlock) {
            weakSelf.reloadBlock();
        }
    }];
}

#pragma mark ------get-------

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = zn_font(15);
        _titleLabel.textColor = Title_Color();
        _titleLabel.text = @"哎呀，数据跑丢了！";
    }
    return _titleLabel;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"no_all_data"];
    }
    return _imageView;
}

- (UIButton *)reloadBtn{
    if (!_reloadBtn) {
        _reloadBtn = [UIButton new];
        [_reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        _reloadBtn.titleLabel.font = zn_font(15);
        _reloadBtn.backgroundColor = Main_Color();
    }
    return _reloadBtn;
}

@end

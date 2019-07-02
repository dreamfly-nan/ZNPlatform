//
//  RPHeadIconView.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPHeadIconView.h"

@interface RPHeadIconView()

//金币的点击事件
@property (nonatomic , strong) UIButton * gloadBtn;

@end

@implementation RPHeadIconView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(0, 0, screenWidth, zn_AutoHeight(262))]) {
        [self setupInitUI];
        [self setBangding];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)setupInitUI{
    [self addSubview:self.backgroundImage];
    [self addSubview:self.backgroundColorView];
    [self addSubview:self.rpBtn];
    [self addSubview:self.glodImageView];
    [self addSubview:self.glodConLabel];
    [self addSubview:self.ringImage];
    [self addSubview:self.iconImage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.fensNumLabel];
    [self addSubview:self.iconHeadBtn];
    
    [self addSubview:self.gloadBtn];
    
    self.rpBtn.sd_layout
    .rightEqualToView(self)
    .topEqualToView(self)
    .widthIs(zn_AutoWidth(60))
    .heightEqualToWidth();
    
    self.glodImageView.sd_layout
    .centerYEqualToView(self.rpBtn)
    .leftSpaceToView(self, zn_AutoWidth(15))
    .widthIs(zn_AutoWidth(25))
    .heightEqualToWidth();
    
    self.glodConLabel.sd_layout
    .centerYEqualToView(self.glodImageView)
    .leftSpaceToView(self.glodImageView, zn_AutoWidth(5))
    .widthIs(zn_AutoWidth(100))
    .heightIs(zn_AutoWidth(25));
    
    self.gloadBtn.sd_layout
    .leftEqualToView(self.glodImageView)
    .rightEqualToView(self.glodConLabel)
    .topEqualToView(self.glodImageView)
    .bottomEqualToView(self.glodImageView);
    
    self.ringImage.sd_layout
    .topSpaceToView(self, zn_AutoHeight(55))
    .centerXEqualToView(self)
    .widthIs(zn_AutoWidth(130))
    .heightEqualToWidth();
    
    self.iconImage.sd_layout
    .centerXEqualToView(self.ringImage)
    .centerYEqualToView(self.ringImage)
    .widthIs(zn_AutoWidth(109))
    .heightEqualToWidth();
    self.iconImage.layer.cornerRadius = zn_AutoWidth(109/2);
    
    self.nameLabel.sd_layout
    .topSpaceToView(self.ringImage, zn_AutoHeight(12))
    .centerXEqualToView(self)
    .autoHeightRatio(0);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:screenWidth];
    
    self.fensNumLabel.sd_layout
    .topSpaceToView(self.nameLabel, zn_AutoHeight(12))
    .centerXEqualToView(self.nameLabel)
    .autoHeightRatio(0);
    [self.fensNumLabel setSingleLineAutoResizeWithMaxWidth:screenWidth - zn_AutoWidth(60)];
    
    self.iconHeadBtn.sd_layout
    .topEqualToView(self.iconImage)
    .leftEqualToView(self.iconImage)
    .rightEqualToView(self.iconImage)
    .bottomEqualToView(self.iconImage);
}

- (void)setBangding{
    znWeakSelf(self)
    [RACObserve([RPConfig sharedInstance].userData, iconUrl) subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        if (x && ![x isEqualToString:@""]) {
            [weakSelf.backgroundImage sd_setImageWithURL:[NSURL URLWithString:[RPConfig sharedInstance].userData.iconUrl] placeholderImage:[UIImage imageNamed:@"head_background"]];
            [weakSelf.iconImage sd_setImageWithURL:[NSURL URLWithString:[RPConfig sharedInstance].userData.iconUrl] placeholderImage:[UIImage imageNamed:@"head_icon"]];
        }
    }];
    
    [RACObserve([RPConfig sharedInstance].userData, nickName) subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        if (x && ![x isEqualToString:@""]) {
            weakSelf.nameLabel.text = [RPConfig sharedInstance].userData.nickName;
        }
    }];
    
    [RACObserve([RPConfig sharedInstance].userData, introduction) subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        if (x && ![x isEqualToString:@""]) {
            weakSelf.fensNumLabel.text = [RPConfig sharedInstance].userData.introduction;
        }
    }];
    
    [RACObserve([RPConfig sharedInstance].userData, gold_coin) subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        if (x && ![x isEqualToString:@""]) {
            weakSelf.glodConLabel.text = [RPConfig sharedInstance].userData.gold_coin;
        }
    }];
    
    [[self.gloadBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        NSString * number = [NSString stringWithFormat:@"您已获得%@金币！",weakSelf.glodConLabel.text];
        [MBProgressHUD zn_showSuccess:number];
    }];
}

#pragma mark ------------get------------

- (UIButton *)gloadBtn{
    if (!_gloadBtn) {
        _gloadBtn = [UIButton new];
    }
    return _gloadBtn;
}

- (UIImageView *)glodImageView{
    if (!_glodImageView) {
        _glodImageView = [[UIImageView alloc] init];
        _glodImageView.image = [UIImage imageNamed:@"jinbi"];
    }
    return _glodImageView;
}

- (UILabel *)glodConLabel{
    if (!_glodConLabel) {
        _glodConLabel = [UILabel new];
        _glodConLabel.font = zn_font(13);
        _glodConLabel.textColor = [UIColor whiteColor];
    }
    return _glodConLabel;
}

- (UIButton *)iconHeadBtn{
    if (!_iconHeadBtn) {
        _iconHeadBtn = [UIButton new];
    }
    return _iconHeadBtn;
}

- (UIButton *)rpBtn{
    if (!_rpBtn) {
        _rpBtn = [[UIButton alloc] init];
        [_rpBtn setImage:[UIImage imageNamed:@"my_rp"] forState:UIControlStateNormal];
    }
    return _rpBtn;
}

- (UIView *)backgroundColorView{
    if (!_backgroundColorView) {
        _backgroundColorView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundColorView.backgroundColor = [UIColor blackColor];
        _backgroundColorView.alpha = 0.5;
    }
    return _backgroundColorView;
}

- (UIImageView *)backgroundImage{
    if (!_backgroundImage) {
        _backgroundImage = [[UIImageView alloc] initWithFrame:self.bounds];
        _backgroundImage.image = [UIImage imageNamed:@"head_background"];
    }
    return _backgroundImage;
}

- (UIImageView *)ringImage{
    if (!_ringImage) {
        _ringImage = [UIImageView new];
        _ringImage.image = [UIImage imageNamed:@"my_ring"];
        [_ringImage setContentMode:UIViewContentModeScaleToFill];
    }
    return _ringImage;
}

- (UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [UIImageView new];
        [_iconImage setContentMode:UIViewContentModeScaleToFill];
        _iconImage.clipsToBounds = YES;
    }
    return _iconImage;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.text = @"世界尽头";
        _nameLabel.font = zn_font(13);
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UILabel *)fensNumLabel{
    if (!_fensNumLabel) {
        _fensNumLabel = [UILabel new];
        _fensNumLabel.text = @"巴拉巴拉巴拉巴巴拉巴拉巴拉巴拉巴巴拉巴拉巴拉巴拉巴巴拉";
        _fensNumLabel.font = zn_font(14);
        _fensNumLabel.textColor = [UIColor whiteColor];
        _fensNumLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _fensNumLabel;
}
@end

//
//  ZNEmptyView.m
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2019/11/6.
//  Copyright © 2019 ttyx. All rights reserved.
//

#import "ZNEmptyView.h"

@interface ZNEmptyView()

@property (nonatomic , strong) UILabel * textLabel;

@property (nonatomic , strong) UILabel * subTextLabel;

@property (nonatomic , strong) UIImageView * imageView;

@property (nonatomic , strong) UIButton * btn;

@end

@implementation ZNEmptyView

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.text = self.title;
    self.subTextLabel.text = self.subTitle;
    [self.btn setTitle:self.btnText forState:UIControlStateNormal];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)]) {
        [self setInitUI];
    }
    return self;
}

- (void)setInitUI{
    self.isShowBtn = YES;
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.imageView];
    [self addSubview:self.textLabel];
    [self addSubview:self.subTextLabel];
    [self addSubview:self.btn];
    
    self.imageView.sd_layout
    .topSpaceToView(self, zn_AutoWidth(144))
    .centerXEqualToView(self)
    .widthIs(zn_AutoWidth(121))
    .heightIs(zn_AutoWidth(100));
    
    self.textLabel.sd_layout
    .topSpaceToView(self.imageView, zn_AutoWidth(19.5))
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(zn_AutoWidth(15));
    
    self.subTextLabel.sd_layout
    .topSpaceToView(self.textLabel, zn_AutoWidth(6.5))
    .leftEqualToView(self)
    .rightEqualToView(self)
    .heightIs(12);
    
    self.btn.sd_layout
    .topSpaceToView(self.subTextLabel, zn_AutoWidth(40.5))
    .centerXEqualToView(self.subTextLabel)
    .widthIs(zn_AutoWidth(100))
    .heightIs(zn_AutoWidth(30));
    
    self.btn.sd_cornerRadius = @(zn_AutoWidth(15));
}

- (void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    self.imageView.image = zn_imageName(imageName);
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.textLabel.text = title;
}

- (void)setSubTitle:(NSString *)subTitle{
    _subTitle = subTitle;
    self.subTextLabel.text = subTitle;
}

- (void)setIsShowBtn:(BOOL)isShowBtn{
    _isShowBtn = isShowBtn;
    self.btn.hidden = !isShowBtn;
}

#pragma mark - public

/// 距离顶部的高度
/// @param height <#height description#>
- (void)topHeight:(CGFloat) height{
    self.imageView.sd_layout
    .topSpaceToView(self, height);
}

#pragma mark - get

- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = UILabel.zn_create
        .zn_font(zn_font(14))
        .zn_textColor(zn_colorString(@"#484848"))
        .zn_alignment(NSTextAlignmentCenter);
    }
    return _textLabel;
}

- (UILabel *)subTextLabel{
    if (!_subTextLabel) {
        _subTextLabel = UILabel.zn_create
        .zn_font(zn_font(12))
        .zn_textColor(CONTENT_COLOR)
        .zn_alignment(NSTextAlignmentCenter);
    }
    return _subTextLabel;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = UIButton.zn_create
        .zn_font(zn_font(15))
        .zn_titleColor([UIColor whiteColor],UIControlStateNormal);
        _btn.backgroundColor = MAIN_COLOR;
        znWeakSelf(self)
        [[_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            znStrongSelf
            if (weakSelf.btnActionBlock) {
                weakSelf.btnActionBlock();
            }
        }];
    }
    return _btn;
}

@end

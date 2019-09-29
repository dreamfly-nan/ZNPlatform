//
//  ZNTextField.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/5.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNTextField.h"

@interface ZNTextField()

@property(nonatomic,strong) UIImageView * imageView;

@end

@implementation ZNTextField

#pragma mark - life

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self onlyRead];
        [self addView];
        [self config];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setInitUI];
}

#pragma mark - private

- (void)onlyRead{
    if (!self.textField) {
        _textField = [UITextField new];
        //设置首字母不大写
        [_textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    }
}

- (void)config{
    self.inset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.isLeftView = NO;
    self.imageSize = CGSizeMake(zn_AutoWidth(20), zn_AutoWidth(20));
    self.imageSpace = zn_AutoWidth(10);
}

- (void)addView{
    if (self.isLeftView) {
        [self addSubview:self.imageView];
    }
    [self addSubview:self.textField];
}

- (void)setInitUI{
    if (self.isLeftView) {
        
        if (![self.subviews containsObject:self.imageView]) {
            [self addSubview:self.imageView];
        }
        
        self.imageView.image = self.leftImage;
        self.imageView.sd_layout
        .leftSpaceToView(self, self.inset.left)
        .centerYEqualToView(self)
        .widthIs(self.imageSize.width)
        .heightIs(self.imageSize.height);
        
        self.textField.sd_layout
        .leftSpaceToView(self.imageView, self.imageSpace)
        .rightSpaceToView(self, self.inset.right)
        .topSpaceToView(self, self.inset.top)
        .bottomSpaceToView(self, self.inset.bottom);
    }else{
        self.textField.sd_layout
        .leftSpaceToView(self, self.inset.left)
        .rightSpaceToView(self, self.inset.right)
        .topSpaceToView(self, self.inset.top)
        .bottomSpaceToView(self, self.inset.bottom);
    }
}

#pragma mark - set

- (void)setSecureTextEntry:(BOOL)secureTextEntry{
    _secureTextEntry = secureTextEntry;
    self.textField.secureTextEntry = secureTextEntry;
}

#pragma mark - get

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.image = self.leftImage;
    }
    return _imageView;
}

@end

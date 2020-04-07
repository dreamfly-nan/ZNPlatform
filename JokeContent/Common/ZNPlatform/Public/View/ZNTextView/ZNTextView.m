//
//  ZNTextView.m
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2019/11/4.
//  Copyright © 2019 ttyx. All rights reserved.
//

#import "ZNTextView.h"
@interface ZNTextView()<UITextViewDelegate>

@property (nonatomic , strong) UIButton * clickBtn;

//占位
@property (nonatomic , strong) UILabel * placeLabel;

@end

@implementation ZNTextView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setInitUI];
        [self setBangding];
    }
    return self;
}

- (void)setInitUI{
    [self addSubview:self.textView];
    [self addSubview:self.placeLabel];
    [self addSubview:self.clickBtn];
    
    self.textView.sd_layout
    .topSpaceToView(self, zn_AutoWidth(16))
    .leftSpaceToView(self, zn_AutoWidth(15))
    .rightSpaceToView(self, zn_AutoWidth(15))
    .bottomSpaceToView(self, zn_AutoWidth(16));
    
    self.placeLabel.sd_layout
    .topEqualToView(self.textView)
    .leftEqualToView(self.textView)
    .rightEqualToView(self.textView)
    .autoHeightRatio(0);
    
    self.clickBtn.sd_layout
    .topEqualToView(self.textView)
    .leftEqualToView(self.textView)
    .rightEqualToView(self.textView)
    .bottomEqualToView(self.textView);
}

- (void)setBangding{
    znWeakSelf(self)
    [[self.clickBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        znStrongSelf
        weakSelf.clickBtn.hidden = YES;
        weakSelf.placeLabel.hidden = YES;
        [weakSelf.textView becomeFirstResponder];
    }];
    
    [[self.textView rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        znStrongSelf
        if (weakSelf.textView.text.length <= 0) {
            weakSelf.clickBtn.hidden = NO;
            weakSelf.placeLabel.hidden = NO;
            [weakSelf endEditing:YES];
        }else if (weakSelf.textView.text.length > 50){
            [weakSelf endEditing:YES];
            return;
        }
        
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(ChangeTextDelegate:)]) {
            [weakSelf.delegate ChangeTextDelegate:weakSelf.textView.text.length];
        }
    }];
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if (textView.text.length <= 0) {
        self.clickBtn.hidden = NO;
        self.placeLabel.hidden = NO;
    }
    return YES;
}

- (void)setText:(NSString *)text{
    _text = text;
    if (text.length > 0) {
        self.clickBtn.hidden = YES;
        self.placeLabel.hidden = YES;
    }else{
        self.clickBtn.hidden = NO;
        self.placeLabel.hidden = NO;
    }
    
    self.textView.text = text;
}

- (void)setPlaceStr:(NSString *)placeStr{
    _placeStr = placeStr;
    self.placeLabel.text = placeStr;
}

- (void)setPlaceFont:(UIFont *)placeFont{
    _placeFont = placeFont;
    self.placeLabel.font = placeFont;
}

- (void)setPlaceColor:(UIColor *)placeColor{
    _placeColor = placeColor;
    self.placeLabel.textColor = placeColor;
}

#pragma mark - get

- (UITextView *)textView{
    if (!_textView) {
        _textView = [UITextView new];
        _textView.font = zn_font(14);
        _textView.textColor = TITLE_COLOR;
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textContainerInset = UIEdgeInsetsZero;
        _textView.delegate = self;
    }
    return _textView;
}

- (UILabel *)placeLabel{
    if (!_placeLabel) {
        _placeLabel = UILabel.zn_create
        .zn_font(self.placeFont)
        .zn_textColor(self.placeColor)
        .zn_text(self.placeStr)
        .zn_alignment(NSTextAlignmentLeft);
    }
    return _placeLabel;
}

- (UIButton *)clickBtn{
    if (!_clickBtn) {
        _clickBtn  = UIButton.zn_create;
    }
    return _clickBtn;
}

@end

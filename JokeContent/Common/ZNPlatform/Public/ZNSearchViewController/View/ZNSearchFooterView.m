//
//  ZNSearchFooterView.m
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2019/12/17.
//  Copyright © 2019 ttyx. All rights reserved.
//

#import "ZNSearchFooterView.h"

@interface ZNSearchFooterView()

@property (nonatomic , strong) UIView * lineView;

@end

@implementation ZNSearchFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.lineView];
        self.lineView.sd_layout
        .bottomEqualToView(self)
        .leftEqualToView(self)
        .rightEqualToView(self)
        .heightIs(zn_AutoWidth(5));
    }
    return self;
}

#pragma mark - get

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView zn_createWithColor:zn_colorString(@"#f7f7f7")];
    }
    return _lineView;
}

@end

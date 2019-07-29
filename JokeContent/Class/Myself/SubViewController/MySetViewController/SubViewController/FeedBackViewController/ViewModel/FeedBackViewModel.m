//
//  FeedBackViewModel.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/22.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "FeedBackViewModel.h"

@implementation FeedBackViewModel

- (void)setInitUI{
    [self.controller.view addSubview:self.titleLabel];
    [self.controller.view addSubview:self.textView];
    [self.controller.view addSubview:self.commitBtn];
    
    self.titleLabel.sd_layout
    .leftSpaceToView(self.controller.view, zn_AutoWidth(15))
    .topSpaceToView(self.controller.view, zn_AutoWidth(50))
    .rightSpaceToView(self.controller.view, zn_AutoWidth(15))
    .heightIs(zn_AutoWidth(30));
    
    self.commitBtn.sd_layout
    .topSpaceToView(self.textView, zn_AutoWidth(50))
    .leftSpaceToView(self.controller.view, zn_AutoWidth(50))
    .rightSpaceToView(self.controller.view, zn_AutoWidth(50))
    .heightIs(zn_AutoWidth(40));
    
    self.commitBtn.sd_cornerRadius = @5;
}

#pragma mark - get

- (UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [UIButton new];
        _commitBtn.backgroundColor = Main_Color();
        [_commitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _commitBtn.titleLabel.font = zn_font(15);
    }
    return _commitBtn;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = zn_font(14);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = Content_Color();
    }
    return _titleLabel;
}

- (CXTextView *)textView{
    if (!_textView) {
        _textView = [[CXTextView alloc] initWithFrame:CGRectMake(zn_AutoWidth(15), zn_AutoWidth(85),screenWidth - zn_AutoWidth(30), zn_AutoWidth(400))];
        _textView.backgroundColor = Big_background_Color();
        _textView.layer.cornerRadius = 5;
        _textView.initiLine = 2;
        _textView.maxLine = 4;
        _textView.v_margin = 10;
        _textView.h_margin = 15;
        _textView.maxLength = 100;
        _textView.placeholder = @"说点什么吧";
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.tintColor = Content_Color();
        
//        znWeakSelf(self)
        //文字改变
        _textView.textDidChangeHandlerBlock = ^(UITextView *textView) {
//            znStrongSelf
//            if ([[textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
//                weakSelf.commitBtn.enabled = NO;
//            } else {
//                weakSelf.commitBtn.enabled = YES;
//            }
        };
        
        //最大字数回调
        _textView.textLengthDidMaxHandlerBlock = ^(UITextView * _Nonnull textView) {
            [MBProgressHUD zn_showError:@"您好，反馈最多100个字。"];
        };
    }
    return _textView;
}

@end

//
//  UITextView+ZNUITextView.m
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2020/4/29.
//  Copyright © 2020 ttyx. All rights reserved.
//

#import "UITextView+ZNUITextView.h"

@implementation UITextView (ZNUITextView)

+ (void)zn_setMacNumber:(UITextView *)textView number:(int) number tips:(NSString *)tips{
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
    if([lang isEqualToString:@"zh-Hans"]){ //简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        if (!position){//非高亮
            if (textView.text.length > number) {
                textView.text = [textView.text substringToIndex:number];
                if (tips != nil && ![tips isEqualToString:@""]) {
                    [MBProgressHUD zn_showError:tips];
                }
            }
        }
    }else{//中文输入法以外
        if (textView.text.length > number) {
            textView.text = [textView.text substringToIndex:number];
            if (tips != nil && ![tips isEqualToString:@""]) {
                [MBProgressHUD zn_showError:tips];
            }
        }
    }
}

@end

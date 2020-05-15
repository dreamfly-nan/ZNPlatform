//
//  UITextField+ZNTextField.m
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2019/11/20.
//  Copyright © 2019 ttyx. All rights reserved.
//

#import "UITextField+ZNTextField.h"

@implementation UITextField (ZNTextField)

+ (void)zn_setMacNumber:(UITextField *)textField number:(int) number tips:(NSString *)tips{
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
    if([lang isEqualToString:@"zh-Hans"]){ //简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position){//非高亮
            if (textField.text.length > number) {
                textField.text = [textField.text substringToIndex:number];
                if (tips != nil && ![tips isEqualToString:@""]) {
                    [MBProgressHUD zn_showError:tips];
                }
            }
        }
    }else{//中文输入法以外
        if (textField.text.length > number) {
            textField.text = [textField.text substringToIndex:number];
            if (tips != nil && ![tips isEqualToString:@""]) {
                [MBProgressHUD zn_showError:tips];
            }
        }
    }
}


/// 设置最大输入字符长度
/// @param number <#number description#>
- (void)zn_setMaxNumber:(int) number tips:(NSString*) tips{
    if (self.text.length > number) {
        self.text = [self.text substringToIndex:number];
        [MBProgressHUD zn_showError:tips];
    }
}

@end

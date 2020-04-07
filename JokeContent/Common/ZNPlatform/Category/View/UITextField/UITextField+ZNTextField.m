//
//  UITextField+ZNTextField.m
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2019/11/20.
//  Copyright © 2019 ttyx. All rights reserved.
//

#import "UITextField+ZNTextField.h"

@implementation UITextField (ZNTextField)

/// 设置最大输入字符长度
/// @param number <#number description#>
- (void)zn_setMaxNumber:(int) number tips:(NSString*) tips{
    if (self.text.length > number) {
        self.text = [self.text substringToIndex:number];
        [MBProgressHUD zn_showError:tips];
    }
}

@end

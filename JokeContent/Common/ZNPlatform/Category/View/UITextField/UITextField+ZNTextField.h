//
//  UITextField+ZNTextField.h
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2019/11/20.
//  Copyright © 2019 ttyx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (ZNTextField)

/// 设置最大字符，有监听中文的使用这个
/// @param textField <#textField description#>
/// @param number <#number description#>
/// @param tips <#tips description#>
+ (void)zn_setMacNumber:(UITextField *) textField number:(int) number tips:(NSString*) tips;

/// 设置最大输入字符长度
/// @param number <#number description#>
- (void)zn_setMaxNumber:(int) number
                   tips:(NSString*) tips;

@end

NS_ASSUME_NONNULL_END

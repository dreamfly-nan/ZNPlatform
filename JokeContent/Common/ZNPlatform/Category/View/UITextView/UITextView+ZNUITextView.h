//
//  UITextView+ZNUITextView.h
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2020/4/29.
//  Copyright © 2020 ttyx. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (ZNUITextView)

/// 设置最大字符，有监听中文的使用这个
/// @param textField <#textField description#>
/// @param number <#number description#>
/// @param tips <#tips description#>
+ (void)zn_setMacNumber:(UITextView *) textField number:(int) number tips:(NSString*) tips;

@end

NS_ASSUME_NONNULL_END

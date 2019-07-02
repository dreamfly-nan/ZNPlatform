//
//  ZNAlertDialogTool.h
//  JokeContent
//
//  Created by 南木南木 on 2019/6/26.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZNAlertDialogTool : UIView

/**
 展示弹窗，只有单个按键
 @param title 标题
 @param message 消息
 @param str 按键的文字
 */
+ (void)zn_showController:(UIViewController*) controller
                 title:(NSString*)title
               message:(NSString*)message
               sureStr:(NSString*)str
                    block:(void (^)(void)) block;

/**
 点击确定按键，返回YES，点击取消返回NO

 @param controller <#controller description#>
 @param title <#tile description#>
 @param message <#message description#>
 @param sureTitle <#sureTitle description#>
 @param cancelTitle <#cancelTitle description#>
 @param block <#block description#>
 */
+ (void)zn_showController:(UIViewController*) controller
                 title:(NSString*)title
               message:(NSString*)message
             sureTitle:(NSString*) sureTitle
           cancelTitle:(NSString*) cancelTitle
                 block:(void (^)(BOOL sure)) block;

/**
 底部展示选项对话框,index 从 0 开始
 @param controller <#controller description#>
 @param arrayStr <#arrayStr description#>
 @param block <#block description#>
 */
+ (void)zn_showController:(UIViewController *)controller
              arrayStr:(NSArray<NSString*> *) arrayStr
                 block:(void (^)(int index)) block;

@end

NS_ASSUME_NONNULL_END

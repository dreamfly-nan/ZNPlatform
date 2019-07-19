//
//  ZNAlertDialogTool.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/26.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNAlertDialogTool.h"

@interface ZNAlertDialogTool()

@end

@implementation ZNAlertDialogTool

/**
 展示弹窗，只有单个按键
 @param title 标题
 @param message 消息
 @param str 按键的文字
 */
+ (void)zn_showController:(UIViewController*) controller
                 title:(NSString* __nullable)title
               message:(NSString*)message
               sureStr:(NSString*)str
                    block:(void (^)(void)) block{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * sureAction = [UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block();
        }
    }];
    
    [alertController addAction:sureAction];
    
    [controller presentViewController:alertController animated:YES completion:nil];
}

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
                 title:(NSString* __nullable)title
               message:(NSString*)message
             sureTitle:(NSString*) sureTitle
           cancelTitle:(NSString*) cancelTitle
                 block:(void (^)(BOOL sure)) block{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * sureAction = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block(YES);
        }
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (block) {
            block(NO);
        }
    }];
    
    [alertController addAction:sureAction];
    [alertController addAction:cancelAction];
    
    [controller presentViewController:alertController animated:YES completion:nil];
}

/**
 底部展示选项对话框,index 从 0 开始
 @param controller <#controller description#>
 @param arrayStr <#arrayStr description#>
 @param block <#block description#>
 */
+ (void)zn_showController:(UIViewController *)controller
              arrayStr:(NSArray<NSString*> *) arrayStr
                 block:(void (^)(int index)) block{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int index = 0; index < arrayStr.count ; index ++) {
        UIAlertAction * action = [UIAlertAction actionWithTitle:arrayStr[index] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (block) {
                block(index);
            }
        }];
        [alertController addAction:action];
    }
    [controller presentViewController:alertController animated:YES completion:nil];
}

@end

//
//  ZNWebController.h
//  JokeContent
//
//  Created by 南木南木 on 2019/6/25.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNJSManager.h"
#import "ZNBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZNWebController : ZNBaseViewController

@property(nonatomic,strong) WKWebView * webView;

@property (copy , nonatomic) NSString * url;

/**
 设置进度条的填充颜色
 */
@property(nonatomic,strong) UIColor * progressColor;

/**
 进度条背景色
 */
@property(nonatomic,strong) UIColor * trackTintColor;

@property(nonatomic,strong ,readonly) ZNJSManager * manager;

/**
 是否展示关闭按键
 */
@property(nonatomic,assign) BOOL showCloseBtn;

/**
 调用js的方法，并传参，方法的参数顺序是从前往后，依次填入

 @param name 方法名
 @param parameters 参数
 @param block 执行结果的回调
 */
- (void)sendDataToJSWithName:(NSString*) name
                  parameters:(NSArray<NSString*> *) parameters
                       block:(void (^)(id _Nullable response,NSError * error)) block;

@end

NS_ASSUME_NONNULL_END

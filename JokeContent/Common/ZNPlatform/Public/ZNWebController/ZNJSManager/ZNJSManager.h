//
//  ZNJSManager.h
//  JokeContent
//
//  Created by 南木南木 on 2019/6/17.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN

@protocol ZNJSManagerDelegate <NSObject>

@required

/**
 js推送过来的消息接收
 @param userContentController <#userContentController description#>
 @param message <#message description#>
 */
- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message data:(id) data;

@end

@interface ZNJSManager : NSObject <WKUIDelegate,WKScriptMessageHandler>

@property(nonatomic,weak) id<ZNJSManagerDelegate> znDelegate;

+ (instancetype)initWithWebView:(WKWebView*) webView controller:(UIViewController*) controller;

/// 注入方法
/// @param funcationName <#funcationName description#>
- (void)insertFuncation:(NSString *) funcationName;

/// 设置前置数据
/// @param name <#name description#>
/// @param dataStr <#dataStr description#>
- (void)insertBeforeDataWithClassName:(NSString *) name
                                 data:(NSString*) dataStr;

@end

NS_ASSUME_NONNULL_END

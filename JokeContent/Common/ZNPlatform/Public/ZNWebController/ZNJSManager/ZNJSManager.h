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
 前置数据的提取对象名
 @return <#return value description#>
 */
- (NSString *) beforDateToWebViewClassName;

/**
 设置webview的前置数据,如果要设置前置数据，则需要进行设置web的configuration对象，
 则是使用 initWithFrame: configuration: 这个函数进行实例化
 @return <#return value description#>
 */
- (NSString*) beforeDateToWebView;

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

@end

NS_ASSUME_NONNULL_END

//
//  ZNJSManager.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/17.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNJSManager.h"
#import "ZNWebController.h"

@interface ZNJSManager ()

@property(nonatomic,strong)WKWebView  * webView;

@property(nonatomic,weak) UIViewController * controller;

@end

@implementation ZNJSManager

+ (instancetype)initWithWebView:(WKWebView*) webView controller:(UIViewController*) controller{
    ZNJSManager * manager = [ZNJSManager new];
    manager.controller = controller;
    manager.webView = webView;
    manager.webView.UIDelegate = manager;
    return manager;
}

#pragma mark - set

- (void)setZnDelegate:(id<ZNJSManagerDelegate>)znDelegate{
    _znDelegate = znDelegate;
    if (znDelegate && [znDelegate respondsToSelector:@selector(beforDateToWebViewClassName)]) {
        NSString * className = znDelegate.beforDateToWebViewClassName;
        if (znDelegate && [znDelegate respondsToSelector:@selector(beforeDateToWebView)]) {
            NSString * dataStr = znDelegate.beforeDateToWebView;
            NSString * jsStr = [NSString stringWithFormat:@"window.%@ = %@",className,dataStr];
            WKUserScript *script = [[WKUserScript alloc] initWithSource:jsStr injectionTime:(WKUserScriptInjectionTimeAtDocumentStart) forMainFrameOnly:YES];
            if (self.webView.configuration) {
                [self.webView.configuration.userContentController addUserScript:script];
            }
        }
    }
}

#pragma mark - WKUIDelegate

#pragma mark - WKScriptMessageHandler

#pragma mark - WKNavigationDelegate

- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    //接受js发送的消息
    if (self.znDelegate && [self.znDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:data:)]) {
        [self.znDelegate userContentController:userContentController didReceiveScriptMessage:message data:message.body];
    }
}

@end

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

/// 注入方法
/// @param funcationName <#funcationName description#>
- (void)insertFuncation:(NSString *) funcationName{
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:funcationName];
}

/// 设置前置数据
/// @param name <#name description#>
/// @param dataStr <#dataStr description#>
- (void)insertBeforeDataWithClassName:(NSString *) name
                                 data:(NSString*) dataStr{
    if ([name isEqualToString:@""] || name == nil) {
        NSLog(@"类名不能为空");
        return;
    }
    if ([dataStr isEqualToString:@""] || dataStr == nil) {
        NSLog(@"数据不能为空");
        return;
    }
    
    NSString * jsStr = [NSString stringWithFormat:@"window.%@ = %@",name,dataStr];
    WKUserScript *script = [[WKUserScript alloc] initWithSource:jsStr injectionTime:(WKUserScriptInjectionTimeAtDocumentStart) forMainFrameOnly:YES];
    if (self.webView.configuration) {
        [self.webView.configuration.userContentController addUserScript:script];
    }
}

#pragma mark - WKUIDelegate

#pragma mark - WKScriptMessageHandler

- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    //接受js发送的消息
    if (self.znDelegate && [self.znDelegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:data:)]) {
        [self.znDelegate userContentController:userContentController didReceiveScriptMessage:message data:message.body];
    }
}

#pragma mark - WKNavigationDelegate

@end

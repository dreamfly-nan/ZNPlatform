//
//  TestWebControllerViewController.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/27.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "TestWebControllerViewController.h"

@interface TestWebControllerViewController () <WKNavigationDelegate>

@end

@implementation TestWebControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //加载本地HTML
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];

    NSURL *url = [NSURL URLWithString:filePath];
    [self.webView loadHTMLString:htmlString baseURL:url];
//    self.webView.navigationDelegate = self;
//
//    [self sendDataToJSWithName: @"test" parameters:@[@"1",@"2"] block:^(id  _Nullable response, NSError * _Nonnull error) {
//        NSLog(@"%@",response);
//    }];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}

@end

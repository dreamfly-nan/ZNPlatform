//
//  TestWebControllerViewController.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/27.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "TestWebControllerViewController.h"

@interface TestWebControllerViewController () <WKNavigationDelegate,WKUIDelegate>

@end

@implementation TestWebControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //加载本地HTML
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSURL *url = [NSURL URLWithString:filePath];
    NSArray * urls = [self componentsSeparatedFromString:@"<video " toString:@">" html:htmlString];
    
    NSArray * currentUrls = [self componentsSeparatedFromString:@"src=\"" toString:@"\"" html:urls[0]];
    NSLog(@"");
//    [self.webView loadHTMLString:htmlString baseURL:url];
//    self.webView.navigationDelegate = self;
//    [self sendDataToJSWithName: @"test" parameters:@[@"1",@"2"] block:^(id  _Nullable response, NSError * _Nonnull error) {
//        NSLog(@"%@",response);
//    }];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}


- (NSArray *)componentsSeparatedFromString:(NSString *)fromString toString:(NSString *)toString html:(NSString *) html
{
    if (!fromString || !toString || fromString.length == 0 || toString.length == 0) {
        return nil;
    }
    
    NSMutableArray *subStringsArray = [[NSMutableArray alloc] init];
    NSString *tempString = html;
    NSRange range = [tempString rangeOfString:fromString];
    
    while (range.location != NSNotFound) {
        tempString = [tempString substringFromIndex:(range.location + range.length)];
        range = [tempString rangeOfString:toString];
        if (range.location != NSNotFound) {
            [subStringsArray addObject:[tempString substringToIndex:range.location]];
            range = [tempString rangeOfString:fromString];
        }
        else
        {
            break;
        }
    }
    return subStringsArray;
}

@end

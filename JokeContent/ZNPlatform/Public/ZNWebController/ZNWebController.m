//
//  ZNWebController.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/25.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNWebController.h"

@interface ZNWebController ()<WKNavigationDelegate>

/**
 进度条
 */
@property(nonatomic,strong) UIProgressView * progressView;

/**
 返回按键
 */
@property(nonatomic,strong) UIBarButtonItem * backBtnItem;

/**
 关闭
 */
@property(nonatomic,strong) UIBarButtonItem * closeBtnItem;

@end

@implementation ZNWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSetUI];
    [self setBangding];
    [self initManager];
    if (self.url && ![self.url isEqualToString:@""]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    }else{
        NSLog(@"url is nil or empty ！");
    }
}

- (void)initSetUI{
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    if (self.navigationController) {
        self.progressView.sd_layout
        .topSpaceToView(self.view, znStateHeight + self.navigationHeight)
        .leftEqualToView(self.webView)
        .rightEqualToView(self.webView)
        .heightIs(zn_AutoHeight(2));
    }else{
        self.progressView.sd_layout
        .topEqualToView(self.webView)
        .leftEqualToView(self.webView)
        .rightEqualToView(self.webView)
        .heightIs(zn_AutoHeight(2));
    }
    
    if (self.navigationController) {
        self.navigationItem.leftBarButtonItems = @[self.backBtnItem];
        if (self.showCloseBtn) {
            self.navigationItem.leftBarButtonItems = @[self.backBtnItem,self.closeBtnItem];
        }
    }
}

- (void)setBangding{
    znWeakSelf(self)
    [RACObserve(self.webView, estimatedProgress) subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        if (weakSelf.webView.estimatedProgress != 1) {
            weakSelf.progressView.progress = weakSelf.webView.estimatedProgress;
        }else{
            weakSelf.progressView.hidden = YES;
        }
    }];
}

/**
 初始化管理
 */
- (void)initManager{
    if (!_manager) {
        _manager = [ZNJSManager initWithWebView:self.webView controller:self];
    }
}

- (BOOL)isHTTPEnable {
    if([[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] != NSOrderedAscending){
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        BOOL enable = [[[infoDict objectForKey:@"NSAppTransportSecurity"] objectForKey:@"NSAllowsArbitraryLoads"] boolValue];
        return enable;
    }
    return YES;
}

#pragma mark - public

/**
 调用js的方法，并传参，方法的参数顺序是从前往后，依次填入
 
 @param name 方法名
 @param parameters 参数
 @param block 执行结果的回调
 */
- (void)sendDataToJSWithName:(NSString*) name
                  parameters:(NSArray<NSString*> *) parameters
                       block:(void (^)(id _Nullable response,NSError * error)) block{
    NSMutableString * jsStr = [NSMutableString new];
    
    if (parameters && parameters.count > 0) {
        NSMutableString * parameter = [NSMutableString new];
        for (NSString * str in parameters) {
            [parameter appendFormat:@"%@,",str];
        }
        NSString * parStr = [parameter substringToIndex:parameter.length - 1];
        [jsStr appendFormat:@"%@(%@)",name,parStr];
    }else{
        [jsStr appendFormat:@"%@()",name];
    }
    
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        if (block) {
            block(response,error);
        }
    }];
}

- (void)setUrl:(NSString *)url{
    _url = url;
    if (![url isEqualToString:@""] && url) {
        NSString * headUrl = [url substringWithRange:NSMakeRange(0, 5)];
        if ([headUrl isEqualToString:@"http:"]) {
            if (![self isHTTPEnable]) {
                NSLog(@"the permissions for http request are no set,please set them in plist file.");
            }
        }
    }
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.progressView.hidden = NO;
}

#pragma mark - target

- (void)backAction{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self closeAction];
    }
}

- (void)closeAction{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - set

- (void)setTrackTintColor:(UIColor *)trackTintColor{
    _trackTintColor = trackTintColor;
    self.progressView.trackTintColor = trackTintColor;
}

- (void)setProgressColor:(UIColor *)progressColor{
    _progressColor = progressColor;
    self.progressView.progressTintColor = progressColor;
}

#pragma mark - get

- (WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration * configuration = [WKWebViewConfiguration new];
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [UIProgressView new];
        _progressView.progressTintColor = [UIColor blueColor];
    }
    return _progressView;
}

- (UIBarButtonItem *)backBtnItem{
    if (!_backBtnItem) {
        _backBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    }
    return _backBtnItem;
}

- (UIBarButtonItem *)closeBtnItem{
    if (!_closeBtnItem) {
        _closeBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeAction)];
        _closeBtnItem.accessibilityElementsHidden = YES;
    }
    return _closeBtnItem;
}

@end

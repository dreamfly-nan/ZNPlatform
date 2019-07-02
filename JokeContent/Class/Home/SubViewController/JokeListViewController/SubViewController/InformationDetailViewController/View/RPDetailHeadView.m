//
//  RPDetailHeadView.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/5.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPDetailHeadView.h"

@interface RPDetailHeadView() <WKUIDelegate,WKNavigationDelegate>

@property (nonatomic , strong) WKWebViewConfiguration *configuration;

@property (nonatomic , assign) BOOL  isFrishtLoad;

@property(nonatomic,assign) CGFloat lastHeight;

@end

@implementation RPDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(0, 0, screenWidth, zn_AutoWidth(160))]) {
        [self config];
        [self setupInitUI];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)config{
    self.isFrishtLoad = YES;
    self.isLoadFinish = NO;
    self.isSuccess = YES;
}

- (void)setupInitUI{
    [self addSubview:self.iconImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.attentionBtn];
    [self addSubview:self.webView];
    
    self.iconImageView.sd_layout
    .leftSpaceToView(self, zn_AutoWidth(20))
    .topSpaceToView(self, zn_AutoWidth(10))
    .widthIs(zn_AutoWidth(35))
    .heightEqualToWidth();
    self.iconImageView.layer.cornerRadius = zn_AutoWidth(35/2);
    
    self.nameLabel.sd_layout
    .leftSpaceToView(self.iconImageView, zn_AutoWidth(10))
    .topEqualToView(self.iconImageView)
    .autoHeightRatio(0);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:screenWidth/3];
    
    self.timeLabel.sd_layout
    .leftEqualToView(self.nameLabel)
    .bottomEqualToView(self.iconImageView)
    .autoHeightRatio(0);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:screenWidth - zn_AutoWidth(80)];
    
    self.attentionBtn.sd_layout
    .centerYEqualToView(self.iconImageView)
    .rightSpaceToView(self, zn_AutoWidth(20))
    .widthIs(zn_AutoWidth(45))
    .heightIs(20);
    
    self.webView.sd_layout
    .leftEqualToView(self)
    .topSpaceToView(self.iconImageView, zn_AutoWidth(15))
    .rightEqualToView(self)
    .heightIs(zn_AutoHeight(100));
    
    znWeakSelf(self)
    [RACObserve(self.webView.scrollView, contentSize) subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        if (!weakSelf.isFrishtLoad) {
            CGFloat height = weakSelf.webView.scrollView.contentSize.height;
            if (weakSelf.lastHeight == height) {
                weakSelf.isFrishtLoad = YES;
            }
            
            weakSelf.lastHeight = height;
#ifdef DEBUG
            NSLog(@"height = %f",height);
#endif
            
            weakSelf.webView.sd_layout.heightIs(height);
            weakSelf.height = weakSelf.webView.scrollView.contentSize.height + zn_AutoWidth(60);
            weakSelf.isLoadFinish = YES;
            weakSelf.isSuccess = YES;
        }
    }];
    
    [RACObserve(self.webView, URL) subscribeNext:^(id  _Nullable x) {
        znStrongSelf
        weakSelf.lastHeight = 0;
        weakSelf.isFrishtLoad = NO;
    }];
}

#pragma mark - public

/**
 返回 YES 则跳转到上个页面，NO则不进行跳转
 
 @return <#return value description#>
 */
- (BOOL)isBackViewControllerOrWeb{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        return NO;
    }else{
        return YES;
    }
}

#pragma mark ----------WKNavigationDelegate------------

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    znWeakSelf(self)
    [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
        znStrongSelf
        weakSelf.isFrishtLoad = NO;
        weakSelf.isLoadFinish = YES;
        weakSelf.isSuccess = YES;
    }];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
     self.isLoadFinish = YES;
    self.isSuccess = NO;
}

#pragma mark --------set---------

- (void)setModel:(NewsDetailModel *)model{
    _model = model;
    if (model.link && ![model.link isEqualToString:@""]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.link]]];
    }else{
        self.isLoadFinish = YES;
        self.isSuccess = NO;
    }
    
    self.iconImageView.image = [UIImage imageNamed:UserIconPlaceHoldImage];
    self.nameLabel.text = model.source;
    self.timeLabel.text = model.pubDate;
    
}

#pragma mark ---------get----------

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.clipsToBounds = YES;
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iconImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = zn_font(11);
        _nameLabel.textColor = Main_Color();
    }
    return _nameLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.font = zn_font(11);
        _timeLabel.textColor = Main_Color();
    }
    return _timeLabel;
}

- (UIButton *)attentionBtn{
    if (!_attentionBtn) {
        _attentionBtn = [UIButton new];
        _attentionBtn.layer.cornerRadius = 5;
        [_attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
        _attentionBtn.titleLabel.font = zn_font(10);
        [_attentionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _attentionBtn.backgroundColor = zn_colorString(@"#F97856");
        _attentionBtn.hidden = YES;
    }
    return _attentionBtn;
}

- (UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton new];
        [_shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    }
    return _shareBtn;
}

- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.configuration];
        _webView.scrollView.scrollEnabled = NO;
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        
    }
    return _webView;
}

- (WKWebViewConfiguration *)configuration{
    if (!_configuration) {
        _configuration = [[WKWebViewConfiguration alloc] init];
        _configuration.allowsInlineMediaPlayback = YES;
    }
    return _configuration;
}

@end

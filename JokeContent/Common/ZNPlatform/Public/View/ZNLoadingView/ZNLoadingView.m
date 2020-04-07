//
//  ZNLoadingView.m
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2019/11/6.
//  Copyright © 2019 ttyx. All rights reserved.
//

#import "ZNLoadingView.h"

@interface ZNLoadingView(){
    dispatch_source_t _timer;
    dispatch_queue_t _queue;
}

//背景阴影
@property (nonatomic , strong) UIView * shadowBackground;

@property (nonatomic , strong) UILabel * textLabel;

@property (nonatomic , strong) UILabel * subTextLabel;

@property (nonatomic , strong) UIImageView * imageView;

@property (nonatomic , assign) int index;

@property (nonatomic , assign) BOOL isStart;

@end

@implementation ZNLoadingView

+ (instancetype)sharedSingleton {
    static ZNLoadingView *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //不能再使用alloc方法
        //因为已经重写了allocWithZone方法，所以这里要调用父类的分配空间的方法
        _sharedSingleton = [[super allocWithZone:NULL] init];
    });
    return _sharedSingleton;
}

// 防止外部调用alloc 或者 new
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [[self class] sharedSingleton];
}

// 防止外部调用copy
- (id)copyWithZone:(nullable NSZone *)zone {
    return [[self class] sharedSingleton];
}

// 防止外部调用mutableCopy
- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [[self class] sharedSingleton];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(0, znStateHeight, screenWidth, screenHeight)]) {
        [self setInitUI];
        [self setBangding];
    }
    return self;
}

- (void)setInitUI{
//    [self addSubview:self.shadowBackground];
    [self addSubview:self.imageView];
//    [self addSubview:self.textLabel];
//    [self addSubview:self.subTextLabel];
    
//    self.shadowBackground.sd_layout
//    .topEqualToView(self)
//    .leftEqualToView(self)
//    .rightEqualToView(self)
//    .bottomEqualToView(self);
    
    self.imageView.sd_layout
    .centerYEqualToView(self).offset(-zn_stateHeight() - zn_AutoWidth(44))
    .centerXEqualToView(self)
    .widthIs(zn_AutoWidth(30))
    .heightEqualToWidth();
    
//    self.textLabel.sd_layout
//    .topSpaceToView(self.imageView, zn_AutoWidth(20))
//    .centerXEqualToView(self.imageView)
//    .widthIs(zn_AutoWidth(200))
//    .autoHeightRatio(0);
//
//    self.subTextLabel.sd_layout
//    .topSpaceToView(self.textLabel, zn_AutoWidth(7.5))
//    .centerXEqualToView(self.textLabel)
//    .widthIs(zn_AutoWidth(200))
//    .autoHeightRatio(0);
}

/// 在该视图的中心加载
/// @param view <#view description#>
- (void)loadingOnViewCenter:(UIView*) view offset:(CGFloat) offset{
    CGRect rect = [view zn_screenRect];
    self.imageView.sd_resetLayout
    .topSpaceToView(self, rect.size.height/2 - zn_AutoWidth(15) - offset)
    .leftSpaceToView(self, rect.origin.x + rect.size.width/2 - zn_AutoWidth(15))
    .widthIs(zn_AutoWidth(30))
    .heightEqualToWidth();
}

- (void)onScreenCenter{
    self.imageView.sd_resetLayout
    .centerYEqualToView(self).offset(-zn_stateHeight() - zn_AutoWidth(44))
    .centerXEqualToView(self)
    .widthIs(zn_AutoWidth(30))
    .heightEqualToWidth();
}

- (void)setBangding{
    self.index = 0;
    self.time = 0.5;
    _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

//动画开始
- (void)startAnimation{
    znWeakSelf(self)
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), self.time*NSEC_PER_SEC, 0);     //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        znStrongSelf
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.imageView.image = zn_imageName(weakSelf.images[weakSelf.index]);
                weakSelf.index = (weakSelf.index + 1)%weakSelf.images.count;
            });
    });
    dispatch_resume(_timer);
}

//动画停止
- (void)stopAnimation{
    if (_timer) {
        dispatch_source_cancel(_timer);
    }
}

#pragma mark - get

- (UIView *)shadowBackground{
    if (!_shadowBackground) {
        _shadowBackground = [UIView new];
//        _shadowBackground.backgroundColor = zn_colorString(@"#f2f2f2");
//        _shadowBackground.alpha = 0.95;
    }
    return _shadowBackground;
}

- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = UILabel.zn_create
        .zn_font(zn_font(15))
        .zn_textColor(zn_colorString(@"#666666"))
        .zn_text(@"努力狂奔中~~~")
        .zn_alignment(NSTextAlignmentCenter);
    }
    return _textLabel;
}

- (UILabel *)subTextLabel{
    if (!_subTextLabel) {
        _subTextLabel = UILabel.zn_create
        .zn_font(zn_font(15))
        .zn_textColor(zn_colorString(@"#666666"))
        .zn_text(@"请稍等一下下哦")
        .zn_alignment(NSTextAlignmentCenter);
    }
    return _subTextLabel;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}

@end

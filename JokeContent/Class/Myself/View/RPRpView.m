//
//  RPRpView.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPRpView.h"
@interface RPRpView()

@property (nonatomic , strong) UIImageView * rpImageView;

@property (nonatomic , strong) UIView *backgroundView;

@end

@implementation RPRpView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: CGRectMake(0, 0, screenWidth, screenHeight)]) {
        [self setupInitUI];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)setupInitUI{
    [self addSubview:self.backgroundView];
    [self addSubview:self.rpImageView];
    
    self.rpImageView.sd_layout
    .centerXEqualToView(self)
    .centerYEqualToView(self)
    .widthIs(zn_AutoWidth(300))
    .heightEqualToWidth();
    
    UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recognizerAction)];
    recognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:recognizer];
}

- (void)recognizerAction{
    znWeakSelf(self)
    [UIView animateWithDuration:0.5 animations:^{
        znStrongSelf
        weakSelf.size = CGSizeMake(50, 50);
        weakSelf.alpha = 0.1;
    }];
    [self removeFromSuperview];
}

- (void)show:(UIView*) view{
    [view addSubview:self];
    self.alpha = 0.1;
    znWeakSelf(self)
    [UIView animateWithDuration:0.5 animations:^{
        znStrongSelf
        weakSelf.size = CGSizeMake(screenWidth, screenHeight);
        weakSelf.alpha = 1;
    }];
}

#pragma mark - set

- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    [self.rpImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
}

- (void)setRpImage:(UIImage *)rpImage{
    _rpImage = rpImage;
    self.rpImageView.image = rpImage;
}

#pragma mark ----------get----------

- (UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.6;
    }
    return _backgroundView;
}

- (UIImageView *)rpImageView{
    if (!_rpImageView) {
        _rpImageView = [UIImageView new];
        _rpImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _rpImageView;
}

@end

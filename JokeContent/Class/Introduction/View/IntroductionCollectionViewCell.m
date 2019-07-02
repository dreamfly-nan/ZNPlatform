//
//  IntroductionCollectionViewCell.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/5/2.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "IntroductionCollectionViewCell.h"

@interface IntroductionCollectionViewCell()

@property (nonatomic , strong) UIImageView * introdutionImageView;

@end

@implementation IntroductionCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    [self.contentView addSubview:self.introdutionImageView];
    [self.contentView addSubview:self.functionBtn];
    self.introdutionImageView.sd_layout
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView);
    
    self.functionBtn.sd_layout
    .bottomSpaceToView(self.contentView, zn_AutoHeight(40))
    .centerXEqualToView(self.contentView)
    .widthIs(zn_AutoWidth(100))
    .heightIs(zn_AutoWidth(40));
    
    self.functionBtn.hidden = YES;
}

- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    NSString * path = [[NSBundle mainBundle] pathForResource:@"imageUrl" ofType:@".png"];
    self.introdutionImageView.image = [UIImage imageWithContentsOfFile:path];
}

#pragma mark - get

- (UIButton *)functionBtn{
    if (!_functionBtn) {
        _functionBtn = [UIButton new];
        _functionBtn.layer.borderColor = Line_Color().CGColor;
        _functionBtn.layer.cornerRadius = 5;
        [_functionBtn setTitle:@"进 入" forState:UIControlStateNormal];
    }
    return _functionBtn;
}

- (UIImageView *)introdutionImageView{
    if (!_introdutionImageView) {
        _introdutionImageView = [UIImageView new];
        _introdutionImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _introdutionImageView;
}

@end

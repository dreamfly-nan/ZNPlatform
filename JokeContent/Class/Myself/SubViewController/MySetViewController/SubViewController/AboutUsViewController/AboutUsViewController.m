//
//  AboutUsViewController.m
//  JokeContent
//
//  Created by 社会人 on 2019/5/17.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

//标题
@property(nonatomic,strong) UILabel * titleLabel;

//内容
@property(nonatomic,strong) UILabel * contentLabel;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setInitUI];
}

- (void)setInitUI{
    self.title = @"关于我们";
    [self.view addSubview:self.contentLabel];
    self.contentLabel.sd_layout
    .topSpaceToView(self.view, zn_AutoWidth(30) + [RPConfig sharedInstance].navigationHeight + znStateHeight)
    .leftSpaceToView(self.view, zn_AutoWidth(15))
    .rightSpaceToView(self.view, zn_AutoWidth(15))
    .autoHeightRatio(0);
}

#pragma mark - get

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = Title_Color();
        _titleLabel.font = zn_Bold_font(16);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = Content_Color();
        _contentLabel.font = zn_font(15);
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.text = @" 我们致力于福州新闻本土化，推送更加精准的新闻消息。\n\n  但不局限于福州本地新闻，同时包含世界各地的新闻，您可根据自己的喜好进行关注，选择自己喜欢的新闻类型，进而在这个信息爆炸的时代获取想要的新闻资讯。\n\n  希望您能喜欢我们的产品，也真诚的希望收到您的一些问题反馈，或者建议，我们将认真改进尽力满足您的需求。";
    }
    return _contentLabel;
}

@end

//
//  ZNSearchHistoryItemCell.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/18.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNSearchHistoryItemCell.h"

@interface ZNSearchHistoryItemCell()

@property(nonatomic,strong) UILabel * contentLabel;

@end

@implementation ZNSearchHistoryItemCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setInitUI];
    }
    return self;
}

- (void)setInitUI{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.contentLabel];
    
    self.contentLabel.sd_layout
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .leftSpaceToView(self.contentView,0)
    .rightSpaceToView(self.contentView,0);
    
    [self.contentLabel setSd_cornerRadius:@5];
}

#pragma mark - set

- (void)setText:(NSString *)text{
    _text = text;
    self.contentLabel.text = text;
}

#pragma mark - get

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.zn_font(zn_font(12))
        .zn_textColor(TITLE_COLOR)
        .zn_alignment(NSTextAlignmentCenter);
    }
    return _contentLabel;
}

@end

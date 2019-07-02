//
//  SearchCollectionViewCell.m
//  准到-ipad
//
//  Created by zhundao on 2017/9/8.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "SearchCollectionViewCell.h"

@implementation SearchCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.wordLabel];
    }
    return self;
}

- (UILabel *)wordLabel{
    if (!_wordLabel) {
        _wordLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _wordLabel.backgroundColor = [UIColor colorWithWhite:0.90 alpha:1];
        _wordLabel.font = zn_font(12);
        _wordLabel.layer.cornerRadius = zn_AutoHeight(10);
        _wordLabel.layer.masksToBounds = YES;
        _wordLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _wordLabel;
}

- (void)setSearchStr:(NSString *)searchStr{
    _searchStr = searchStr;
    _wordLabel.text = _searchStr;
    CGSize size = [_searchStr boundingRectWithSize:CGSizeMake(zn_AutoWidth(1000), zn_AutoHeight(20)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :zn_font(14)} context:nil].size;
    
    _wordLabel.frame = CGRectMake(zn_AutoWidth(15),0, size.width + zn_AutoWidth(15), zn_AutoHeight(20));
}

- (CGSize)sizeForCell {
    return CGSizeMake(_wordLabel.frame.size.width + zn_AutoWidth(10), zn_AutoHeight(20));
}

@end

//
//  ZNTitleItem.m
//  TableViewCollectView
//
//  Created by 郑楠楠 on 2018/4/2.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "ZNTitleLabel.h"
#import "UILabel+ZNLabel.h"
#import <objc/runtime.h>

@interface ZNTitleLabel()

@end

@implementation ZNTitleLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpInit];
    }
    return self;
}

- (instancetype)init{
    return  [self initWithFrame:CGRectZero];
}

#pragma mark ----private------

- (void)setUpInit{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *regsture = [[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(tapRecognizer)];
    regsture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:regsture];
}

- (void)tapRecognizer{
    if (!self.model.isSelect) {
        if (self.znDelegate && [self.znDelegate respondsToSelector:@selector(selectAction:)]) {
            [self.znDelegate selectAction:self];
        }
    }
}

#pragma mark ------set------

- (void)setModel:(ZNTitleModel *)model{
    _model = model;
    if(model.subTitle){
        self.text = [NSString stringWithFormat:@"%@%@",model.title,model.subTitle];
    }else{
        self.text = model.title;
    }
    if (self.model.isSelect) {
        if (!self.model.selectColor) {
            self.model.selectColor = [UIColor redColor];
        }
        [UIView animateWithDuration:0.2 animations:^{
            if (self.model.title.length > 0) {
                [self zn_setFontAndColorWithString:model.title
                                           font:[self obtainSelectFont:model.titleFont]
                                          color:model.selectColor];
            }
            
            if (self.model.subTitle.length > 0) {
                [self zn_setFontAndColorWithString:model.subTitle
                                           font:[self obtainSelectFont:model.subTitleFont]
                                          color:model.selectColor];
            }
        }];
        
    }else{
        if (self.model.title.length > 0) {
            [self zn_setFontAndColorWithString:model.title font:model.titleFont color:model.titleColor];
        }
        
        if (self.model.subTitle.length > 0) {
            [self zn_setFontAndColorWithString:model.subTitle font:model.subTitleFont color:model.subTitleColor];
        }
    }
}

- (UIFont*)obtainSelectFont:(UIFont*)font{
    UIFont *selectFont = [UIFont fontWithName:font.fontName size:font.pointSize + self.model.selectFontChanage];
    return selectFont;
}

@end

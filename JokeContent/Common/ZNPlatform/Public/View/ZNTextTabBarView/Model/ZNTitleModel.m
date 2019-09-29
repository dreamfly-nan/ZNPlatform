//
//  ZNTitleModel.m
//  TableViewCollectView
//
//  Created by 郑楠楠 on 2018/4/2.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "ZNTitleModel.h"
#import "NSString+ZNString.h"

@implementation ZNTitleModel

- (instancetype)init{
    if (self = [super init]) {
        self.titleFont = [UIFont systemFontOfSize:13];
        self.titleColor = [UIColor blackColor];
        self.subTitleFont = [UIFont systemFontOfSize:10];
        self.subTitleColor = self.titleColor;
        self.selectColor = [UIColor redColor];
        self.selectFontChanage = 2;
        self.isSelect = NO;
    }
    return self;
}

- (NSString *)titleString{
    return [NSString stringWithFormat:@"%@%@",self.title,self.subTitle];
}

- (CGFloat)widthWithHeight:(CGFloat)height{
    CGFloat titleWidth = [self.title zn_obtainWidthWithHeight:height font:self.titleFont];
    CGFloat subTitleWidth = [self.subTitle zn_obtainWidthWithHeight:height font:self.subTitleFont];
    if (subTitleWidth > 0) {
        _width = titleWidth + subTitleWidth;
    }else{
        _width = titleWidth;
    }
    return _width;
}

+ (instancetype) initWithTitle:(NSString *)title
                      subTitle:(NSString *)subTitle{
    ZNTitleModel *model = [ZNTitleModel new];
    model.title = title;
    model.subTitle = subTitle;
    return model;
}

@end

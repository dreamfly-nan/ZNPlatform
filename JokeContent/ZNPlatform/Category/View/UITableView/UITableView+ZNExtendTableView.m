//
//  UITableView+ExtendTableView.m
//  TableViewCollectView
//
//  Created by 郑楠楠 on 2018/3/29.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "UITableView+ZNExtendTableView.h"
#import <objc/runtime.h>

#define isFristLoadData @"isFristLoadData"

#define lastSeparatorStyle @"separatorStyle"

@interface UITableView()

@end

@implementation UITableView (ZNExtendTableView)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //交换reload方法
        Method originalMethod = class_getInstanceMethod([self class], @selector(reloadData));
        Method newMethod = class_getInstanceMethod([self class], @selector(zn_reloadData));
        method_exchangeImplementations(originalMethod, newMethod);
    });
}

- (void)zn_reloadData{
    [self zn_reloadData];
    
    if (![self fristLoadData]) {
        [self setZn_SeparatorStyle:self.separatorStyle];
        [self setFristLoadData:YES];
        //如果是第一次，则不进行执行下面的代码，将系统的s首次加载忽略
        return;
    }

    //忽略第一次加载，即首次系统加载调用
    znWeakSelf(self)
    dispatch_async(dispatch_get_main_queue(), ^{
        znStrongSelf
        BOOL isHaveData = NO;
        NSInteger sections = [weakSelf numberOfSections];
        for (int i = 0 ; i < sections; i++) {
            if ([weakSelf numberOfRowsInSection:i] > 0) {
                isHaveData = YES;
                break;
            }
        }
        [weakSelf setHaveData:isHaveData];
    });
}

- (BOOL)fristLoadData{
    id isFrisht = objc_getAssociatedObject(self, isFristLoadData);
    BOOL frist = isFrisht == nil ? NO : [objc_getAssociatedObject(self, isFristLoadData) boolValue];
    return frist;
}

- (void)setFristLoadData:(BOOL)frist{
    objc_setAssociatedObject(self, isFristLoadData, @(frist), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setZn_SeparatorStyle:(UITableViewCellSeparatorStyle)style{
    objc_setAssociatedObject(self, lastSeparatorStyle, @(style), OBJC_ASSOCIATION_ASSIGN);
}

- (UITableViewCellSeparatorStyle) getZn_SeparatorStyle{
   UITableViewCellSeparatorStyle style = [objc_getAssociatedObject(self, lastSeparatorStyle) integerValue];
    return style;
}

/**
 根据是否存在数据进行设置背景视图
 @param isHaveData <#isHaveData description#>
 */
- (void)setHaveData:(BOOL)isHaveData{
    if (!isHaveData) {
        [self setZn_SeparatorStyle:self.separatorStyle];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (self.backgroundView == nil) {
            if ([self.delegate respondsToSelector:@selector(getNoDataView)]) {
                UIView * nodataView = [self.delegate performSelector:@selector(getNoDataView)];
                self.backgroundView = nodataView;
            }
        }
    }else{
        self.separatorStyle = [self getZn_SeparatorStyle];
    }
    [self.backgroundView setHidden:isHaveData];
}

@end

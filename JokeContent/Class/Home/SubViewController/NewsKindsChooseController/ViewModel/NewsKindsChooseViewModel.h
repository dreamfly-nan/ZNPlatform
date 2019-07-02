//
//  NewsKindsChooseViewModel.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/19.
//  Copyright © 2019 社会人. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsKindsChooseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsKindsChooseViewModel : NSObject

@property (nonatomic , weak) NewsKindsChooseController * controller;

/**
 确定按键
 */
@property (nonatomic , strong) UIButton * sureBtn;

/**
 选中的类别
 */
@property (nonatomic , strong) NSMutableArray * chooseKinds;

/**
 移除的类别
 */
@property (nonatomic , strong) NSMutableArray * removeKinds;

- (void)setInitUI;

- (void)setInitBtn;

/**
 将用户选中项提取出来
 */
- (void)setChooseItem;

@end

NS_ASSUME_NONNULL_END

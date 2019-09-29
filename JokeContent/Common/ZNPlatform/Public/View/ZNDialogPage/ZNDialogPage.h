//
//  ZNDialogPage.h
//  MeetAll
//
//  Created by 郑楠楠 on 2018/4/26.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "ZNTabView.h"
@interface ZNDialogPage : UIView

@property (nonatomic , strong, readwrite) NSArray<UIView *> *views;

@property (nonatomic , strong, readwrite) UIPageControl * pageControl;

@property (nonatomic , strong, readwrite) ZNTabView *contentView;

@property (nonatomic , copy, readwrite) void (^closeBlock)(void);

@property (nonatomic , assign, readonly) CGSize contentSize;

+ (instancetype)createDialogPageWithSize:(CGSize)size views:(NSArray<UIView *>*)views;

//展示
+ (void)createDialogPageOnWindWithSize:(CGSize)size views:(NSArray<UIView *>*)views;

- (void)setContentSize:(CGSize)contentSize;

@end

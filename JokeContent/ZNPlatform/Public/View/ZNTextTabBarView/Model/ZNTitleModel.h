//
//  ZNTitleModel.h
//  TableViewCollectView
//
//  Created by 郑楠楠 on 2018/4/2.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZNTitleModel : NSObject

//这个字段只有在调用widthWithHeight:函数后进行缓存标题的宽度
@property (nonatomic , assign ,readonly) CGFloat width;

//父标题
@property (nonatomic , strong) NSString *title;

//子标题
@property (nonatomic , strong) NSString *subTitle;

/**
 标题颜色
 */
@property (nonatomic , strong) UIColor *titleColor;

/**
 子标题颜色
 */
@property (nonatomic, strong) UIColor *subTitleColor;

/**
 父标题字体
 */
@property (nonatomic , strong) UIFont *titleFont;

/**
 子标题的字体
 */
@property (nonatomic , strong) UIFont *subTitleFont;

@property (nonatomic , strong) UIColor *selectColor;

//选中时，字体大小的改变
@property (nonatomic , assign) CGFloat selectFontChanage;

/**
 是否被选中
 */
@property (nonatomic , assign) BOOL isSelect;

/**
 总标题

 @return <#return value description#>
 */
- (NSString *)titleString;

/**
 根据给定的高度和自身内容进行计算宽度值

 @param height <#height description#>
 @return <#return value description#>
 */
- (CGFloat)widthWithHeight:(CGFloat)height;

+ (instancetype) initWithTitle:(NSString *)title
                      subTitle:(NSString *)subTitle;

@end

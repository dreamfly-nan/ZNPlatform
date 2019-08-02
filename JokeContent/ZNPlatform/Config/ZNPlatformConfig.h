//
//  ZNPlatformConfig.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/25.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZNPlatformConfig : NSObject

/************************************************   颜色配置   **********************************************/

/**
 主色调
 */
@property(nonatomic,strong) UIColor * mainColor;

/**
 背景颜色
 */
@property(nonatomic,strong) UIColor * backgroundColor;

/**
 线条颜色
 */
@property(nonatomic,strong) UIColor * lineColor;

/**
 标题颜色
 */
@property(nonatomic,strong) UIColor * titleColor;

/**
 文本内容颜色
 */
@property(nonatomic,strong) UIColor * contentColor;

/**
 占位符颜色
 */
@property(nonatomic,strong) UIColor * placeColor;

/**
 日期颜色
 */
@property(nonatomic,strong) UIColor * dateColor;

/**
 简介颜色
 */
@property(nonatomic,strong) UIColor * introductionColor;

/************************************************   字体配置   **********************************************/

/**
标题字体
 */
@property(nonatomic,strong) UIFont * titleFont;

/**
 内容字体
 */
@property(nonatomic,strong) UIFont * contentFont;

/**
 导航栏字体
 */
@property(nonatomic,strong) UIFont * navigationFont;

/************************************************   常用高度配置   **********************************************/

/**
 导航栏高度
 */
@property(nonatomic,assign) CGFloat navigationHeight;

/**
 选项卡高度
 */
@property(nonatomic,assign) CGFloat tabBarHeight;

/**
 获取单例

 @return <#return value description#>
 */
+ (instancetype)sharedSingleton;

@end

NS_ASSUME_NONNULL_END

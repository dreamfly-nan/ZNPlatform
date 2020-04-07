//
//  NSString+ZNDate.h
//  JokeContent
//
//  Created by ttyx-2 on 2020/4/7.
//  Copyright © 2020 南木南木. All rights reserved.
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZNDate)

#pragma mark -年月日

/**
 *  x年x月x日
 */
@property(nonatomic,copy,readonly)NSString *zn_formatNianYueRi;

/**
 *  x年x月
 */
@property(nonatomic,copy,readonly)NSString *zn_formatNianYue;

/**
 *  x月x日
 */
@property(nonatomic,copy,readonly)NSString *zn_formatYueRi;

/**
 *  x年
 */
@property(nonatomic,copy,readonly)NSString *zn_formatNian;

/**
 *  x时x分x秒
 */
@property(nonatomic,copy,readonly)NSString *zn_formatShiFenMiao;

/**
 *  x时x分
 */
@property(nonatomic,copy,readonly)NSString *zn_formatShiFen;

/**
 *  x分x秒
 */
@property(nonatomic,copy,readonly)NSString *zn_formatFenMiao;

/**
 *  yyyy-MM-dd
 */
@property(nonatomic,copy,readonly)NSString *zn_format_yyyy_MM_dd;

/**
 *  yyyy-MM
 */
@property(nonatomic,copy,readonly)NSString *zn_format_yyyy_MM;

/**
 *  MM-dd
 */
@property(nonatomic,copy,readonly)NSString *zn_format_MM_dd;

/**
 *  yyyy
 */
@property(nonatomic,copy,readonly)NSString *zn_format_yyyy;

/**
 *  HH:mm:ss
 */
@property(nonatomic,copy,readonly)NSString *zn_format_HH_mm_ss;

/**
 *  HH:mm
 */
@property(nonatomic,copy,readonly)NSString *zn_format_HH_mm;

/**
 *  mm:ss
 */
@property(nonatomic,copy,readonly)NSString *zn_format_mm_ss;

/**
* yyyy-MM-dd HH: mm
*/
@property (nonatomic , copy,readonly) NSString * zn_format_y_M_d_H_m;


/**
    转换为星期几
*/
@property(nonatomic,copy,readonly)NSString *zn_formatWeekDay;

/// 格式化描述输出 - 今天，明天，后天，大于后天或者是过去的时间，都输出nil
@property(nonatomic,copy,readonly)NSString *zn_formatDescribeDay;

@end

NS_ASSUME_NONNULL_END

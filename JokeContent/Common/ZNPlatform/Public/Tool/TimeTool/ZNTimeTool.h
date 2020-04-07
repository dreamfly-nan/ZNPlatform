//
//  ZNTimeTool.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/5/14.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZNTimeTool : NSObject

/**
 获取当前时间

 @return <#return value description#>
 */
+(NSString*)getCurrentTimes;

/**
  获取当前时间

 @param formatterStr 返回的时间格式
 @return <#return value description#>
 */
+(NSString*)getCurrentTimesWithFormatter:(NSString*) formatterStr;

/**
 将时间字符串转化为 YYYY-MM-DD HH:mm:ss 对应的时间字符串
 @param formatterStr <#formatterStr description#>
 @param dateStr <#dateStr description#>
 @param getForMatter 想要获取的时间格式
 @return <#return value description#>
 */
+(NSString *)getTimeStringWithFormatter:(NSString*) formatterStr
                                dateStr:(NSString *) dateStr
                           getForMatter:(NSString*) getForMatter;

/**
 根据formatterStr时间格式来返回年月日时间格式

 @param formatterStr <#formatterStr description#>
 @param dateStr <#dateStr description#>
 @return <#return value description#>
 */
+ (NSString *)getDateStrWithFormatter:(NSString*) formatterStr
                              dateStr:(NSString *) dateStr;

/// 根据时间搓转化出时间字符串
/// @param timeLong <#timeLong description#>
/// @param formatterStr 时间格式
+ (NSString *)getTimeStringWithLong:(long) timeLong
                       formatterStr:(NSString *) formatterStr;

/// 将时间字符串转为时间戳
/// @param timeString <#timeString description#>
/// @param formatterStr <#formatterStr description#>
+ (long)getTimeLongWithString:(NSString *) timeString
                       formatterStr:(NSString *) formatterStr;

/// 与当前时间相比差几天
/// @param formatterStr <#formatterStr description#>
/// @param dataStr <#dataStr description#>
+(int)getDayTimeIntervalWithNow:(NSString *) formatterStr
                           data:(NSString*) dataStr;

///与当前时间比较差几天
+(CGFloat)getDayIntercalWithNow:(NSString *)endTimeStr data:(NSString *)datastr;

///获取北京时间
+ (NSDate *)getInternetDate;

///与服务器时间比较差多少天
+(CGFloat)getDayIntercalWithRatherTime:(NSString *) ratherTime WebTime:(NSString *)WebTime;

/// 获取该时间为今天，明天，后天，其他为时间格式
/// @param string <#string description#>
+ (NSString *)checkTheDate:(NSString *)string;

/// 是否小于当前时间
+ (BOOL)outCurrentNowTime:(NSString *) time;

@end

NS_ASSUME_NONNULL_END

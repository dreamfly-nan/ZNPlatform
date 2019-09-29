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
 @return <#return value description#>
 */
+(NSString *)getTimeStringWithFormatter:(NSString*) formatterStr
                                dateStr:(NSString *) dateStr;

/**
 根据formatterStr时间格式来返回年月日时间格式

 @param formatterStr <#formatterStr description#>
 @param dateStr <#dateStr description#>
 @return <#return value description#>
 */
+ (NSString *)getDateStrWithFormatter:(NSString*) formatterStr
                              dateStr:(NSString *) dateStr;

@end

NS_ASSUME_NONNULL_END

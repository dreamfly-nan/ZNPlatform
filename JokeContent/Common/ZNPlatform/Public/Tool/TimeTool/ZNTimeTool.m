//
//  ZNTimeTool.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/5/14.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "ZNTimeTool.h"

@implementation ZNTimeTool

#pragma mark - public

+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}


+(NSString*)getCurrentTimesWithFormatter:(NSString*) formatterStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:formatterStr];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

/**
 将时间字符串转化为对应的时间字符串
 
 @param formatterStr <#formatterStr description#>
 @param dateStr <#dateStr description#>
 @return <#return value description#>
 */
+(NSString *)getTimeStringWithFormatter:(NSString*) formatterStr
                                dateStr:(NSString *) dateStr
                           getForMatter:(NSString*) getForMatter{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:formatterStr];
    NSDate *date = [formatter dateFromString:dateStr];
    [formatter setDateFormat:getForMatter];
    NSString *currentTimeString = [formatter stringFromDate:date];
    return currentTimeString;
}

/**
  根据formatterStr时间格式来返回年月日时间格式
 
 @param formatterStr <#formatterStr description#>
 @param dateStr <#dateStr description#>
 @return <#return value description#>
 */
+ (NSString *)getDateStrWithFormatter:(NSString*) formatterStr
                              dateStr:(NSString *) dateStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:formatterStr];
    NSDate *date = [formatter dateFromString:dateStr];
    [formatter setDateFormat:formatterStr];
    NSString *currentTimeString = [formatter stringFromDate:date];
    return currentTimeString;
}

/// 根据时间搓转化出时间字符串
/// @param timeLong <#timeLong description#>
/// @param formatterStr 时间格式
+ (NSString *)getTimeStringWithLong:(long) timeLong
                       formatterStr:(NSString *) formatterStr{
    //将对象类型的时间转换为NSDate类型
//    if (znLongToStr(timeLong).length == 13) {
//        timeLong = timeLong/1000;
//    }
    NSDate * myDate = [NSDate dateWithTimeIntervalSince1970:timeLong];
    //设置时间格式
    NSDateFormatter * formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatterStr];
    //将时间转换为字符串
    NSString *timeStr = [formatter stringFromDate:myDate];
    return timeStr;
}

/// 将时间字符串转为时间戳  @"yyyy-MM-dd HH:mm:ss"
/// @param timeString <#timeString description#>
/// @param formatterStr <#formatterStr description#>
+ (long)getTimeLongWithString:(NSString *) timeString
                       formatterStr:(NSString *) formatterStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatterStr];
    NSDate *datestr = [dateFormatter dateFromString:timeString];
    // 时间转时间戳的方法:
    return [datestr timeIntervalSince1970];
}

/// 与当前时间相比差几天
/// @param formatterStr <#formatterStr description#>
/// @param dataStr <#dataStr description#>
+(int)getDayTimeIntervalWithNow:(NSString *) formatterStr
                           data:(NSString*) dataStr{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    //当前的时间
    NSDateFormatter *nowDateFormatter = [[NSDateFormatter alloc] init];
    [nowDateFormatter setDateFormat:formatterStr];
    NSDate * nowDate= [nowDateFormatter dateFromString:currentTimeString];
    
    //比较的时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatterStr];
    NSDate *datestr = [dateFormatter dateFromString:dataStr];
    
    //时间差
    int interval = [nowDate timeIntervalSinceDate:datestr];
    return interval/60*60*24;
}

///与当前时间比较差几天
+(CGFloat)getDayIntercalWithNow:(NSString *)endTimeStr data:(NSString *)datastr{
    //现在时间,你可以输出来看下是什么格式
    NSDate *datenow = [NSDate date];
    NSTimeInterval a = [datenow timeIntervalSince1970];
    NSDate * endDate = [NSDate zn_dateWithDateString:endTimeStr];
    NSTimeInterval b = [endDate timeIntervalSince1970];
    CGFloat time = (b -a)/60/60/24;
    return time;
}

///与服务器时间比较差多少天
+(CGFloat)getDayIntercalWithRatherTime:(NSString *) ratherTime WebTime:(NSString *)WebTime{
    //现在时间,你可以输出来看下是什么格式
    //获取北京时间
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"yyyy-MM-dd"];
        
    NSDate *datenow = [formatter dateFromString:ratherTime];

    
    NSTimeInterval a = [datenow timeIntervalSince1970];
    
//    NSDate * dateEnd = [NSDate dateWithTimeIntervalSince1970:[endTimeStr longLongValue]/1000];
    
    NSString * str = [ZNTimeTool getTimeStringWithLong:[WebTime longLongValue]/1000 formatterStr:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString * dateEnd = [str substringToIndex:10];
    
    NSDate *endTime = [formatter dateFromString:dateEnd];


    NSTimeInterval b = [endTime timeIntervalSince1970];
    CGFloat time = (a - b)/60/60/24;
    return time;
}

///获取北京时间
+ (NSDate *)getInternetDate
{
    NSString *urlString = @"http://m.baidu.com";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval: 2];
    [request setHTTPShouldHandleCookies:FALSE];
    [request setHTTPMethod:@"GET"];
    NSHTTPURLResponse *response;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    NSString *date = [[response allHeaderFields] objectForKey:@"Date"];
    date = [date substringFromIndex:5];
    date = [date substringToIndex:[date length]-4];
    NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
    dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
    
    NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: netDate];
    NSDate *localeDate = [netDate  dateByAddingTimeInterval: interval];
    return localeDate;
}

/// 获取该时间为今天，明天，后天，其他为时间格式
/// @param string <#string description#>
+ (NSString *)checkTheDate:(NSString *)string{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [format dateFromString:string];
    BOOL isToday = [[NSCalendar currentCalendar] isDateInToday:date];
    NSString *strDiff = nil;
    if(isToday) {
        strDiff= [NSString stringWithFormat:@"今天"];
    }else{
        if ([[NSCalendar currentCalendar] isDateInTomorrow:date]) {
            strDiff= [NSString stringWithFormat:@"明天"];
        }else{
           CGFloat day = [ZNTimeTool getDayIntercalWithNow:string data:@"yyyy-MM-dd"];
            if(day > 1 && day < 2) {
                strDiff = @"后天";
            }else{
                strDiff = string;
            }
        }
    }
    return strDiff;
}

/// 是否小于当前时间
+ (BOOL)outCurrentNowTime:(NSString *) time{
    NSDate *datenow = [NSDate date];
    NSDate * timeDate = [NSDate zn_dateWithDateString:time];
    return [datenow timeIntervalSince1970] > [timeDate timeIntervalSince1970];
}

@end

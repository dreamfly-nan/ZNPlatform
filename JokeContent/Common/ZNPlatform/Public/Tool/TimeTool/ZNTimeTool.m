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
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
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
                                dateStr:(NSString *) dateStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:formatterStr];
    NSDate *date = [formatter dateFromString:dateStr];
    [formatter setDateFormat:@"YYYY-MM-DD HH:mm:ss"];
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
    [formatter setDateFormat:@"YYYY-MM-DD"];
    NSString *currentTimeString = [formatter stringFromDate:date];
    return currentTimeString;
}

@end

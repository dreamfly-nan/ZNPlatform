//
//  NSString+ZNDate.m
//  JokeContent
//
//  Created by ttyx-2 on 2020/4/7.
//  Copyright © 2020 南木南木. All rights reserved.
//

#import "NSString+ZNDate.h"

@implementation NSString (ZNDate)

- (NSInteger)year{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return date.year;
}

- (NSInteger)month{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return date.month;
}

- (NSInteger)day{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return date.day;
}

- (NSInteger)hour{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return date.hour;
}

- (NSInteger)minute{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return date.minute;
}

- (NSInteger)seconds{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return date.seconds;
}

- (NSInteger)weekday{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return date.weekday;
}

-(NSString *)zn_formatNianYueRi
{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld年%02ld月%02ld日",date.year,date.month,date.day];
}
-(NSString *)zn_formatNianYue
{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld年%02ld月",date.year,date.month];
}
-(NSString *)zn_formatYueRi
{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return [NSString stringWithFormat:@"%02ld月%02ld日",date.month,date.day];
}
-(NSString *)zn_formatNian
{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld年",date.year];
}
-(NSString *)zn_formatShiFenMiao
{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld时%02ld分%02ld秒",date.hour,date.minute,date.seconds];
}
-(NSString *)zn_formatShiFen
{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld时%02ld分",date.hour,date.minute];
}
-(NSString *)zn_formatFenMiao
{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return [NSString stringWithFormat:@"%02ld分%02ld秒",date.minute,date.seconds];
}
-(NSString *)zn_format_yyyy_MM_dd
{
   NSDate *date = [NSDate zn_dateWithDateString:self];
   return [NSString stringWithFormat:@"%ld-%02ld-%02ld",date.year,date.month,date.day];
}
-(NSString *)zn_format_yyyy_MM
{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld-%02ld",date.year,date.month];
}
-(NSString *)zn_format_MM_dd
{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return [NSString stringWithFormat:@"%02ld-%02ld",date.month,date.day];
}
-(NSString *)zn_format_yyyy
{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld",date.year];
}
-(NSString *)zn_format_HH_mm_ss
{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",date.hour,date.minute,date.seconds];
}
-(NSString *)zn_format_HH_mm
{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return [NSString stringWithFormat:@"%02ld:%02ld",date.hour,date.minute];
}
-(NSString *)zn_format_mm_ss
{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return [NSString stringWithFormat:@"%02ld:%02ld",date.minute,date.seconds];
}

-(NSString *)zn_format_y_M_d_H_m
{
    NSDate *date = [NSDate zn_dateWithDateString:self];
    return [NSString stringWithFormat:@"%ld-%02ld-%02ld %ld:%02ld",date.year,date.month,date.day,date.hour,date.minute];
}

-(NSString *)zn_formatWeekDay
{
    NSString *weekStr=nil;
    NSDate *date = [NSDate zn_dateWithDateString:self];
    switch (date.weekday) {
        case 2:
            weekStr = @"星期一";
            break;
        case 3:
            weekStr = @"星期二";
            break;
        case 4:
            weekStr = @"星期三";
            break;
        case 5:
            weekStr = @"星期四";
            break;
        case 6:
            weekStr = @"星期五";
            break;
        case 7:
            weekStr = @"星期六";
            break;
        case 1:
            weekStr = @"星期天";
            break;
        default:
            break;
    }
    return weekStr;
}

- (NSString *)zn_formatDescribeDay{
    NSDate *datenow = [NSDate date];
    NSTimeInterval a = [datenow timeIntervalSince1970];
    NSDate * endDate = [NSDate zn_dateWithDateString:self];
    NSTimeInterval b = [endDate timeIntervalSince1970];
    CGFloat day = (b -a)/60/60/24;
    
    NSDate * timeDate = [NSDate zn_dateWithDateString:self];
    
    BOOL isToday = [[NSCalendar currentCalendar] isDateInToday:timeDate];
    
    if (isToday) {
        return @"今天";
    }else{
        if ([[NSCalendar currentCalendar] isDateInTomorrow:timeDate]) {
            return @"明天";
        }else{
            if(day > 1 && day < 2) {
                return @"后天";
            }
        }
    }
    return nil;
}

@end

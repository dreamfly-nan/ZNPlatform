//
//  NSDate+ZNDate.m
//  JokeContent
//
//  Created by ttyx-2 on 2020/4/7.
//  Copyright © 2020 南木南木. All rights reserved.
//

#import "NSDate+ZNDate.h"

@implementation NSDate (ZNDate)

-(NSInteger)year
{
    NSDateComponents *components = [NSDateComponents zn_dateComponentsFromDate:self];
    return components.year;
}
- (NSInteger) month
{
    NSDateComponents *components =  [NSDateComponents zn_dateComponentsFromDate:self];
    return components.month;
}

- (NSInteger) day
{
    NSDateComponents *components =  [NSDateComponents zn_dateComponentsFromDate:self];
    return components.day;
}

- (NSInteger) hour
{
    NSDateComponents *components =  [NSDateComponents zn_dateComponentsFromDate:self];
    return components.hour;
}

- (NSInteger) minute
{
    NSDateComponents *components = [NSDateComponents zn_dateComponentsFromDate:self];
    return components.minute;
}

- (NSInteger) seconds
{
    NSDateComponents *components =  [NSDateComponents zn_dateComponentsFromDate:self];
    return components.second;
}

- (NSInteger) weekday
{
    NSDateComponents *components =  [NSDateComponents zn_dateComponentsFromDate:self];
    return components.weekday;
}

+(NSDate *)zn_dateWithDateString:(NSString *)dateString
{
    NSDate *date = nil;
    date = [self zn_dateWithFormat_yyyy_MM_dd_HH_mm_ss_string:dateString];
    if(date) return date;
    date = [self zn_dateWithFormat_yyyy_MM_dd_HH_mm_string:dateString];
    if(date) return date;
    date = [self zn_dateWithFormat_yyyy_MM_dd_HH_string:dateString];
    if(date) return date;
    date = [self zn_dateWithFormat_yyyy_MM_dd_string:dateString];
    if(date) return date;
    date = [self zn_dateWithFormat_yyyy_MM_string:dateString];
    if(date) return date;
    return nil;
}

+(NSDate *)zn_dateWithFormat_yyyy_MM_dd_HH_mm_ss_string:(NSString *)string
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date =[dateFormat dateFromString:string];
    return date;
}

+(NSDate *)zn_dateWithFormat_yyyy_MM_dd_HH_mm_string:(NSString *)string
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date =[dateFormat dateFromString:string];
    return date;
}

+(NSDate *)zn_dateWithFormat_yyyy_MM_dd_HH_string:(NSString *)string
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH"];
    NSDate *date =[dateFormat dateFromString:string];
    return date;
}

+(NSDate *)zn_dateWithFormat_yyyy_MM_dd_string:(NSString *)string
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date =[dateFormat dateFromString:string];
    return date;
}

+(NSDate *)zn_dateWithFormat_yyyy_MM_string:(NSString *)string
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM"];
    NSDate *date =[dateFormat dateFromString:string];
    return date;
}

@end

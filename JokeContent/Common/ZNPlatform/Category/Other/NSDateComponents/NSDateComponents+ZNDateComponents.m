
//
//  NSDateComponents+ZNDateComponents.m
//  JokeContent
//
//  Created by ttyx-2 on 2020/4/7.
//  Copyright © 2020 南木南木. All rights reserved.
//

#import "NSDateComponents+ZNDateComponents.h"

@implementation NSDateComponents (ZNDateComponents)

+(NSDateComponents *)zn_dateComponentsFromDate:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal fromDate:date];
    return components;
    
}

@end

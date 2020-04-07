//
//  NSDate+ZNDate.h
//  JokeContent
//
//  Created by ttyx-2 on 2020/4/7.
//  Copyright © 2020 南木南木. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (ZNDate)

@property(nonatomic,assign,readonly)NSInteger year;
@property(nonatomic,assign,readonly)NSInteger month;
@property(nonatomic,assign,readonly)NSInteger day;
@property(nonatomic,assign,readonly)NSInteger hour;
@property(nonatomic,assign,readonly)NSInteger minute;
@property(nonatomic,assign,readonly)NSInteger seconds;
@property (nonatomic,assign,readonly)NSInteger weekday;

+(NSDate *)zn_dateWithDateString:(NSString *)dateString;
+(NSDate *)zn_dateWithFormat_yyyy_MM_dd_HH_mm_ss_string:(NSString *)string;
+(NSDate *)zn_dateWithFormat_yyyy_MM_dd_HH_mm_string:(NSString *)string;
+(NSDate *)zn_dateWithFormat_yyyy_MM_dd_HH_string:(NSString *)string;
+(NSDate *)zn_dateWithFormat_yyyy_MM_dd_string:(NSString *)string;
+(NSDate *)zn_dateWithFormat_yyyy_MM_string:(NSString *)string;

@end

NS_ASSUME_NONNULL_END

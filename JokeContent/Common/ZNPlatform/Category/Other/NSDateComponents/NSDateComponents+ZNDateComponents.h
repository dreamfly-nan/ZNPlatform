//
//  NSDateComponents+ZNDateComponents.h
//  JokeContent
//  时间格式化
//  Created by ttyx-2 on 2020/4/7.
//  Copyright © 2020 南木南木. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateComponents (ZNDateComponents)

+(NSDateComponents *)zn_dateComponentsFromDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END

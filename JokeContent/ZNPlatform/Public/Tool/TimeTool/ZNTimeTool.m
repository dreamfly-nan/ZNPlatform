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

@end

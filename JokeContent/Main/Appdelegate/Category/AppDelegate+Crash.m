//
//  AppDelegate+Crash.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/21.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "AppDelegate+Crash.h"

@implementation AppDelegate (Crash)

- (void)crash_application:(UIApplication*) application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions{
    
    NSArray * array = @[@"NSArray",@"NSDictionary",@"NSNumber",@"NSString",@"NSMutableArray"];
    [AvoidCrash setupNoneSelClassStringsArr: array];
}

@end

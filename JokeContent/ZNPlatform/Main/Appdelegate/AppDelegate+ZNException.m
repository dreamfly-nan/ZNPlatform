//
//  AppDelegate+ZNException.m
//  JokeContent
//
//  Created by 南木南木 on 2019/8/2.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "AppDelegate+ZNException.h"

@implementation AppDelegate (ZNException)

- (void)znCrash_application:(UIApplication*) application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions{
    
    NSArray * array = @[@"NSArray",@"NSDictionary",@"NSNumber",@"NSString",@"NSMutableArray"];
    [AvoidCrash setupNoneSelClassStringsArr: array];
}

@end

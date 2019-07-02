//
//  AppDelegate.m
//  JokeContent
//
//  Created by 社会人 on 2019/4/11.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+UI.h"
#import "AppDelegate+Push.h"
#import "AppDelegate+Bmob.h"
#import "AppDelegate+Net.h"
#import "AppDelegate+Notification.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //延长启动图的时间
    [NSThread sleepForTimeInterval:2];
    [self net_application:application didFinishLaunchingWithOptions:launchOptions];
    [self initUI_application:application didFinishLaunchingWithOptions:launchOptions];
    [self bmob_application:application didFinishLaunchingWithOptions:launchOptions];
    [self notifaction_application:application didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    //程序退出时，清除用户数据
    [RPConfig sharedInstance].userData = nil;
}

@end

//
//  AppDelegate+Bmob.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/17.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "AppDelegate+Bmob.h"

@implementation AppDelegate (Bmob)
    
    - (void)bmob_application:(UIApplication*) application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions{
        [Bmob registerWithAppKey:bmobKey];
    }

@end

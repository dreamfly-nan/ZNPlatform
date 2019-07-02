//
//  AppDelegate+UI.m
//  JokeContent
//
//  Created by 社会人 on 2019/4/11.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "AppDelegate+UI.h"
#import "RPLoginViewController.h"
#import "IntroductionViewController.h"

@implementation AppDelegate (UI)

- (void)initUI_application:(UIApplication*) application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions{
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    RPBaceTabBarController * tabBarController = [RPBaceTabBarController new];
    RPNavigationController * rootController = [[RPNavigationController alloc] initWithRootViewController:tabBarController];
    self.window.rootViewController = rootController;
    [self.window makeKeyWindow];
    [self.window makeKeyAndVisible];
}
    
@end

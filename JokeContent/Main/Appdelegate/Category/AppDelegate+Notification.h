//
//  AppDelegate+Notification.h
//  JokeContent
//
//  Created by 南木南木 on 2019/5/30.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "AppDelegate.h"

#import <UserNotifications/UserNotifications.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Notification) <UNUserNotificationCenterDelegate>

- (void)notifaction_application:(UIApplication*) application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END

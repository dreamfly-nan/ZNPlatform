//
//  RPTimeButton.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/21.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPTimeButton : UIButton

//定时的时间
@property (nonatomic , assign) int timeNumber;

- (void)startTimer;

@end

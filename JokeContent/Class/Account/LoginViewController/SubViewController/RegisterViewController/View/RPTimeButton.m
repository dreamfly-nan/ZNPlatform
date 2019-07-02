//
//  RPTimeButton.m
//  RovingPodcast
//  定时按键
//  Created by 郑楠楠 on 2018/4/21.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPTimeButton.h"
@interface RPTimeButton()

//原本的文字
@property (nonatomic , copy) NSString *strText;

@end

@implementation RPTimeButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)startTimer{
    [self startTimerWithSecond:self.timeNumber];
}

- (void)startTimerWithSecond:(int)seconds{
    if (self.strText == nil) {
        self.strText = self.titleLabel.text;
    }
    self.alpha = 0.6;
    self.enabled = NO;
    
    __block int timeout = seconds;
    znWeakSelf(self)
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);     //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        znStrongSelf
        //倒计时结束
        if (timeout < 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.enabled = YES;
                [weakSelf setTitle:weakSelf.strText forState:UIControlStateNormal];
                weakSelf.alpha = 1;
            });
        }else{
            timeout -= 1;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setTitle:[NSString stringWithFormat:@"%ds",timeout] forState:UIControlStateNormal];
            });
        }
    });
    dispatch_resume(_timer);
}

@end

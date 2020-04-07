//
//  ZNTimeButton.m
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2019/10/29.
//  Copyright © 2019 ttyx. All rights reserved.
//

#import "ZNTimeButton.h"

@interface ZNTimeButton()

//原本的文字
@property (nonatomic , copy) NSString *strText;

//倒计时
@property (nonatomic , assign) long timeout;

@end

@implementation ZNTimeButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

- (void)startTimer{
    if (self.strText == nil) {
        self.strText = self.titleLabel.text;
    }
    [self startTimerWithSecond:self.timeNumber];
}

- (void)stopTimer{
    self.timeNumber = 60;
    if (self.strText) {
        [self setTitle:self.strText forState:UIControlStateNormal];
    }
}

- (void)startTimerWithSecond:(int)seconds{
    self.alpha = 0.6;
    self.enabled = NO;
    znWeakSelf(self)
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);     //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        znStrongSelf
        //倒计时结束
        if (weakSelf.timeout <= 1) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.enabled = YES;
                [weakSelf setTitle:weakSelf.strText forState:UIControlStateNormal];
                weakSelf.alpha = 1;
                if (weakSelf.endBlock) {
                    weakSelf.endBlock();
                }
            });
        }else{
            weakSelf.timeout -= 1;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setTitle:[NSString stringWithFormat:@"%lus后重发",weakSelf.timeout] forState:UIControlStateNormal];
            });
        }
    });
    dispatch_resume(_timer);
}

/// 获取剩余秒数
- (long)obtainSection{
    return self.timeout;
}

- (void)setTimeNumber:(int)timeNumber{
    _timeNumber = timeNumber;
    self.timeout = timeNumber;
}

@end

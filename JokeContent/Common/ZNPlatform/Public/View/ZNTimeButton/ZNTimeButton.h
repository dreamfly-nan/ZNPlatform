//
//  ZNTimeButton.h
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2019/10/29.
//  Copyright © 2019 ttyx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZNTimeButton : UIButton

//定时的时间
@property (nonatomic , assign) int timeNumber;

//倒计时结束
@property (copy , nonatomic) void (^endBlock)(void);

- (void)startTimer;

- (void)stopTimer;

/// 获取剩余秒数
- (long)obtainSection;

@end

NS_ASSUME_NONNULL_END

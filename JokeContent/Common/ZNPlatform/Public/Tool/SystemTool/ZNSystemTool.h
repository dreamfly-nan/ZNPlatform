//
//  ZNSystemTool.h
//  JokeContent
//  该类尚未测试
//  Created by 南木南木 on 2019/7/4.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZNSystemTool : NSObject

//获取当前设备可用内存
+ (double)availableMemory;

//获取当前任务所占用内存
+ (double)usedMemory;

@end

NS_ASSUME_NONNULL_END

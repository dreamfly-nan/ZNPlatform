//
//  ZNDefineHeader.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/26.
//  Copyright © 2019 南木南木. All rights reserved.
//

#ifndef ZNDefineHeader_h
#define ZNDefineHeader_h

//弱引用
#define znWeakSelf(x) __weak typeof(x) weakObject = (x);
#define znStrongSelf __strong typeof(weakObject) weakSelf = weakObject;

//代码块
#define znnBlockSelf(x) __block typeof(x) blockSelf = (x);

//状态栏高度大小
#define znStateSize [UIApplication sharedApplication].statusBarFrame.size
#define znStateHeight znStateSize.height

//屏幕高度大小
#define screenBounds [UIScreen mainScreen].bounds
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenScale ([[UIScreen mainScreen] scale])

#define znString(x) [NSString stringWithFormat:@"%@",x]

#define UIImageMake(img) [UIImage imageNamed:img]

/// UIColor 相关的宏，用于快速创建一个 UIColor 对象，更多创建的宏可查看
#define UIColorMake(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define UIColorMakeWithRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]

#endif /* ZNDefineHeader_h */

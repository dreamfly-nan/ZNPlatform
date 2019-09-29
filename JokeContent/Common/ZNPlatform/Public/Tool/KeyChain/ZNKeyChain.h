//
//  KHKeyChain.h
//  networkTest
//
//将信息保存到 钥匙串中
//  Created by 郑楠楠 on 2017/11/3.
//  Copyright © 2017年 郑楠楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZNKeyChain : NSObject

/**
 保存数据

 @param service key
 @param data 数据
 @return 是否保存成功
 */
+ (BOOL) save:(NSString*)service data:(id)data;

/**
 加载数据

 @param service key
 @return key对应的数据
 */
+ (id) load:(NSString*)service;

/**
 根据key删除数据

 @param service key
 */
+ (void) delete:(NSString*)service;
@end

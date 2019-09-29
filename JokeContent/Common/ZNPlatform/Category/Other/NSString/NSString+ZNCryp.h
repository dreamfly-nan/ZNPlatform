//
//  NSString+ZNCryp.h
//  ZNNavigationViewController
//
//  Created by 郑楠楠 on 2018/4/26.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZNCryp)

/**
 md5加密

 @param input <#input description#>
 @return <#return value description#>
 */
+ (NSString*)zn_md5:(NSString *)input;

/**
 DES加密
 @param key 钥匙
 @return <#return value description#>
 */
- (NSString*)zn_InDESWithKey:(NSString*)key;

/**
 DES解密
 @param key 钥匙
 @return <#return value description#>
 */
- (NSString*)zn_OutDESWithKey:(NSString*)key;

@end

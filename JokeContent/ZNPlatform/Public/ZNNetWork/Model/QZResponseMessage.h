//
//  ZNResponseMessage.h
//  ZNNavigationViewController
//
//  Created by 郑楠楠 on 2018/10/29.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZNResponseMessage : NSObject

@property (nonatomic , assign) int code;

/**
 表示业务是否正确
 */
@property (nonatomic , assign) BOOL isTrue;

@property (nonatomic , copy) NSString * message;

+ (instancetype)initWithCode:(int)code
                      isTrue:(BOOL)isTrue
                     message:(NSString *) message;

- (void)setCode:(int)code
         isTrue:(BOOL)isTrue
        message:(NSString *) message;
@end

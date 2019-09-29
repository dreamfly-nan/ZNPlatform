//
//  ZNResponseMessage.m
//  ZNNavigationViewController
//
//  Created by 郑楠楠 on 2018/10/29.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "ZNResponseMessage.h"

@implementation ZNResponseMessage

+ (instancetype)initWithCode:(int)code
                      isTrue:(BOOL)isTrue
                     message:(NSString *) message{
    ZNResponseMessage * model = [ZNResponseMessage new];
    [model setCode:code isTrue:isTrue message:message];
    return model;
}

- (void)setCode:(int)code
         isTrue:(BOOL)isTrue
        message:(NSString *) message{
    self.code = code;
    self.message = message;
    self.isTrue = isTrue;
}

@end

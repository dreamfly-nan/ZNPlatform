//
//  NSData+ZNBase64.m
//  CityManagement
//
//  Created by 南木南木 on 2019/9/2.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "NSData+ZNBase64.h"

@implementation NSString (ZNBase64)

- (NSString *) stringPaddedForBase64 {
    NSUInteger paddedLength = self.length + (self.length % 3);
    return [self stringByPaddingToLength:paddedLength withString:@"=" startingAtIndex:0];
}

@end

@implementation NSData (ZNBase64)

@end

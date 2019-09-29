//
//  NSData+ZNBase64.h
//  CityManagement
//
//  Created by 南木南木 on 2019/9/2.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZNBase64)

- (NSString *) stringPaddedForBase64;

@end

@interface NSData (ZNBase64)

@end

NS_ASSUME_NONNULL_END

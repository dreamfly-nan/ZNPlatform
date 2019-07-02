//
//  NSObject+object.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/17.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ZNObject)
    
+ (NSDictionary*)zn_getObjectData:(id)obj;

+ (instancetype)zn_convert:(NSDictionary*)dataSource;

//获取属性列表
+ (NSArray*)zn_propertyKeys;


@end

NS_ASSUME_NONNULL_END

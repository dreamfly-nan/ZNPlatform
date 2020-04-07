//
//  ZNMentItemModel.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/8.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZNMentItemModel : NSObject

@property (copy , nonatomic) NSString  * title;

@property (copy , nonatomic) NSString * imageName;

@property (copy , nonatomic) NSString * imageUrl;

//类型标识
@property (nonatomic , assign) int type;

//是否是url
@property(nonatomic,assign) BOOL isUrl;

+ (instancetype)initWithTitle:(NSString*) title image:(NSString*) name;

+ (instancetype)initWithTitle:(NSString*) title url:(NSString*) url;

@end

NS_ASSUME_NONNULL_END

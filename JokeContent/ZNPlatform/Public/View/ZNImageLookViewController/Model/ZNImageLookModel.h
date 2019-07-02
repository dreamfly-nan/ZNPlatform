//
//  ZNImageLookModel.h
//  JokeContent
//
//  Created by 南木南木 on 2019/6/12.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,ZNImageLookModelResource){
    ZNImageLookModelResourceURL,
    ZNImageLookModelResourceImage
};

NS_ASSUME_NONNULL_BEGIN

@interface ZNImageLookModel : NSObject

@property(nonatomic,strong) UIImage * image;

@property(nonatomic,copy) NSString * imageUrl;

@property(nonatomic,assign) ZNImageLookModelResource type;

+ (instancetype)initWithUrl:(NSString*)url;

+ (instancetype)initWithImage:(UIImage*) image;

@end

NS_ASSUME_NONNULL_END

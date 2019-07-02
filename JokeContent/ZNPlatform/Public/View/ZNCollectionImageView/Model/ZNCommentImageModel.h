//
//  ZNCommentImageModel.h
//  JokeContent
//
//  Created by 南木南木 on 2019/6/11.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,ZNCommentImageCellType){
    ZNCommentImageCellTypeImage,            //图片展示
    ZNCommentImageCellTypeAddImage          //图片添加
};

typedef NS_ENUM(NSUInteger,ZNCommentImageCellResource) {
    ZNCommentImageCellResourceURL,          //图片来源url
    ZNCommentImageCellResourceImage         //图片为image对象
};

@interface ZNCommentImageModel : NSObject

@property(nonatomic,assign) ZNCommentImageCellType cellType;

@property(nonatomic,assign) ZNCommentImageCellResource resourceType;

@property (copy , nonatomic) NSString * imageUrl;

@property(nonatomic,strong) UIImage * image;

+ (instancetype)initWithImage:(UIImage*) image;

+ (instancetype)initWithImageUrl:(NSString*) imageUrl;

+ (instancetype)initWithAddType:(ZNCommentImageCellType) type;

@end

NS_ASSUME_NONNULL_END

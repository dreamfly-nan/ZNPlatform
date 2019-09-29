//
//  ZNFileModel.h
//  ZNNavigationViewController
//
//  Created by 郑楠楠 on 2018/10/26.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define DataModelTimeIntervalSince1970 [NSString stringWithFormat:@"%lld",(long long)([[NSDate date] timeIntervalSince1970] * 1000)]

typedef enum : NSUInteger {
    ZNFileTypeImage,             //图片文件
    ZNFileVideo                  //视频文件
} ZNFileType;

@interface ZNFileModel : NSObject

//文件类型
@property (nonatomic , assign)      ZNFileType         type;

//文件名
@property (nonatomic , copy)        NSString    *    _Nullable      fileName;

//文件数据
@property (nonatomic , strong)      NSData      *    _Nullable  fileData;

//上传的类型，默认为通用类型 @"multipart/form-data"
@property (nonatomic , copy)        NSString    *    _Nullable  fileMimeType;

//上传文件的名字，由时间戳字符串加文件名
@property (nonatomic , copy)        NSString    *    _Nullable  upDownFileName;

+ (instancetype _Nonnull )initWithDataModelWithImage:(UIImage * _Nonnull) image
                                      type:(ZNFileType) type
                                  fileName:(NSString * _Nonnull)fileName;

+ (instancetype _Nonnull)initWithData:(NSData * _Nonnull) data
                                  type:(ZNFileType) type
                              fileName:(NSString * _Nonnull) fileName;

- (void)setDataModelWithImage:(UIImage * _Nonnull) image
                         type:(ZNFileType) type
                     fileName:(NSString * _Nonnull)fileName;

@end

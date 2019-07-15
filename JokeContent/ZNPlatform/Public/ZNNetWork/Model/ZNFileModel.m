//
//  ZNFileModel.m
//  ZNNavigationViewController
//
//  Created by 郑楠楠 on 2018/10/26.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "ZNFileModel.h"

@interface ZNFileModel()

@end

@implementation ZNFileModel

+ (instancetype)initWithDataModelWithImage:(UIImage * _Nonnull) image
                                      type:(ZNFileType) type
                                  fileName:(NSString * _Nonnull)fileName{
    ZNFileModel * model = [ZNFileModel new];
    [model setDataModelWithImage:image type:type fileName:fileName];
    return model;
}

+ (instancetype _Nonnull)initWithData:(NSData * _Nonnull) data
                                 type:(ZNFileType) type
                             fileName:(NSString * _Nonnull) fileName{
    ZNFileModel * model = [ZNFileModel new];
    model.fileData = data;
    model.type = type;
    model.fileName = fileName;
    return model;
}

- (void)setDataModelWithImage:(UIImage * _Nonnull) image
                         type:(ZNFileType) type
                     fileName:(NSString * _Nonnull)fileName{
    self.type = type;
    self.fileName = fileName;
    NSData * data = UIImageJPEGRepresentation(image, 0.1);
    if (!data) {
        data = UIImagePNGRepresentation(image);
    }
    self.fileData = data;
    NSString * timeStr = DataModelTimeIntervalSince1970;
    self.upDownFileName = [NSString stringWithFormat:@"%@_%@.png",fileName,timeStr];
}

#pragma mark - get

- (NSString *)fileMimeType{
    if (!_fileMimeType) {
        _fileMimeType = @"multipart/form-data";
    }
    return _fileMimeType;
}

@end

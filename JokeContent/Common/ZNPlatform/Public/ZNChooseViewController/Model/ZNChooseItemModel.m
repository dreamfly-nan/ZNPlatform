//
//  ZNChooseItemModel.m
//  CityManagement
//
//  Created by 南木南木 on 2019/8/29.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "ZNChooseItemModel.h"

@implementation ZNChooseItemModel

+ (instancetype)initWithTitle:(NSString *) title
                         tips:(NSString*)tips
                         code:(NSString *) code{
    ZNChooseItemModel * model = [ZNChooseItemModel new];
    model.tips = tips;
    model.title = title;
    model.code = code;
    model.cellType = ZNChooseTableViewCellTypeText;
    return model;
}

+ (instancetype)initTimeWithTitle:(NSString *) title
                             tips:(NSString*)tips
                             code:(NSString *) code{
    ZNChooseItemModel * model = [ZNChooseItemModel new];
    model.tips = tips;
    model.title = title;
    model.code = code;
    model.cellType = ZNChooseTableViewCellTypeTime;
    return model;
}

+ (instancetype)initWithContent:(NSString *) content
                           code:(NSString*) code{
    ZNChooseItemModel * model = [ZNChooseItemModel new];
    model.content = content;
    model.code = code;
    model.cellType = ZNChooseTableViewCellTypeText;
    return model;
}

+ (instancetype)initWithContent:(NSString*) content{
    ZNChooseItemModel * model = [ZNChooseItemModel new];
    model.content = content;
    model.cellType = ZNChooseTableViewCellTypeText;
    return model;
}

@end

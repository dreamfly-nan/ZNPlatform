//
//  ZNTextCellModel.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/6/30.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNTextCellModel.h"

@implementation ZNTextCellModel

+ (instancetype)initWithCellType:(ZNTextTableViewCellType) cellType
                        lineType:(ZNTextTableViewCellLineType) lineType{
    ZNTextCellModel * model = [ZNTextCellModel new];
    model.cellType = cellType;
    model.lineType = lineType;
    return model;
}

+ (instancetype)initWithCellType:(ZNTextTableViewCellType) cellType
                        lineType:(ZNTextTableViewCellLineType) lineType
                           title:(NSString*) title{
    ZNTextCellModel * model = [self initWithCellType:cellType lineType:lineType];
    model.title = title;
    return model;
}

- (void)initWithPlaceStr:(NSString*) placeStr
                 content:(NSString*) content{
    self.placeStr = placeStr;
    self.content = content;
}

@end

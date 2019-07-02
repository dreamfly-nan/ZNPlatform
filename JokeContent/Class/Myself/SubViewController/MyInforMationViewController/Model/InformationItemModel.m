//
//  ItemModel.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/23.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "InformationItemModel.h"

@implementation InformationItemModel

+ (instancetype)initWithTitle:(NSString*)title
                      context:(NSString*)context
                         type:(InformationItemType)type{
    InformationItemModel * model = [InformationItemModel new];
    model.title = title;
    model.context = context;
    model.type = type;
    return model;
}

@end

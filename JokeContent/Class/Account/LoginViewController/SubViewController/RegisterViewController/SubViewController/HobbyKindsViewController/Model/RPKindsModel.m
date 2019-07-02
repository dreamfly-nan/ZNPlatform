//
//  RPKindsModel.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/5.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPKindsModel.h"

@implementation RPKindsModel

+ (instancetype)initWithName:(NSString *)name icon:(NSString*) icon platformTypeId:(NSString*) platformTypeId{
    RPKindsModel * model = [RPKindsModel new];
    model.name = name;
    model.iconUrl = icon;
    model.platformTypeId = platformTypeId;
    model.isSelect = NO;
    return model;
}

@end

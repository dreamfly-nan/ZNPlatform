//
//  RPKindsModel.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/5.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaseObject.h"

@interface RPKindsModel : RPBaseObject

@property (nonatomic , copy) NSString *iconUrl;

@property (nonatomic , copy) NSString *name;

@property (nonatomic , copy) NSString *platformTypeId;

@property (nonatomic , assign) BOOL isSelect;

+ (instancetype)initWithName:(NSString *)name icon:(NSString*) icon platformTypeId:(NSString*) platformTypeId;

@end

//
//  RPMyselfDataModel.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaseObject.h"
#import "RPMyItemModel.h"

@interface RPMyselfDataModel : RPBaseObject

@property (nonatomic , strong) NSArray<RPMyItemModel *> *items;

@end

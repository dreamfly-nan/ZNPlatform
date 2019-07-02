//
//  RPHobbyKindsDataModel.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/24.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaseObject.h"
#import "RPKindsModel.h"

@interface RPHobbyKindsDataModel : RPBaseObject

@property (nonatomic , strong) NSArray <RPKindsModel *>* items;

@property (nonatomic , strong) RACCommand *kindsCommand;

@property (nonatomic , strong) RACCommand *attentionKindsCommand;

@end

//
//  RPForgetPassworldDataModel.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/25.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaseObject.h"

@interface RPForgetPassworldDataModel : RPBaseObject

@property (nonatomic , strong) UserData * userdata;

@property (nonatomic , strong) RACCommand * selectCommand;

@property (nonatomic , strong) RACCommand * updataCommand;

@end

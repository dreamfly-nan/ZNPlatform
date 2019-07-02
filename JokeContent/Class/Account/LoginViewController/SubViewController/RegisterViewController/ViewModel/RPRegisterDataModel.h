//
//  RPRegisterDataModel.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/21.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaseObject.h"

@interface RPRegisterDataModel : RPBaseObject

//注册用户信息
@property (nonatomic , strong) RACCommand *registerCommand;

//是否已存在该账号
@property (nonatomic , strong) RACCommand * isExitCommamd;

@property (nonatomic , strong) UserData * userModel;

@end

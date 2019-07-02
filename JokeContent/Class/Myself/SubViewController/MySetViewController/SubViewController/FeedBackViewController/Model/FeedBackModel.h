//
//  FeedBackModel.h
//  JokeContent
//
//  Created by 社会人 on 2019/5/17.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "RPBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedBackModel : BaseObject

//用户id
@property (copy , nonatomic) NSString * userId;

//反馈内容
@property(nonatomic,copy) NSString * content;

//提交时间
@property(nonatomic,copy) NSString * createTime;

@end

NS_ASSUME_NONNULL_END

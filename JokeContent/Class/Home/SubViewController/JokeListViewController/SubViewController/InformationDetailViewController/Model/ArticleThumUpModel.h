//
//  ArticleThumUpModel.h
//  JokeContent
//
//  Created by 社会人 on 2019/5/16.
//  Copyright © 2019 社会人. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArticleThumUpModel : BaseObject

@property (copy , nonatomic) NSString * userId;

@property (copy , nonatomic) NSString * link;

/**
 是否点赞过 赞过  1   未点赞  0
 */
@property(nonatomic,strong) NSString * thumUp;

@end

NS_ASSUME_NONNULL_END

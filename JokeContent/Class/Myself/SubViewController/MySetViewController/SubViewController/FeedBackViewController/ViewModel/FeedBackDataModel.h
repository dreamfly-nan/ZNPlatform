//
//  FeedBackDataModel.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/22.
//  Copyright © 2019 社会人. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FeedBackDataModel : NSObject

@property(nonatomic,strong) RACCommand * commitFeedCommand;

@end

NS_ASSUME_NONNULL_END

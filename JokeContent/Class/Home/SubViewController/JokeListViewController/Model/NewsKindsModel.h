//
//  NewsModel.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/18.
//  Copyright © 2019 社会人. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsKindsModel : BmobObject

@property (nonatomic , copy) NSString  * channelId;

@property (nonatomic , copy) NSString  * name;

@end

NS_ASSUME_NONNULL_END

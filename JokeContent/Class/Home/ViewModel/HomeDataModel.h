//
//  HomeDataModel.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/17.
//  Copyright © 2019 社会人. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsKindsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeDataModel : NSObject
    
@property (nonatomic , strong) RACCommand * kindsCommand;

@property (nonatomic , strong) NSArray <NewsKindsModel *> *kinds;

@end

NS_ASSUME_NONNULL_END

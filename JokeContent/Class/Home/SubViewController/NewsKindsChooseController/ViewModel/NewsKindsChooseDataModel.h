//
//  NewsKindsChooseDataModel.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/22.
//  Copyright © 2019 社会人. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsKindsChooseDataModel : NSObject

@property (nonatomic , strong) RACCommand * upChooseCommand;

@property (nonatomic , strong) RACCommand * kindsCommand;

/**
 初始化数据
 */
- (void)setInitData;

@end

NS_ASSUME_NONNULL_END

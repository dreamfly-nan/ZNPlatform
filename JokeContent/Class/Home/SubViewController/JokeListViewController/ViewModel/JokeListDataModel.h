//
//  JokeListDataModel.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/17.
//  Copyright © 2019 社会人. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JokeListDataModel : NSObject

@property (nonatomic , strong) NSMutableArray<NewsDetailModel*> * informations;

@property (nonatomic , strong) RACCommand * informationCommand;

@property (nonatomic , copy) NSString  * typeId;

@property (nonatomic , copy) NSString  * searchText;

@property (nonatomic , assign) int  page;

@property (nonatomic , assign) int  pageNumer;

//是否没有数据
@property (nonatomic , assign) BOOL  isNoMoreData;

@end

NS_ASSUME_NONNULL_END

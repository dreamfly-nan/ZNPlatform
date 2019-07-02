//
//  RPMyInformationDataModel.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/23.
//  Copyright © 2019 社会人. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InformationItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RPMyInformationDataModel : NSObject

@property (nonatomic , strong) RACCommand * upUserDataCommand;

@property (nonatomic , strong) NSArray<InformationItemModel*> * items;

- (void)upUserData;

@end

NS_ASSUME_NONNULL_END

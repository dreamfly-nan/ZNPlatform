//
//  ChooseItemModel.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/26.
//  Copyright © 2019 社会人. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChooseItemModel : NSObject

@property (nonatomic , strong) NewsKindsModel * model;

@property (nonatomic , assign) BOOL  isChoose;

@end

NS_ASSUME_NONNULL_END

//
//  NewsKindsChooseController.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/19.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "RPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NewsKindsChooseControllerDelegate <NSObject>

- (void)chooseFinish:(NSArray<NewsKindsModel*> *) kinds;

@end

@interface NewsKindsChooseController : RPBaseViewController

@property (nonatomic , weak) id<NewsKindsChooseControllerDelegate> znDelegate;


/**
 上级控制器是否是用户注册,不是的话，就是从主页面进来的
 */
@property (nonatomic , assign) BOOL  isPreRegisterController;

@end

NS_ASSUME_NONNULL_END

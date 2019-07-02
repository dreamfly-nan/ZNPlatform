//
//  IntroductionCollectionViewCell.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/5/2.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "RPBaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface IntroductionCollectionViewCell : RPBaseCollectionViewCell

@property (nonatomic , copy) NSString * imageUrl;

@property (nonatomic , strong) UIButton * functionBtn;

@property (nonatomic , copy) void (^btnBlock)(UIButton * btn);

//用于重定义cellbtn的布局
@property (nonatomic , copy) void  (^btnLayout)(UIButton * btn);

@end

NS_ASSUME_NONNULL_END

//
//  NewsImageModel.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/18.
//  Copyright © 2019 社会人. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsImageModel : NSObject

/**
 图片的url
 */
@property (nonatomic , copy) NSString  * url;

@property (nonatomic , assign) CGFloat  height;

@property (nonatomic , assign) CGFloat  width;

@end

NS_ASSUME_NONNULL_END

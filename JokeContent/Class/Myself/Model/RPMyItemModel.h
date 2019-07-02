//
//  RPMyItemModel.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPBaseObject.h"

@interface RPMyItemModel : RPBaseObject

@property (nonatomic , strong) NSString *name;

@property (nonatomic , strong) NSString *iconImage;

@property (nonatomic , strong) NSString *viewController;

+ (instancetype)initWihtName:(NSString*)name
                   iconImage:(NSString*)iconImage
              viewController:(NSString*)viewController;

@end

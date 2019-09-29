//
//  ZNPopoMenuItemModel.h
//  CityManagement
//
//  Created by 南木南木 on 2019/9/3.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "ZNBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZNPopoMenuItemModel : ZNBaseObject

@property (copy , nonatomic) NSString * iconName;

@property (copy , nonatomic) NSString * name;

+ (instancetype)initWithIconName:(NSString*) iconName
                            name:(NSString*) name;

@end

NS_ASSUME_NONNULL_END

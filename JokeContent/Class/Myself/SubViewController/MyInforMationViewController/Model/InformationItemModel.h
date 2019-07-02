//
//  ItemModel.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/23.
//  Copyright © 2019 社会人. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,InformationItemType){
    InformationItemTypeNikeName,
    InformationItemTypeIntroduction,
};

@interface InformationItemModel : NSObject

@property (nonatomic , copy) NSString  * title;

@property (nonatomic , copy) NSString  * context;

@property (nonatomic , assign) InformationItemType  type;

+ (instancetype)initWithTitle:(NSString*)title
                      context:(NSString*)context
                         type:(InformationItemType)type;

@end

NS_ASSUME_NONNULL_END

//
//  ZNChooseItemModel.h
//  CityManagement
//
//  Created by 南木南木 on 2019/8/29.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "ZNBaseObject.h"

NS_ASSUME_NONNULL_BEGIN

/**
 <#Description#>

 - ZNTextTableViewCellTypeChoose: 普通的选择
 - ZNTextTableViewCellTypeTime: 选择时间
 */
typedef NS_ENUM(NSUInteger,ZNChooseTableViewCellType) {
    ZNChooseTableViewCellTypeText = 0,
    ZNChooseTableViewCellTypeTime = 1
};

@interface ZNChooseItemModel : ZNBaseObject

@property(nonatomic,assign) ZNChooseTableViewCellType cellType;

/**
 标题
 */
@property(nonatomic,copy) NSString * title;

/**
 内容
 */
@property(nonatomic,copy) NSString * content;

/**
 提示语
 */
@property (copy , nonatomic) NSString * tips;

/**
 逻辑代码
 */
@property (copy , nonatomic) NSString * code;

/**
 是否展开
 */
@property (assign , nonatomic) BOOL isExtend;

/**
 是否是选中
 */
@property(nonatomic,assign) BOOL isChoose;

+ (instancetype)initWithTitle:(NSString *) title
                         tips:(NSString*)tips
                         code:(NSString *) code;

+ (instancetype)initTimeWithTitle:(NSString *) title
                         tips:(NSString*)tips
                         code:(NSString *) code;

+ (instancetype)initWithContent:(NSString *) content
                           code:(NSString*) code;

+ (instancetype)initWithContent:(NSString*) content;

@end

NS_ASSUME_NONNULL_END

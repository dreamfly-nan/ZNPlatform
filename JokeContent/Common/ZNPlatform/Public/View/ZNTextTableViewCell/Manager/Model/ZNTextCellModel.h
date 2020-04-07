//
//  ZNTextCellModel.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/6/30.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 cell的类型

 - ZNTextTableViewCellTypeLabel:        只作为显示使用
 - ZNTextTableViewCellTypeTextField:    右边可以填写
 - ZNTextTableViewCellTypeTextView:     下面可以进行填写
 - ZNTextTableViewCellTypeChoose:       可点击选择
 */
typedef NS_ENUM(NSUInteger,ZNTextTableViewCellType){
    ZNTextTableViewCellTypeLabel,
    ZNTextTableViewCellTypeTextField,
    ZNTextTableViewCellTypeTextView,
    ZNTextTableViewCellTypeChoose
};

/**
 cell底部线条的类型

 - ZNTextTableViewCellLineTypeLeft:         固定距离左边
 - ZNTextTableViewCellLineTypeWithTitle:    跟随左边的标题
 - ZNTextTableViewCellLineTypeAll               充满整个屏幕
 - ZNTextTableViewCellLineTypeNone:         不显示线条
 */
typedef NS_ENUM(NSUInteger,ZNTextTableViewCellLineType) {
    ZNTextTableViewCellLineTypeLeft,
    ZNTextTableViewCellLineTypeWithTitle,
    ZNTextTableViewCellLineTypeAll,
    ZNTextTableViewCellLineTypeNone
};

/**
 设置内容显示，靠右的样式
 - ZNTextTableViewCellContentRightSpaceWithArrow: 紧靠着箭头
 - ZNTextTableViewCellContentRightSpaceWithSuperView: 跟随父控件
 */
typedef NS_ENUM(NSUInteger,ZNTextTableViewCellContentRightSpace){
    ZNTextTableViewCellContentRightSpaceWithArrow,
    ZNTextTableViewCellContentRightSpaceWithSuperView
};

@interface ZNTextCellModel : NSObject

/**
 任意类型的数据存放
 */
@property (nonatomic , strong) id data;

/**
 cell的类型
 */
@property(nonatomic,assign) ZNTextTableViewCellType cellType;

/**
 cell底部线条的类型
 */
@property(nonatomic,assign) ZNTextTableViewCellLineType lineType;

/**
 cell内容的靠右类型
 */
@property(nonatomic,assign) ZNTextTableViewCellContentRightSpace contentType;

/**
 是否有进行重设内容的显示类型
 */
@property(nonatomic,assign,readonly) BOOL isSetContentType;

/**
 业务编码 - 用户可自定义，根据自定义的编码进行实现对应逻辑
 */
@property (copy , nonatomic) NSString * code;

/**
 左边的标题
 */
@property (copy , nonatomic) NSString * title;

/**
 占位符，cellType为ZNTextTableViewCellTypeTextField时，可用
 */
@property (copy , nonatomic) NSString * placeStr;

/**
 内容
 */
@property (copy , nonatomic) NSString * content;

/**
 用来传给服务端使用的
 */
@property (nonatomic , copy) NSString * valuse;

/**
 内容是否允许为空
 */
@property(nonatomic,assign) BOOL ableNilOrEmptContent;

/**
 是否展示右边的箭头
 */
@property(nonatomic,assign) BOOL isShowArrow;

/**
 cell是否需要选中
 */
@property(nonatomic,assign) BOOL selectType;

/**
 打开查看模式，不可编辑，只可查看
 */
@property(nonatomic,assign) BOOL look;

+ (instancetype)initWithCellType:(ZNTextTableViewCellType) cellType
                        lineType:(ZNTextTableViewCellLineType) lineType;

+ (instancetype)initWithCellType:(ZNTextTableViewCellType) cellType
                        lineType:(ZNTextTableViewCellLineType) lineType
                           title:(NSString*) title;

- (void)initWithPlaceStr:(NSString*) placeStr
                 content:(NSString*) content;

@end

NS_ASSUME_NONNULL_END

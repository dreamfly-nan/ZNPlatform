//
//  ZNTextTabBarView.h
//  TableViewCollectView
//
//  Created by 郑楠楠 on 2018/4/2.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNTitleModel.h"

typedef NS_ENUM(NSInteger,ZNTextTabBarViewLineStype){
    ZNTextTabBarViewLineStypeWithText,            //线条的长度跟文字的长度一致
    ZNTextTabBarViewLineStypeLong                  //线条宽度 = 屏幕宽度 / 一个屏幕放的数量
};

@protocol ZNTextTabBarViewDelegate;

@interface ZNTextTabBarView : UIView

@property (nonatomic,weak) id<ZNTextTabBarViewDelegate > znDelegate;

@property (nonatomic,strong) NSArray<ZNTitleModel *> *titles;

/**
 标题下线条颜色
 */
@property (nonatomic , strong) UIColor *lineColor;

//线条的高度
@property (nonatomic , assign) CGFloat lineHeight;

/**
 设置线条的风格
 */
@property (nonatomic , assign) ZNTextTabBarViewLineStype lineType;

/**
 这个属性只有在type == ZNTextTabBarViewLineStypeLong
 */
@property (nonatomic , assign) int titleNumber;

//是否让选中项居中
@property (nonatomic , assign) BOOL isSelectOnCenterX;
//是否将标题居中,这个属性只有在 lineType == ZNTextTabBarViewLineStypeWithText时有作用
@property (nonatomic, assign) BOOL isOnCenterX;

//标题之间的间隔,这个属性只有在 lineType == ZNTextTabBarViewLineStypeWithText时有作用
@property (nonatomic , assign) CGFloat interval;
//地下线条是否需要圆角
@property (nonatomic , assign) BOOL isRoundLine;

//是否隐藏下划线
@property (nonatomic , assign) BOOL lineHidden;

//滑动到某一项
- (void)scrollToIndex:(int)index;

@end

@protocol ZNTextTabBarViewDelegate <NSObject>

@optional

/**
 被选中的时候进行调用

 @param index 选中项的序号
 @param model 选中项的数据
 */
- (void)selectItemWithIndex:(int) index
                      model:(ZNTitleModel *)model;

@end

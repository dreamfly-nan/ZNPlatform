//
//  RPColorHeader.h
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/21.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#ifndef RPColorHeader_h
#define RPColorHeader_h

#import <UIKit/UIKit.h>
#import "ZNStateFunction.h"

//主色调
UIKIT_STATIC_INLINE UIColor * Main_Color(){
    return zn_colorString(@"#56B5D5");
}

//选项卡未选中的颜色
UIKIT_STATIC_INLINE UIColor * TabBar_NOSelect_Color(){
    return zn_colorString(@"#707070");
}

//标题颜色
UIKIT_STATIC_INLINE UIColor * Title_Color(){
    return zn_colorString(@"#545556");
}

//内容颜色
UIKIT_STATIC_INLINE UIColor * Content_Color(){
    return zn_colorString(@"#636161");
}

//作者，日期等颜色
UIKIT_STATIC_INLINE UIColor * AuOrDate_Color(){
    return zn_colorString(@"#BFBFBF");
}

//简介的颜色
UIKIT_STATIC_INLINE UIColor *Introduction_Color(){
    return zn_colorString(@"#ABACAD");
}

//大背景颜色
UIKIT_STATIC_INLINE UIColor * Big_background_Color(){
    return zn_colorString(@"#F7F6F6");
}

//线条颜色
UIKIT_STATIC_INLINE UIColor * Line_Color(){
    return zn_colorString(@"#cdcdcd");
}

//未选中时的颜色
UIKIT_STATIC_INLINE UIColor * NoSelect_Color(){
    return zn_colorString(@"#BDBDBD");
}

//关注按键的颜色
UIKIT_STATIC_INLINE UIColor *Attention_Btn_Bg_Color(){
    return zn_colorString(@"#F97856");
}

#endif /* RPColorHeader_h */

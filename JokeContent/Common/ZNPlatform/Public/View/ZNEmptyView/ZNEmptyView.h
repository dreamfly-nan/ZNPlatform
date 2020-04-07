//
//  ZNEmptyView.h
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2019/11/6.
//  Copyright © 2019 ttyx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZNEmptyView : UIView

@property (nonatomic , copy) NSString * imageName;

@property (nonatomic , copy) NSString * title;

@property (nonatomic , copy) NSString * subTitle;

@property (nonatomic , copy) NSString * btnText;

//是否显示按键  默认显示
@property (nonatomic , assign) BOOL isShowBtn;

@property (nonatomic , copy) void (^btnActionBlock)(void);

/// 距离顶部的高度
/// @param height <#height description#>
- (void)topHeight:(CGFloat) height;

@end

NS_ASSUME_NONNULL_END

//
//  ZNLoadingView.h
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2019/11/6.
//  Copyright © 2019 ttyx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZNLoadingView : UIView

@property (nonatomic , strong) NSArray<NSString*> * images;

//动画间隔时间
@property (nonatomic , assign) CGFloat time;

//动画开始
- (void)startAnimation;

//动画停止
- (void)stopAnimation;

/// 在该视图的中心加载
/// @param view <#view description#>
- (void)loadingOnViewCenter:(UIView*) view
                     offset:(CGFloat) offset;

- (void)onScreenCenter;

@end

NS_ASSUME_NONNULL_END

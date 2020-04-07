//
//  ZNRecommendView.h
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2019/11/23.
//  Copyright © 2019 ttyx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZNRecommendView : UICollectionReusableView

/// 推荐标题
@property (nonatomic , strong) UILabel * recommendLabel;

@property (nonatomic , strong) UIButton * deleteBtn;

@property (nonatomic , assign) BOOL isShowClear;

/// 清楚历史记录
@property (nonatomic , copy) void (^clearHistory)(void);

@end

NS_ASSUME_NONNULL_END

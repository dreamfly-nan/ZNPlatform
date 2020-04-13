//
//  UIImageView+ZNTool.h
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2019/12/19.
//  Copyright © 2019 ttyx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (ZNTool)
///imageView 圆角切圆角
+(UIImageView *)zn_pathImageView:(UIImageView *)imageView
                     connerRadii:(CGSize)connerRadii;

@end

NS_ASSUME_NONNULL_END

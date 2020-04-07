//
//  UILable+ChangeStringSpace.h
//  TuTuYouXuan
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 ttyx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel(ChangeStringSpace)
/// 改变行距
/// @param lable <#lable description#>
/// @param space <#space description#>
+ (void)changeLineSpaceforLable:(UILabel *)lable WithSpace:(float)space;

/// 改变字间距
/// @param lable <#lable description#>
/// @param space <#space description#>
+ (void)changeWordSpaceForLabel:(UILabel *)lable WithSpace:(float)space;

/// 改变字行 间距
/// @param lable <#lable description#>
/// @param linkspace <#linkspace description#>
/// @param wordspace <#wordspace description#>
+ (void)changeSpaceForLable:(UILabel *)lable withLineSpace:(float)linkspace WordSpace:(float)wordspace;
@end

NS_ASSUME_NONNULL_END

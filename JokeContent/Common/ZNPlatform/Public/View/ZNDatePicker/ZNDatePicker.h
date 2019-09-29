//
//  ZNDatePicker.h
//  CityManagement
//
//  Created by 郑楠楠 on 2019/8/18.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZNDatePicker : UIView

@property (nonatomic , copy) void (^pickerBlick)(NSString * dateStr);

+ (void)zn_showDatePickerWithBlick:(void (^)(NSString * dateStr)) block;

@end

NS_ASSUME_NONNULL_END

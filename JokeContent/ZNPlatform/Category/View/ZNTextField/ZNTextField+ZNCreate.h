//
//  ZNTextField+ZNCreate.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/18.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZNTextField (ZNCreate)

- (ZNTextField * (^)(UIFont * font) )zn_font;

- (ZNTextField * (^)(UIColor * textColor))zn_textColor;

- (ZNTextField * (^)(NSString * text))zn_text;

- (ZNTextField * (^)(NSString * placeStr))zn_place;

- (ZNTextField * (^)(NSTextAlignment alignment))zn_alignment;

- (ZNTextField * (^)(CGFloat imageSpace))zn_imageSpace;

- (ZNTextField * (^)(UIImage * image))zn_leftImage;

- (ZNTextField * (^)(BOOL isLeftView))zn_isLeftView;

@end

NS_ASSUME_NONNULL_END

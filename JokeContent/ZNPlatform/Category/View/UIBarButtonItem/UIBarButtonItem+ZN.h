//
//  UIBarButtonItem+ZN.h
//  JokeContent
//
//  Created by 南木南木 on 2019/6/12.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (ZN)

+(UIBarButtonItem*) zn_obtainWithImage:(UIImage * ) image
                                 block:(void (^)(void)) block;

@end

NS_ASSUME_NONNULL_END

//
//  UIBarButtonItem+ZN.m
//  JokeContent
//
//  Created by 南木南木 on 2019/6/12.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "UIBarButtonItem+ZN.h"

@implementation UIBarButtonItem (ZN)

+(UIBarButtonItem*) zn_obtainWithImage:(UIImage * ) image
                                 block:(void (^)(void)) block{
    if (image == nil) {
        return nil;
    }
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    [btn setImage:image forState:UIControlStateNormal];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (block) {
            block();
        }
    }];
    UIBarButtonItem * barBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return barBtn;
}

@end

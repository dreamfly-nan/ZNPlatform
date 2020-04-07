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

+(UIBarButtonItem *)itemWithTitle:(NSString *)title hightTitle:(NSString *)highttitle target:(id)target action:(SEL)action{
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 25)];
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitle:highttitle forState:(UIControlStateHighlighted)];
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    [button setTitleColor:UIColorMakeWithRGBA(102, 102, 102, 1) forState:(UIControlStateNormal)];
    button.titleLabel.font = zn_font(14);
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+(UIBarButtonItem *)itemWithIcon:(NSString *)icon HightIcon:(NSString *)highticon target:(id)target action:(SEL)action{
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 50)];
    [button setImage:[UIImage imageNamed:icon] forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:highticon] forState:(UIControlStateHighlighted)];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

@end

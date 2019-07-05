//
//  UIImageView+ZNCreate.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/4.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "UIImageView+ZNCreate.h"

@implementation UIImageView (ZNCreate)

- (UIImageView * (^)(NSString * imageName))zn_imageName{
    return ^(NSString * imageName){
        self.image = [UIImage imageNamed:imageName];
        return self;
    };
}

- (UIImageView * (^)(UIImage * image))zn_image{
    return ^(UIImage * image){
        self.image = image;
        return self;
    };
}

- (UIImageView * (^)(UIViewContentMode mode))zn_contentMode{
    return ^(UIViewContentMode mode){
        self.contentMode = mode;
        return self;
    };
}

@end

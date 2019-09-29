//
//  RPSearchTextField.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/5/1.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPSearchTextField.h"
@interface RPSearchTextField()

@end

@implementation RPSearchTextField

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += self.left_distance;
    return iconRect;
}

@end

//
//  RPRfreshHeader.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/6/9.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPRfreshHeader.h"

@implementation RPRfreshHeader


#pragma mark - 覆盖父类的方法
- (void)prepare
{
    [super prepare];
    self.stateLabel.font = zn_font(15);
    self.lastUpdatedTimeLabel.font = zn_font(14);
}

@end

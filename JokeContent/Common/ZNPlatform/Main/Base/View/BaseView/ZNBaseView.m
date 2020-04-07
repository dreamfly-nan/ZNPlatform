//
//  ZNBaseView.m
//  TuTuYouXuan
//
//  Created by ttyx-2 on 2020/3/26.
//  Copyright © 2020 ttyx. All rights reserved.
//

#import "ZNBaseView.h"

@implementation ZNBaseView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.respondView) {
        ///触点是否落在本视图上
        if ([self pointInside:point withEvent:event]) {
            return self.respondView;
        }
    }
   return [super hitTest:point withEvent:event];
}

@end

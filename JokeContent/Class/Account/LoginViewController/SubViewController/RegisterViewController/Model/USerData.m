//
//  USerData.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/15.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "USerData.h"

@implementation UserData

+ (NSDictionary *)replaceDic{
    return @{@"id":@"objectId"};
}

/**
 设置用户关注的类别
 @param kinds <#kinds description#>
 */
- (void)setKinds:(NSArray<NewsKindsModel*>*) kinds{
    
    NSMutableString * kindIds = [NSMutableString new];
    int i =0;
    for (; i < kinds.count - 1; i++) {
        [kindIds appendString:kinds[i].channelId];
        [kindIds appendString:sepString];
    }
    
    [kindIds appendString:kinds[i].channelId];
    self.kindsIds = [kindIds copy];
}

- (NSArray<NSString*>*)obtainKindsId{
    if (self.kindsIds) {
        return [self.kindsIds componentsSeparatedByString:sepString];
    }
    return nil;
}

@end

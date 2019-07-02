//
//  RPMyselfDataModel.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPMyselfDataModel.h"

@implementation RPMyselfDataModel

- (NSArray<RPMyItemModel *> *)items{
    if (!_items) {
        _items = [self getItems];
    }
    return _items;
}

- (NSArray *)getItems{
    RPMyItemModel * information = [RPMyItemModel initWihtName:@"资料" iconImage:@"my_information" viewController:@"RPMyInformationViewController"];
    RPMyItemModel * comment = [RPMyItemModel initWihtName:@"评论" iconImage:@"my_comment" viewController:@"RPMyCommentViewController"];
    RPMyItemModel *  systemMessage = [RPMyItemModel initWihtName:@"通知" iconImage:@"my_system" viewController:@"RPMySystemMessageViewController"];
    RPMyItemModel *  set = [RPMyItemModel initWihtName:@"设置" iconImage:@"set_system" viewController:@"RPMySetViewController"];
    return @[information,comment,systemMessage,set];
}

@end

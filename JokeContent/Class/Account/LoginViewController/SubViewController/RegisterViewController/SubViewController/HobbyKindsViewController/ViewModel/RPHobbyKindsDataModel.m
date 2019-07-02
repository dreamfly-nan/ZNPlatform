//
//  RPHobbyKindsDataModel.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/24.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPHobbyKindsDataModel.h"

@implementation RPHobbyKindsDataModel

#pragma mark -----------get------------

- (NSArray<RPKindsModel *> *)items{
    if (!_items) {
        
    }
    return _items;
}

- (RACCommand *)kindsCommand{
    if (!_kindsCommand) {
        znWeakSelf(self)
        _kindsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                return nil;
            }];
        }];
    }
    return _kindsCommand;
}

- (RACCommand *)attentionKindsCommand{
    if (!_attentionKindsCommand) {
        znWeakSelf(self)
        _attentionKindsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                znStrongSelf
                
                return nil;
            }];
        }];
    }
    return _attentionKindsCommand;
}

@end

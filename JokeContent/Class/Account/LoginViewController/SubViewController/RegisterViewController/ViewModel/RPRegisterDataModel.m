//
//  RPRegisterDataModel.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/21.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPRegisterDataModel.h"

@implementation RPRegisterDataModel

#pragma mark ------get----------

- (RACCommand *)isExitCommamd{
    if (!_isExitCommamd) {
        _isExitCommamd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [UserData zn_selectWithDic:input block:^(NSArray * _Nonnull array, NSError * _Nonnull error) {
                    if (error) {
                        [subscriber sendNext:@[@(NO),@"网络出错！"]];
                        [subscriber sendCompleted];
                    }else{
                        if (array.count > 0) {
                            [subscriber sendNext:@[@(NO),@"该用户已存在！"]];
                            [subscriber sendCompleted];
                        }else{
                            [subscriber sendNext:@[@(YES)]];
                            [subscriber sendCompleted];
                        }
                    }
                }];
                return nil;
            }];
        }];
    }
    return _isExitCommamd;
}

- (RACCommand *)registerCommand{
    if (!_registerCommand) {
        znWeakSelf(self)
        _registerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                znStrongSelf
                [weakSelf.userModel zn_addData:^(BOOL success, NSError * _Nonnull error) {
                    if (success) {
                        [subscriber sendNext:@[@(YES)]];
                        [subscriber sendCompleted];
                    }else{
                        [subscriber sendNext:@[@(NO),@"注册失败"]];
                        [subscriber sendCompleted];
                    }
                }];
                return nil;
            }];
        }];
    }
    return _registerCommand;
}

@end

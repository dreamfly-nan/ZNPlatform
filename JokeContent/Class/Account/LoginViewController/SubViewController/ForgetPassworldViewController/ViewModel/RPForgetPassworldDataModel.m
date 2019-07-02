//
//  RPForgetPassworldDataModel.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/25.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPForgetPassworldDataModel.h"

@implementation RPForgetPassworldDataModel


#pragma mark - get

- (RACCommand *)selectCommand{
    if (!_selectCommand) {
        znWeakSelf(self)
        _selectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                znStrongSelf
                [UserData zn_selectWithDic:input block:^(NSArray * _Nonnull array, NSError * _Nonnull error) {
                    if(error){
                        [subscriber sendNext:@[@(NO),@"网络请求失败！"]];
                        [subscriber sendCompleted];
                    }else{
                        if (array.count > 0) {
                            weakSelf.userdata = [array lastObject];
                            [subscriber sendNext:@[@(YES)]];
                            [subscriber sendCompleted];
                        }else{
                            [subscriber sendNext:@[@(NO),@"该账号不存在！"]];
                            [subscriber sendCompleted];
                        }
                    }
                }];
                return nil;
            }];
        }];
    }
    return _selectCommand;
}

- (RACCommand *)updataCommand{
    if (!_updataCommand) {
        znWeakSelf(self)
        _updataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                znStrongSelf
                [weakSelf.userdata zn_updateWithDic:input ResultBlock:^(BOOL isSuccessful, NSError *error) {
                    if (isSuccessful) {
                        [subscriber sendNext:@[@(YES),@"修改成功"]];
                        [subscriber sendCompleted];
                    }else{
                        [subscriber sendNext:@[@(NO),@"修改失败"]];
                        [subscriber sendCompleted];
                    }
                }];
                return nil;
            }];
        }];
    }
    return _updataCommand;
}

@end

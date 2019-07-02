//
//  RPLoginDataModel.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/22.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPLoginDataModel.h"

@interface RPLoginDataModel()
@end

@implementation RPLoginDataModel

#pragma mark -----------get-----------

- (RACCommand *)loginCommand{
    if (!_loginCommand) {
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [UserData zn_selectWithDic:input block:^(NSArray * _Nonnull array, NSError * _Nonnull error) {
                    if (error) {
                        [subscriber sendNext:@[@(NO),@"网络请求出错"]];
                        [subscriber sendCompleted];
                    }else{
                        if (array.count > 0) {
                            UserData * userData = (UserData*)[array lastObject];
                            [RPConfig sharedInstance].userData = userData;
                            [subscriber sendNext:@[@(YES)]];
                            [subscriber sendCompleted];
                        }else{
                            [subscriber sendNext:@[@(NO),@"账号或者密码出错"]];
                            [subscriber sendCompleted];
                        }
                    }
                }];
                return nil;
            }];
        }];
    }
    return _loginCommand;
}

@end

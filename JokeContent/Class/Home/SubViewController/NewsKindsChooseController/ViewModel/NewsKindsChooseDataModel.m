//
//  NewsKindsChooseDataModel.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/22.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "NewsKindsChooseDataModel.h"

@implementation NewsKindsChooseDataModel

- (void)setInitData{
    NSArray * kinds = [RPConfig sharedInstance].kinds;
    if (kinds.count > 0) {
        [self setChooseWithUserData];
    }else{
        [self.kindsCommand execute:nil];
    }
}

- (void)setChooseWithUserData{
    NSArray * kinds = [RPConfig sharedInstance].kinds;
    NSString * kindIds = [RPConfig sharedInstance].userData.kindsIds;
    NSMutableArray * chooseKinds = [NSMutableArray array];
    for (NewsKindsModel * model in kinds) {
        if ([kindIds containsString:model.channelId]) {
            [chooseKinds addObject:model];
        }
    }
    [RPConfig sharedInstance].chooseKinds = [chooseKinds copy];
}

#pragma mark - get

- (RACCommand *)kindsCommand{
    if (!_kindsCommand) {
        znWeakSelf(self)
        _kindsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                znStrongSelf
//                [QZNetManager GETForm:newsKindsUrl parameters:input success:^(NSDictionary * _Nullable responseObject, NSInteger code) {
//
//                    NSArray * kinds = [NewsKindsModel mj_objectArrayWithKeyValuesArray:responseObject[@"showapi_res_body"][@"channelList"]];
//
//                    [RPConfig sharedInstance].kinds = kinds;
//
//                    if (kinds.count > 0) {
//                        [weakSelf setChooseWithUserData];
//                    }
//
//                    [subscriber sendNext:@[@(YES)]];
//                    [subscriber sendCompleted];
//                } fail:^(NSString *message, NSInteger code) {
//                    [subscriber sendNext:@[@(NO),message]];
//                    [subscriber sendCompleted];
//                }];
                [NewsKindsModel zn_findObjectWithBlock:^(NSArray * _Nonnull array, NSError * _Nonnull error) {
                    if (error) {
                        [subscriber sendNext:@[@(NO),@"获取失败"]];
                        [subscriber sendCompleted];
                    }else{
                        
                        [RPConfig sharedInstance].kinds = array;
                        
                        if (array.count > 0) {
                            [weakSelf setChooseWithUserData];
                        }
                        
                        [subscriber sendNext:@[@(YES)]];
                        [subscriber sendCompleted];
                    }
                }];
                return nil;
            }];
        }];
    }
    return _kindsCommand;
}

- (RACCommand *)upChooseCommand{
    if (!_upChooseCommand) {
        _upChooseCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSDictionary * dic = @{@"kindsIds":[RPConfig sharedInstance].userData.kindsIds
                                       };
                [[RPConfig sharedInstance].userData zn_updateWithDic:dic
                                                      ResultBlock:^(BOOL isSuccessful, NSError *error) {
                                                          if (isSuccessful) {
                                                              [subscriber sendNext:@[@(YES)]];
                                                              [subscriber sendCompleted];
                                                          }else{
                                                              [subscriber sendNext:@[@(NO),@"关注失败"]];
                                                              [subscriber sendCompleted];
                                                          }
                                                      }];
                return nil;
            }];
        }];
    }
    return _upChooseCommand;
}


@end

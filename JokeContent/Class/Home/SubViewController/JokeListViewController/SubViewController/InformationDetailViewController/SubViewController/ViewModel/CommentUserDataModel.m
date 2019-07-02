//
//  CommentUserDataModel.m
//  JokeContent
//
//  Created by 南木南木 on 2019/5/16.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "CommentUserDataModel.h"

@implementation CommentUserDataModel

#pragma mark - get

- (RACCommand *)getCommentCommand{
    if (!_getCommentCommand) {
        znWeakSelf(self)
        _getCommentCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            znStrongSelf
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [CommentUserModel zn_selectWithDic:input block:^(NSArray * _Nonnull array, NSError * _Nonnull error) {
                    if (error) {
                        [subscriber sendNext:@[@(NO)]];
                        [subscriber sendCompleted];
                    }else{
                        [weakSelf.models removeAllObjects];
                        [weakSelf.models addObjectsFromArray:array];
                        [subscriber sendNext:@[@(YES)]];
                        [subscriber sendCompleted];
                    }
                }];
                return nil;
            }];
        }];
    }
    return _getCommentCommand;
}

- (RACCommand *)commitCommand{
    if (!_commitCommand) {
        znWeakSelf(self)
        _commitCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            znStrongSelf
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                CommentUserModel * model = input;
                [model zn_addData:^(BOOL success, NSError * _Nonnull error) {
                    if (success) {
                        [subscriber sendNext:@[@(YES)]];
                        [subscriber sendCompleted];
                    }else{
                        [subscriber sendNext:@[@(NO)]];
                        [subscriber sendCompleted];
                    }
                }];
                return nil;
            }];
        }];
    }
    return _commitCommand;
}

- (NSMutableArray<CommentUserModel *> *)models{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}

@end

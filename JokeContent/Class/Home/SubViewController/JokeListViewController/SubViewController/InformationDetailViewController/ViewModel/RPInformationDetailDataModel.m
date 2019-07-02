//
//  RPInformationDataModel.m
//  RovingPodcast
//
//  Created by 郑楠楠 on 2018/4/30.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "RPInformationDetailDataModel.h"

@implementation RPInformationDetailDataModel

#pragma mark ------get-------

- (RACCommand *)thumUpCommentCommand{
    if (!_thumUpCommentCommand) {
        znWeakSelf(self)
        _thumUpCommentCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            znStrongSelf
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [ArticleThumUpModel zn_updataWithDic:input where:@{@"link":weakSelf.information.link,
                                                                @"userId":[RPConfig sharedInstance].userData.objectId
                                                                } block:^(BOOL success, NSError * _Nonnull error) {
                    if (success) {
                        [subscriber sendNext:@[@(YES)]];
                        [subscriber sendCompleted];
                    }else{
                        [subscriber sendNext:@[@(NO),@"点赞失败"]];
                        [subscriber sendCompleted];
                    }
                }];
                return nil;
            }];
        }];
    }
    return _thumUpCommentCommand;
}

- (RACCommand *)commentCommand{
    if (!_commentCommand) {
        znWeakSelf(self)
        _commentCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            znStrongSelf
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                CommentArticleModel * model = input;
                [CommentArticleModel zn_addData:^(BOOL success, NSError * _Nonnull error) {
                    if (success) {
                        [subscriber sendNext:@[@(YES)]];
                        [subscriber sendCompleted];
                    }else{
                        [subscriber sendNext:@[@(NO),@"评论失败!"]];
                        [subscriber sendCompleted];
                    }
                } object:model];
                return nil;
            }];
        }];
    }
    return _commentCommand;
}

- (RACCommand *)getCommentCommands{
    if (!_getCommentCommands) {
        znWeakSelf(self)
        _getCommentCommands = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                    znStrongSelf
                    [CommentArticleModel zn_selectWithDic:input block:^(NSArray * _Nonnull array, NSError * _Nonnull error) {
                        if (error) {
                            [subscriber sendNext:@[@(NO),@"获取失败"]];
                            [subscriber sendCompleted];
                        }else{
                            [weakSelf.ariticleComments removeAllObjects];
                            [weakSelf.ariticleComments addObjectsFromArray:array];
                            [subscriber sendNext:@[@(YES)]];
                            [subscriber sendCompleted];
                        }
                    }];
                return nil;
            }];
        }];
    }
    return _getCommentCommands;
}

- (NSMutableArray<CommentArticleModel *> *)ariticleComments{
    if (!_ariticleComments) {
        _ariticleComments = [NSMutableArray new];
    }
    return _ariticleComments;
}

- (int)pageSize{
    return 10;
}

@end

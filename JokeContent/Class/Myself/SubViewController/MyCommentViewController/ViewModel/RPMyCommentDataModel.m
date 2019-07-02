//
//  RPMyCommentDataModel.m
//  JokeContent
//
//  Created by 社会人 on 2019/5/14.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "RPMyCommentDataModel.h"

@implementation RPMyCommentDataModel

#pragma mark - get

- (RACCommand *)getCommentCommand{
    if (!_getCommentCommand) {
        znWeakSelf(self)
        _getCommentCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            znStrongSelf
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [CommentArticleModel zn_selectWithDic:@{@"fromUserID":[RPConfig sharedInstance].userData.objectId} block:^(NSArray * _Nonnull array, NSError * _Nonnull error) {
                    if (error) {
                        [subscriber sendNext:@[@(NO),@"服务器繁忙"]];
                        [subscriber sendCompleted];
                    }else{
                        NSMutableDictionary * dic = [NSMutableDictionary new];
                        for (CommentArticleModel * model in array) {
                            [dic setObject:model forKey:model.link];
                        }
                        
                        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                            [weakSelf.models addObject:obj];
                        }];
                        
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

-(NSMutableArray<CommentArticleModel *> *)models{
    if (!_models) {
        _models =[NSMutableArray array];
    }
    return _models;
}

@end

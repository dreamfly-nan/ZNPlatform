//
//  JokeListDataModel.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/17.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "JokeListDataModel.h"

@implementation JokeListDataModel

#pragma mark - get

- (NSMutableArray<NewsDetailModel *> *)informations{
    if (!_informations) {
        _informations = [NSMutableArray array];
    }
    return _informations;
}

- (int)pageNumer{
    return 10;
}

- (RACCommand *)informationCommand{
    if (!_informationCommand) {
        znWeakSelf(self)
        _informationCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                znStrongSelf
                NSDictionary * dic;
                if (weakSelf.searchText && ![weakSelf.searchText isEqualToString:@""]) {
                    dic = @{@"title":weakSelf.searchText,
                            @"page":@(weakSelf.page),
                            @"maxResult":@(weakSelf.pageNumer),
                            @"needAllList":@(0),
                            @"needContent":@(0),
                            @"needHtml":@(0)
                            };
                }else{
                    dic = @{@"channelId":weakSelf.typeId,
                            @"page":@(weakSelf.page),
                            @"maxResult":@(weakSelf.pageNumer),
                            @"needAllList":@(0),
                            @"needContent":@(0),
                            @"needHtml":@(0)
                            };
                }
                
                [ZNNetManager GETForm:newsDetailUrl parameters:dic success:^(NSDictionary * _Nullable responseObject, NSInteger code) {
                    if (weakSelf.page == 1) {
                        weakSelf.isNoMoreData = NO;
                        [weakSelf.informations removeAllObjects];
                    }

                    NSArray * items = [NewsDetailModel mj_objectArrayWithKeyValuesArray:responseObject[@"showapi_res_body"][@"pagebean"][@"contentlist"]];
                    for (NewsDetailModel * model in items) {
                        if (model.imageurls.count > 0) {
                            [weakSelf.informations addObject:model];
                        }
                    }
                    
                    if (items.count < weakSelf.pageNumer) {
                        weakSelf.isNoMoreData = YES;
                    }
                    
                    [subscriber sendNext:@[@(YES)]];
                    [subscriber sendCompleted];
                } fail:^(NSString *message, NSInteger code) {
                    [subscriber sendNext:@[@(NO),message]];
                    [subscriber sendCompleted];
                }];
                return nil;
            }];
        }];
    }
    return _informationCommand;
}

@end

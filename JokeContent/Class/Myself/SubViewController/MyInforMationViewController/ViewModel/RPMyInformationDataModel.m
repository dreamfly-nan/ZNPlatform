//
//  RPMyInformationDataModel.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/23.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "RPMyInformationDataModel.h"

@implementation RPMyInformationDataModel

- (void)upUserData{
    for (InformationItemModel * model in self.items) {
        switch (model.type) {
            case InformationItemTypeIntroduction:
                [RPConfig sharedInstance].userData.introduction = model.context;
                break;
            case InformationItemTypeNikeName:
                [RPConfig sharedInstance].userData.nickName = model.context;
                break;
        }
    }
}

- (NSDictionary* )getUserData{
    NSMutableDictionary * dic = [NSMutableDictionary new];
    for (InformationItemModel * model in self.items) {
        switch (model.type) {
            case InformationItemTypeIntroduction:
                [dic setObject:model.context forKey:@"introduction"];
                break;
            case InformationItemTypeNikeName:
                [dic setObject:model.context forKey:@"nickName"];
                break;
        }
    }
    return dic;
}

#pragma mark - get

- (RACCommand *)upUserDataCommand{
    if (!_upUserDataCommand) {
        znWeakSelf(self)
        _upUserDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                znStrongSelf
                [[RPConfig sharedInstance].userData zn_updateWithDic:[weakSelf getUserData] ResultBlock:^(BOOL isSuccessful, NSError *error) {
                    if (isSuccessful) {
                        [subscriber sendNext:@[@(YES)]];
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
    return _upUserDataCommand;
}

- (NSArray<InformationItemModel *> *)items{
    if (!_items) {
        NSString * nikeName = [RPConfig sharedInstance].userData.nickName;
        nikeName = nikeName == nil ? @"" : nikeName;
        NSString * introduction = [RPConfig sharedInstance].userData.introduction;
        introduction = introduction == nil ? @"" : introduction;
        _items = @[[InformationItemModel initWithTitle:@"昵称" context:nikeName type:InformationItemTypeNikeName],
                   [InformationItemModel initWithTitle:@"简介" context:introduction type:InformationItemTypeIntroduction]];
    }
    return _items;
}

@end

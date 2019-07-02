//
//  FeedBackDataModel.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/22.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "FeedBackDataModel.h"
#import "FeedBackModel.h"
@implementation FeedBackDataModel

#pragma mark - get

- (RACCommand *)commitFeedCommand{
    if (!_commitFeedCommand) {
        _commitFeedCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                FeedBackModel * model = input;
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
    return _commitFeedCommand;
}

@end

//
//  AppDelegate+Net.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/18.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "AppDelegate+Net.h"

@implementation AppDelegate (Net)

- (void)net_application:(UIApplication*) application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions{
    [ZNNetManager setConfigRequestSuccessBlock:^ZNResponseMessage *(id responseObject) {
        ZNResponseMessage * message = [ZNResponseMessage new];
        int code = [responseObject[@"showapi_res_code"] intValue];
        NSString * error = responseObject[@"showapi_res_error"];
        message.code = code;
        //0为成功，其他为失败
        if (code == 0) {
            message.isTrue = YES;
            message.message = @"";
        }else{
            message.isTrue = NO;
            message.message = error;
        }
        return message;
    } fail:^(NSError *error) {
        [MBProgressHUD zn_showError:@"网络出错"];
    }];
    
    znWeakSelf(self)
    [ZNNetManager setConfigParameterBlock:^NSDictionary *(NSDictionary *parameter) {
        znStrongSelf
        NSMutableDictionary * dic = [NSMutableDictionary new];
        
        if (parameter) {
            [dic addEntriesFromDictionary:parameter];
        }
        
        [dic setObject:wwyyAppId forKey:@"showapi_appid"];
        NSString * sign = [weakSelf obtainSign:dic];
        [dic setObject:sign forKey:@"showapi_sign"];
        return dic;
    }];
}

/**
 将参数的key的进行排序

 @return <#return value description#>
 */
- (NSArray<NSString *> *)obtainKeySort:(NSDictionary*) dic{
    NSMutableArray * allKeys = [NSMutableArray array];
    //将有数值的key选出来
    for (NSString * key in dic.allKeys) {
        NSString * valuse = znString(dic[key]);
        if ([[valuse class] isKindOfClass:[NSNull class]] || [valuse isEqualToString:@""]) {
            
        }else{
            [allKeys addObject:key];
        }
    }
    
    [allKeys sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    return [allKeys copy];
}

- (NSString *)obtainSign:(NSDictionary*)dic{
    NSArray * keyAlls = [self obtainKeySort:dic];
    //参数拼接
    NSMutableString * strKey = [NSMutableString new];
    for (NSString * key in keyAlls) {
        [strKey appendString:key];
        [strKey appendString:znString(dic[key])];
    }
    [strKey appendString:wwyyAppKey];
    return [NSString zn_md5:strKey];
}

@end

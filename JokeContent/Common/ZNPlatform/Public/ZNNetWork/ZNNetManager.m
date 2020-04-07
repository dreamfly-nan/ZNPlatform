//
//  ZNNetManager.m
//  ZNNavigationViewController
//
//  Created by 郑楠楠 on 2018/10/26.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "ZNNetManager.h"

@implementation ZNNetManager

/*********************************************************************************************/
/*                                       检查网络                                              */
/*********************************************************************************************/
+(void)networkReachabilityStart:(void (^)(AFNetworkReachabilityStatus status)) statusChangeBlock{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (statusChangeBlock) {
            statusChangeBlock(status);
        }
        
//        switch (status) {
//            case AFNetworkReachabilityStatusReachableViaWWAN :
//            case AFNetworkReachabilityStatusReachableViaWiFi :
//            {
//
//            }
//                break;
//            case AFNetworkReachabilityStatusUnknown:
//            case AFNetworkReachabilityStatusNotReachable:
//            {
//
//            }
//                break;
//            default:
//                break;
//        }
    }];
    [manager startMonitoring];
}

/*********************************************************************************************/
/*                                       配置项目                                              */
/*********************************************************************************************/

//设置请求头的数据
+ (void)setConfigBlock:(NSDictionary * (^)(void)) requestHeadBlock{
    if (requestHeadBlock) {
        [ZNNetRequest getManager].requestHeadBlock = requestHeadBlock;
    }
}

//设置请求参数的处理代码块
+ (void)setConfigParameterBlock:(NSDictionary * (^)(NSDictionary * parameter)) requestParameterBlock{
    if (requestParameterBlock) {
        [ZNNetRequest getManager].requestParameterBlock = requestParameterBlock;
    }
}

/**
 统一进行配置请求成功或失败后执行的代码块，
 请求成功后执行的代码块较为特殊，可做业务逻辑判断
 @param success <#success description#>
 @param fail <#fail description#>
 */
+ (void)setConfigRequestSuccessBlock:(ZNResponseMessage * (^)(id responseObject)) success
                                fail:(void (^)(NSError * error))fail{
    [ZNNetRequest getManager].requestSuccess = success;
    [ZNNetRequest getManager].requestFail = fail;
}

//请求超时设置
+ (void)setRequestTimeOut:(CGFloat)timeOut{
    [ZNNetRequest getManager].requestTimeOut = timeOut;
}

/*********************************************************************************************/
/*                                       方法                                                 */
/*********************************************************************************************/

+ (void)POST:(NSString*)url
        type:(RequestParamtersType)type
  parameters:(NSDictionary*)parameters
     success:(QZNetRequestSuccess _Nonnull)success
        fail:(QZNetRequestFail _Nonnull)fail{
    [ZNNetRequest POST:url type:type parameters:parameters success:success fail:fail];
}

+ (void)POSTJson:(NSString*)url
      parameters:(NSDictionary*)parameters
         success:(QZNetRequestSuccess _Nonnull)success
            fail:(QZNetRequestFail _Nonnull)fail{
    [self POST:url type:RequestParamtersTypeJson parameters:parameters success:success fail:fail];
}

+ (void)POSTForm:(NSString*)url
      parameters:(NSDictionary*)parameters
         success:(QZNetRequestSuccess _Nonnull)success
            fail:(QZNetRequestFail _Nonnull)fail{
    [self POST:url type:RequestParamtersTypeForm parameters:parameters success:success fail:fail];
}

+ (void)GET:(NSString*)url
       type:(RequestParamtersType)type
 parameters:(NSDictionary*)parameters
    success:(QZNetRequestSuccess _Nonnull)success
       fail:(QZNetRequestFail _Nonnull)fail{
    [ZNNetRequest GET:url type:type parameters:parameters success:success fail:fail];
}

+ (void)GETJson:(NSString*)url
     parameters:(NSDictionary*)parameters
        success:(QZNetRequestSuccess _Nonnull)success
           fail:(QZNetRequestFail _Nonnull)fail{
    [self GET:url type:RequestParamtersTypeJson parameters:parameters success:success fail:fail];
}

+ (void)GETForm:(NSString*)url
     parameters:(NSDictionary*)parameters
        success:(QZNetRequestSuccess _Nonnull)success
           fail:(QZNetRequestFail _Nonnull)fail{
    [self GET:url type:RequestParamtersTypeForm parameters:parameters success:success fail:fail];
}

+ (void)PUT:(NSString*)url
       type:(RequestParamtersType)type
 parameters:(NSDictionary*)parameters
    success:(QZNetRequestSuccess _Nonnull)success
       fail:(QZNetRequestFail _Nonnull)fail{
    [ZNNetRequest PUT:url type:type parameters:parameters success:success fail:fail];
}

+ (void)PUTJson:(NSString*)url
     parameters:(NSDictionary*)parameters
        success:(QZNetRequestSuccess _Nonnull)success
           fail:(QZNetRequestFail _Nonnull)fail{
    [self PUT:url type:RequestParamtersTypeJson parameters:parameters success:success fail:fail];
}

+ (void)PUTForm:(NSString*)url
     parameters:(NSDictionary*)parameters
        success:(QZNetRequestSuccess _Nonnull)success
           fail:(QZNetRequestFail _Nonnull)fail{
    [self PUT:url type:RequestParamtersTypeForm parameters:parameters success:success fail:fail];
}

+ (void)PATCH:(NSString*)url
         type:(RequestParamtersType)type
   parameters:(NSDictionary*)parameters
      success:(QZNetRequestSuccess _Nonnull)success
         fail:(QZNetRequestFail _Nonnull)fail{
    [ZNNetRequest PATCH:url type:type parameters:parameters success:success fail:fail];
}

+ (void)PATCHJson:(NSString*)url
       parameters:(NSDictionary*)parameters
          success:(QZNetRequestSuccess _Nonnull)success
             fail:(QZNetRequestFail _Nonnull)fail{
    [self PATCH:url type:RequestParamtersTypeJson parameters:parameters success:success fail:fail];
}

+ (void)PATCHForm:(NSString*)url
       parameters:(NSDictionary*)parameters
          success:(QZNetRequestSuccess _Nonnull)success
             fail:(QZNetRequestFail _Nonnull)fail{
    [self PATCH:url type:RequestParamtersTypeForm parameters:parameters success:success fail:fail];
}

+ (void)DEL:(NSString*)url
       type:(RequestParamtersType)type
 parameters:(NSDictionary*)parameters
    success:(QZNetRequestSuccess _Nonnull)success
       fail:(QZNetRequestFail _Nonnull)fail{
    [ZNNetRequest DEL:url type:type parameters:parameters success:success fail:fail];
}

+ (void)DELJson:(NSString*)url
     parameters:(NSDictionary*)parameters
        success:(QZNetRequestSuccess _Nonnull)success
           fail:(QZNetRequestFail _Nonnull)fail{
    [self DEL:url type:RequestParamtersTypeJson parameters:parameters success:success fail:fail];
}

+ (void)DELForm:(NSString*)url
     parameters:(NSDictionary*)parameters
        success:(QZNetRequestSuccess _Nonnull)success
           fail:(QZNetRequestFail _Nonnull)fail{
    [self DEL:url type:RequestParamtersTypeForm parameters:parameters success:success fail:fail];
}

/**
 文件上传
 
 @param urlStr url
 @param parameters 参数
 @param type 上传参数类型
 @param dataModels 文件数据
 @param progress 进度
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)updownFileWith:(NSString * _Nonnull)urlStr
  parameters:(NSDictionary * _Null_unspecified)parameters
   paramters:(RequestParamtersType)type
  dataModels:(NSArray<ZNFileModel*> * _Nonnull)dataModels
    progress:(QZNetRequestProgress)progress
     success:(QZNetRequestSuccess)success
        fail:(QZNetRequestFail)fail{
    [ZNNetRequest POST:urlStr parameters:parameters paramters:type dataModels:dataModels progress:progress success:success fail:fail];
}

/**
 文件下载
 
 @param urlStr <#urlStr description#>
 @param progress <#progress description#>
 @param destination <#success description#>
 @param completionHandler <#fail description#>
 */
+ (void)downFileWith:(NSString*)urlStr
       patameterType:(RequestParamtersType)parametersType
            progress:(QZNetRequestProgress)progress
         destination:(QZNetRequestDestination _Nonnull)destination
   completionHandler:(QZNetRequestDownCompletionHandler _Nonnull)completionHandler{
   [ZNNetRequest downFileWith:urlStr patameterType:parametersType progress:progress destination:destination completionHandler:completionHandler];
}

@end

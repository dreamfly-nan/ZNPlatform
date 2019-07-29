//
//  ZNNetManager.h
//  ZNNavigationViewController
//
//  Created by 郑楠楠 on 2018/10/26.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZNNetRequest.h"

//网络出错的通知
#define ZNRequsetNetError @"ZNNetError"

@interface ZNNetManager : NSObject

/******************************************************************
 检测网络
 ******************************************************************/
+(void)networkReachabilityStart:(void (^_Nullable)(AFNetworkReachabilityStatus status)) statusChangeBlock;

/*********************************************************************************************/
/*                                       配置项目                                              */
/*********************************************************************************************/

//设置请求头的数据
+ (void)setConfigBlock:(NSDictionary * _Nonnull(^_Nullable)(void)) requestHeadBlock;

//设置请求参数的处理代码块
+ (void)setConfigParameterBlock:(NSDictionary  * _Nonnull(^_Nullable)(NSDictionary * _Nullable parameter)) requestParameterBlock;

/**
 必须配置项
 
 
 统一进行配置请求成功或失败后执行的代码块，
 请求成功后执行的代码块较为特殊，可做业务逻辑判断
 @param success <#success description#>
 @param fail <#fail description#>
 */
+ (void)setConfigRequestSuccessBlock:(ZNResponseMessage * _Nonnull (^_Nullable)(id _Nonnull responseObject)) success
                                fail:(void (^_Nullable)(NSError * _Nonnull error))fail;

//请求超时设置
+ (void)setRequestTimeOut:(CGFloat)timeOut;

/*********************************************************************************************/
/*                                       方法                                                 */
/*********************************************************************************************/

/**
 POST请求

 @param url 请求的url
 @param type 参数的请求类型
 @param parameters 请求参数
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)POST:(NSString* _Nonnull)url
        type:(RequestParamtersType)type
  parameters:(NSDictionary* _Nullable)parameters
     success:(QZNetRequestSuccess _Nonnull)success
        fail:(QZNetRequestFail _Nonnull)fail;

/**
 GET请求
 
 @param url 请求的url
 @param type 参数的请求类型
 @param parameters 请求参数
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)GET:(NSString* _Nonnull)url
       type:(RequestParamtersType)type
 parameters:(NSDictionary* _Nullable)parameters
    success:(QZNetRequestSuccess _Nonnull)success
       fail:(QZNetRequestFail _Nonnull)fail;

/**
 POSTJson 请求

 @param url 请求的url
 @param parameters 请求参数
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)POSTJson:(NSString* _Nonnull)url
      parameters:(NSDictionary* _Nullable)parameters
         success:(QZNetRequestSuccess _Nonnull)success
            fail:(QZNetRequestFail _Nonnull)fail;

/**
 POSTForm 请求
 
 @param url 请求的url
 @param parameters 请求参数
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)POSTForm:(NSString* _Nonnull)url
      parameters:(NSDictionary* _Nullable)parameters
         success:(QZNetRequestSuccess _Nonnull)success
            fail:(QZNetRequestFail _Nonnull)fail;

/**
 GETJson 请求
 
 @param url 请求的url
 @param parameters 请求参数
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)GETJson:(NSString* _Nonnull)url
 parameters:(NSDictionary* _Nullable)parameters
    success:(QZNetRequestSuccess _Nonnull)success
       fail:(QZNetRequestFail _Nonnull)fail;

/**
 GETForm 请求
 @param url 请求的url
 @param parameters 请求参数
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)GETForm:(NSString* _Nonnull)url
     parameters:(NSDictionary* _Nullable)parameters
        success:(QZNetRequestSuccess _Nonnull)success
           fail:(QZNetRequestFail _Nonnull)fail;

/**
 PUT请求
 
 @param url 请求的url
 @param type 参数的请求类型
 @param parameters 请求参数
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)PUT:(NSString* _Nonnull)url
       type:(RequestParamtersType)type
 parameters:(NSDictionary* _Nullable)parameters
    success:(QZNetRequestSuccess _Nonnull)success
       fail:(QZNetRequestFail _Nonnull)fail;


/**
 PUTJson 请求
 @param url 请求的url
 @param parameters 请求参数
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)PUTJson:(NSString* _Nonnull)url
 parameters:(NSDictionary* _Nullable)parameters
    success:(QZNetRequestSuccess _Nonnull)success
       fail:(QZNetRequestFail _Nonnull)fail;

/**
 PUTForm 请求
 @param url 请求的url
 @param parameters 请求参数
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)PUTForm:(NSString* _Nonnull)url
     parameters:(NSDictionary* _Nullable)parameters
        success:(QZNetRequestSuccess _Nonnull)success
           fail:(QZNetRequestFail _Nonnull)fail;

/**
 PATCH请求
 
 @param url 请求的url
 @param type 参数的请求类型
 @param parameters 请求参数
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)PATCH:(NSString* _Nonnull)url
       type:(RequestParamtersType)type
 parameters:(NSDictionary* _Nullable)parameters
    success:(QZNetRequestSuccess _Nonnull)success
       fail:(QZNetRequestFail _Nonnull)fail;

/**
 PATCHJson 请求
 @param url 请求的url
 @param parameters 请求参数
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)PATCHJson:(NSString* _Nonnull)url
   parameters:(NSDictionary* _Nullable)parameters
      success:(QZNetRequestSuccess _Nonnull)success
         fail:(QZNetRequestFail _Nonnull)fail;

/**
 PATCHForm 请求
 @param url 请求的url
 @param parameters 请求参数
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)PATCHForm:(NSString* _Nonnull)url
       parameters:(NSDictionary* _Nullable)parameters
          success:(QZNetRequestSuccess _Nonnull)success
             fail:(QZNetRequestFail _Nonnull)fail;

/**
 DEL请求
 
 @param url 请求的url
 @param type 参数的请求类型
 @param parameters 请求参数
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)DEL:(NSString* _Nonnull)url
         type:(RequestParamtersType)type
   parameters:(NSDictionary* _Nullable)parameters
      success:(QZNetRequestSuccess _Nonnull)success
         fail:(QZNetRequestFail _Nonnull)fail;

/**
 DELJson 请求
 @param url 请求的url
 @param parameters 请求参数
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)DELJson:(NSString* _Nonnull)url
   parameters:(NSDictionary* _Nullable)parameters
      success:(QZNetRequestSuccess _Nonnull)success
         fail:(QZNetRequestFail _Nonnull)fail;

/**
 DELForm 请求
 @param url 请求的url
 @param parameters 请求参数
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)DELForm:(NSString* _Nonnull)url
     parameters:(NSDictionary* _Nullable)parameters
        success:(QZNetRequestSuccess _Nonnull)success
           fail:(QZNetRequestFail _Nonnull)fail;

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
    progress:(QZNetRequestProgress _Nullable)progress
     success:(QZNetRequestSuccess _Nullable)success
        fail:(QZNetRequestFail _Nullable)fail;

/**
 文件下载

 @param urlStr <#urlStr description#>
 @param progress <#progress description#>
 @param destination <#success description#>
 @param completionHandler <#fail description#>
 @return <#return value description#>
 */
+ (NSURLSessionDownloadTask *_Nonnull)downFileWith:(NSString* _Nonnull)urlStr
                                  progress:(QZNetRequestProgress _Nullable)progress
                               destination:(QZNetRequestDestination _Nullable)destination
                         completionHandler:(QZNetRequestDownCompletionHandler _Nonnull)completionHandler;


@end

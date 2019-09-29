//
//  ZNNetRequest.m
//  ZNNavigationViewController
//
//  Created by 郑楠楠 on 2018/10/27.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "ZNNetRequest.h"

@interface ZNNetRequest()
@end

@implementation ZNNetRequest

static ZNNetRequest * manager;

static AFURLSessionManager *urlSessionManager;

+ (ZNNetRequest *)getManager{
    @synchronized (self){
        if (!manager) {
            manager = [[ZNNetRequest alloc] init];
            [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"charset=UTF-8",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/plain", nil];
            NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            urlSessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        }
    }
    return manager;
}

+ (void)POST:(NSString*)url
        type:(RequestParamtersType)type
  parameters:(NSDictionary*)parameters
     success:(QZNetRequestSuccess _Nonnull)success
        fail:(QZNetRequestFail _Nonnull)fail{
    [[ZNNetRequest getManager] request:url parameters:parameters patameterType:type httpType:RequestModeTypePost success:success fail:fail];
}

+ (void)GET:(NSString*)url
       type:(RequestParamtersType)type
 parameters:(NSDictionary*)parameters
    success:(QZNetRequestSuccess _Nonnull)success
       fail:(QZNetRequestFail _Nonnull)fail{
    [[ZNNetRequest getManager] request:url parameters:parameters patameterType:type httpType:RequestModeTypeGet success:success fail:fail];
}

+ (void)PUT:(NSString*)url
       type:(RequestParamtersType)type
 parameters:(NSDictionary*)parameters
    success:(QZNetRequestSuccess _Nonnull)success
       fail:(QZNetRequestFail _Nonnull)fail{
    [[ZNNetRequest getManager] request:url parameters:parameters patameterType:type httpType:RequestModeTypePut success:success fail:fail];
}

+ (void)PATCH:(NSString*)url
         type:(RequestParamtersType)type
   parameters:(NSDictionary*)parameters
      success:(QZNetRequestSuccess _Nonnull)success
         fail:(QZNetRequestFail _Nonnull)fail{
    [[ZNNetRequest getManager] request:url parameters:parameters patameterType:type httpType:RequestModeTypePatch success:success fail:fail];
}

+ (void)DEL:(NSString*)url
       type:(RequestParamtersType)type
 parameters:(NSDictionary*)parameters
    success:(QZNetRequestSuccess _Nonnull)success
       fail:(QZNetRequestFail _Nonnull)fail{
    [[ZNNetRequest getManager] request:url parameters:parameters patameterType:type httpType:RequestModeTypeDel success:success fail:fail];
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
+ (void)POST:(NSString * _Nonnull)urlStr
  parameters:(NSDictionary * _Null_unspecified)parameters
   paramters:(RequestParamtersType)type
  dataModels:(NSArray<ZNFileModel*> * _Nonnull)dataModels
    progress:(QZNetRequestProgress)progress
     success:(QZNetRequestSuccess)success
        fail:(QZNetRequestFail)fail{
    [[self getManager] updownFileWithUrl:urlStr patameterType:type dataModels:dataModels parameters:parameters progress:progress success:success fail:fail];
}

/**
 文件下载
 
 @param urlStr <#urlStr description#>
 @param progress <#progress description#>
 @param destination <#destination description#>
 @param completionHandler <#completionHandler description#>
 */
+ (void)downFileWith:(NSString*)urlStr
       patameterType:(RequestParamtersType)parametersType
            progress:(QZNetRequestProgress)progress
         destination:(QZNetRequestDestination _Nonnull)destination
   completionHandler:(QZNetRequestDownCompletionHandler _Nonnull)completionHandler{
    [[self getManager] downFileWith:urlStr patameterType:parametersType progress:progress destination:destination completionHandler:completionHandler];
}

#pragma mark - private

- (void)downFileWith:(NSString*)urlStr
       patameterType:(RequestParamtersType)parametersType
            progress:(QZNetRequestProgress)progress
         destination:(QZNetRequestDestination _Nonnull)destination
   completionHandler:(QZNetRequestDownCompletionHandler _Nonnull)completionHandler{
    
    [self configHeadWithType:parametersType];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    NSURLSessionDownloadTask *downloadTask = [urlSessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress){
            progress(1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        }
    } destination:destination completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (completionHandler) {
            completionHandler(response,filePath,error);
        }
    }];
    //开始下载
    [downloadTask resume];
}

- (void)updownFileWithUrl:(NSString*)url
            patameterType:(RequestParamtersType)parametersType
               dataModels:(NSArray<ZNFileModel*> * _Nonnull)dataModels
               parameters:(NSDictionary *)paramters
                 progress:(QZNetRequestProgress)progress
                  success:(QZNetRequestSuccess)success
                     fail:(QZNetRequestFail)fail{
    __block ZNNetRequest * weakSelf = self;
    [self configHeadWithType:parametersType];
    
    [self POST:url parameters:paramters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (ZNFileModel * model in dataModels) {
            [formData appendPartWithFileData:model.fileData name:model.fileName fileName:model.upDownFileName mimeType:model.fileMimeType];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf requestSuccess:task responseObject:responseObject success:success fail:fail];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf requestError:error task:task fail:fail];
    }];
}

- (void)request:(NSString *)urlStr
     parameters:(NSDictionary *)paramters
  patameterType:(RequestParamtersType)parametersType
       httpType:(RequestModeType)modeType
        success:(QZNetRequestSuccess)success
           fail:(QZNetRequestFail)fail{
    
    //请求参数处理代码块
    if (self.requestParameterBlock) {
        paramters = self.requestParameterBlock(paramters);
    }
    
    __block ZNNetRequest * weakSelf = self;
    
    [self configHeadWithType:parametersType];
    
    NSURLSessionDataTask *currenttTask = nil;
    
    switch (modeType) {
        case RequestModeTypeGet:
        {
           currenttTask = [self GET:urlStr parameters:paramters progress:^(NSProgress * _Nonnull downloadProgress) {
            
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [weakSelf requestSuccess:task
                          responseObject:responseObject
                                 success:success
                                    fail:fail];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [weakSelf requestError:error
                                  task:task
                                  fail:fail];
            }];
        }
            break;
        case RequestModeTypePost:
        {
           currenttTask = [self POST:urlStr parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [weakSelf requestSuccess:task
                          responseObject:responseObject
                                 success:success
                                    fail:fail];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [weakSelf requestError:error
                                  task:task
                                  fail:fail];
                
            }];
        }
            break;
        case RequestModeTypePut:
        {
           currenttTask = [self PUT:urlStr parameters:paramters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               
                [weakSelf requestSuccess:task
                          responseObject:responseObject
                                 success:success
                                    fail:fail];
               
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [weakSelf requestError:error
                                  task:task fail:fail];
                
            }];
        }
            break;
        case RequestModeTypeDel:
        {
           currenttTask = [self DELETE:urlStr parameters:paramters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               
                [weakSelf requestSuccess:task
                          responseObject:responseObject
                                 success:success
                                    fail:fail];
               
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [weakSelf requestError:error
                                  task:task fail:fail];
                
            }];
        }
            break;
        case RequestModeTypePatch:
        {
            currenttTask = [self PATCH:urlStr parameters:paramters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [weakSelf requestSuccess:task
                          responseObject:responseObject
                                 success:success fail:fail];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [weakSelf requestError:error
                                  task:task
                                  fail:fail];
                
            }];
        }
            break;
    }
    
    if (currenttTask) {
        [self.allSessionDataTasks addObject:currenttTask];
    }
}

/**
 设置请求头
 @param parametersType 参数传输方式
 */
- (void)configHeadWithType:(RequestParamtersType) parametersType{
    if (parametersType == RequestParamtersTypeJson) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }else{
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    
    //设置请求头的参数
    if (manager.requestHeadBlock) {
        NSDictionary * dictionary = manager.requestHeadBlock();
        NSArray * keyAlls = dictionary.allKeys;
        for (int i = 0; i < dictionary.count; i ++) {
            NSString * key = keyAlls[i];
            [self.requestSerializer setValue:dictionary[key] forHTTPHeaderField:key];
        }
    }
    
    //手动通知超时时间改变
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = self.requestTimeOut > 0 ? self.requestTimeOut : 30;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
}

/**
 请求出错的处理

 @param error <#error description#>
 @param task <#task description#>
 */
- (void)requestError:(NSError*) error task:(NSURLSessionDataTask*)task fail:(QZNetRequestFail)fail{
    //发送网络请求失败的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:ZNRequsetNetError object:error];
    if (error.code == 401) {
        [self.operationQueue cancelAllOperations];
    }else{
        [self.allSessionDataTasks removeObject:task];
    }
    
    if (self.requestFail) {
        self.requestFail(error);
    }
    
    if (fail) {
        fail(@"网络异常",(long)error.code);
    }
    
}

/**
 请求成功的处理

 @param task <#task description#>
 @param responseObject <#responseObject description#>
 */
- (void)requestSuccess:(NSURLSessionDataTask*)task
        responseObject:(id)responseObject
               success:(QZNetRequestSuccess)success
                  fail:(QZNetRequestFail)fail{
    if (self.requestSuccess) {
        ZNResponseMessage * message = self.requestSuccess(responseObject);
        if (message) {
            if (message.isTrue) {
                if (success) {
                    success(responseObject,message.code);
                }
            }else{
                if (fail) {
                    fail(message.message,message.code);
                }
            }
        }else{
            if(success){
                success(responseObject,REQUEST_SUCCESS);
            }
        }
    }else{
        if(success){
         success(responseObject,REQUEST_SUCCESS);
        }
    }
}


#pragma mark - get

- (NSMutableArray<NSURLSessionDataTask *> *)allSessionDataTasks{
    if (!_allSessionDataTasks) {
        _allSessionDataTasks = [NSMutableArray new];
    }
    return _allSessionDataTasks;
}

@end

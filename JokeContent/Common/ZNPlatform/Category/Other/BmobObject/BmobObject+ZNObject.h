//
//  BmobObject+object.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/20.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "ZNFileModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface BmobObject (ZNObject)

/**
 Description
 
 @param block 查询后的回调
 */
+ (void)zn_findObjectWithBlock:(void (^)(NSArray * array, NSError * error)) block;

/**
 条件查询
 @param dic <#dic description#>
 */
+ (void)zn_selectWithDic:(NSDictionary*) dic
                block:(void (^)(NSArray * array, NSError * error)) block;

/**
 批量更新，将符合条件的数据都进行更新
 更新数据，字典中为要更新的字段,
 @param dic 要更改的字段
 @param whereDic 条件
 */
+ (void)zn_updataWithDic:(NSDictionary*) dic
                where:(NSDictionary*) whereDic
                block:(void (^)(BOOL success,NSError * error)) block;

/**
 已知对象进行数据更新操作
 */
+ (void)zn_updataWithObject:(BmobObject *) objc
                   block:(void (^)(BOOL success,NSError * error)) block;

/**
 是否属性名有设置替换
 
 @param key <#key description#>
 @return <#return value description#>
 */
+ (NSString*)zn_replaceForKey:(NSString*)key;

/**
 <#Description#>
 
 @return <#return value description#>
 */
+ (NSDictionary*)zn_replaceDic;


/**
 添加数据
 
 @param block 添加后的回调
 */
+ (void)zn_addData:(void (^)(BOOL success,NSError *error)) block
         object:(BmobObject *) object;

/**
 添加数据
 
 @param block 添加后的回调
 */
- (void)zn_addData:(void (^)(BOOL success,NSError *error)) block;

/**
 更新数据

 @param dic 需要更新的数据
 @param block 更新后的回调
 */
- (void)zn_updateWithDic:(NSDictionary*) dic
          ResultBlock:(BmobBooleanResultBlock)block;

/**
 上传文件
 @param block <#block description#>
 @param file <#dic description#>
 */
- (void)zn_upFile:(void (^)(BOOL success,NSError *error)) block
           file:(BmobFile*) file
           key:(NSString*)key;

@end

NS_ASSUME_NONNULL_END

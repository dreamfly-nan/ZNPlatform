//
//  BmobObject+object.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/20.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "BmobObject+ZNObject.h"
#import "ZNFileModel.h"

@implementation BmobObject (ZNObject)

+ (void)zn_bmobObjectToObject:(NSArray*) array
                     error:(NSError*)error
                     block:(void (^)(NSArray * array, NSError * error))block{
    NSArray * keyAlls = [self zn_propertyKeys];
    NSMutableArray * objects = [NSMutableArray new];
    for (BmobObject * objc in array) {
        NSMutableDictionary * dic = [NSMutableDictionary new];
        id objectId = [objc objectForKey:@"objectId"];
        for (NSString * key in keyAlls) {
            id idObject = @"";
            NSString * replaceKey = [self zn_replaceForKey:key];
            if (replaceKey) {
                idObject = [objc objectForKey:replaceKey];
            }else{
                idObject = [objc objectForKey:key];
            }
            //如果有数据则存储数据，无数据，则赋值为空字符串
            if (idObject) {
                [dic setObject:idObject forKey:key];
            }else{
                [dic setObject:@"" forKey:key];
            }
        }
        id model = [[self class] zn_convert:dic];
        if (objectId) {
            BmobObject * bmobObject = model;
            bmobObject.objectId = objectId;
            bmobObject.className = objc.className;
            bmobObject.ACL = objc.ACL;
            bmobObject.createdAt = objc.createdAt;
            bmobObject.updatedAt = objc.updatedAt;
        }
        [objects addObject:model];
    }
    
    if (block) {
        if (objects.count > 0) {
            block(objects,error);
        }else{
            block(nil,error);
        }
    }
}

/**
 <#Description#>
 @param block 查询后的回调
 */
+ (void)zn_findObjectWithBlock:(void (^)(NSArray * array, NSError * error)) block{
    BmobQuery * bquery = [BmobQuery queryWithClassName:NSStringFromClass([self class])];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [self zn_bmobObjectToObject:array error:error block:block];
    }];
}

/**
 条件查询
 
 @param dic <#dic description#>
 */
+ (void)zn_selectWithDic:(NSDictionary*) dic
                block:(void (^)(NSArray * array, NSError * error)) block{
    BmobQuery * bquery = [BmobQuery queryWithClassName:NSStringFromClass([self class])];
    for (NSString * key in dic.allKeys) {
        [bquery whereKey:key equalTo:dic[key]];
    }
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [self zn_bmobObjectToObject:array error:error block:block];
    }];
}

/**
 更新数据，字典中为要更新的字段
 @param dic 要更改的字段
 @param whereDic 条件
 */
+ (void)zn_updataWithDic:(NSDictionary*) dic
                where:(NSDictionary*) whereDic
                block:(void (^)(BOOL success,NSError * error)) block{
    [self zn_selectWithDic:whereDic block:^(NSArray * _Nonnull array, NSError * _Nonnull error) {
        if (array.count > 0) {
            for (BmobObject * objc in array) {
                for (NSString * key in dic.allKeys) {
                    [objc setObject:dic[key] forKey:key];
                }
                [objc updateInBackground];
            }
            if (block) {
                block(YES,error);
            }
        }else{
            if (block) {
                block(NO,error);
            }
        }
    }];
}

/**
 已知对象进行数据更新操作
 */
+ (void)zn_updataWithObject:(BmobObject *) objc
                   block:(void (^)(BOOL success,NSError * error)) block;{
    [objc updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (block) {
            block(isSuccessful,error);
        }
    }];
}

/**
 设置属性名替换
 
 @return <#return value description#>
 */
+ (NSDictionary*)zn_replaceDic{
    return nil;
}

/**
 是否属性名有设置替换
 
 @param key <#key description#>
 @return <#return value description#>
 */
+ (NSString*)zn_replaceForKey:(NSString*)key{
    if (key && ![key isEqualToString:@""]) {
        NSDictionary * dic = [self zn_replaceDic];
        if (dic) {
            for (NSString * dicKey in dic.allKeys) {
                if ([dicKey isEqualToString:key]) {
                    //返回替换的属性名
                    return dic[dicKey];
                }
            }
            return nil;
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

/**
 添加数据
 
 @param block 添加后的回调
 */
- (void)zn_addData:(void (^)(BOOL success,NSError *error)) block{
    NSDictionary * dic = [NSObject zn_getObjectData:self];
    BmobObject *gameScore = [BmobObject objectWithClassName:NSStringFromClass([self class])];
    
    for (NSString * key in dic.allKeys) {
        [gameScore setObject:dic[key] forKey:key];
    }
    
    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //进行操作
        if (block) {
            block(isSuccessful,error);
        }
    }];
}

/**
 添加数据
 
 @param block 添加后的回调
 */
+ (void)zn_addData:(void (^)(BOOL success,NSError *error)) block
         object:(BmobObject *) object{
    [object zn_addData:block];
}

/**
 更新数据
 
 @param dic 需要更新的数据
 @param block 更新后的回调
 */
- (void)zn_updateWithDic:(NSDictionary*) dic
          ResultBlock:(BmobBooleanResultBlock)block{
    for (NSString * key in dic.allKeys) {
        [self setObject:dic[key] forKey:key];
    }
    [self updateInBackgroundWithResultBlock:block];
}

/**
 上传文件
 
 @param block <#block description#>
 @param file <#dic description#>
 */
- (void)zn_upFile:(void (^)(BOOL success,NSError *error)) block
           file:(BmobFile*) file
           key:(NSString*) key{
    if (file) {
        BmobObject *gameScore = [BmobObject objectWithClassName:NSStringFromClass([self class])];
        [file saveInBackground:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                [gameScore setObject:file forKey:key];
                [gameScore saveInBackground];
                NSLog(@"file url %@",file.url);
            }
            if (block) {
                block(isSuccessful,error);
            }
        }];
    }else{
        if (block) {
            block(NO,[NSError new]);
        }
    }
}

@end

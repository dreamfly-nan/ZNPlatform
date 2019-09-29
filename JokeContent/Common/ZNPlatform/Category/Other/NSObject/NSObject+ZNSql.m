//
//  NSObject+ZNSql.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/3.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "NSObject+ZNSql.h"

@implementation NSObject (ZNSql)

/**
 若 table = nil,则用其类名作为表名
 获取sql的插入语句
 @param table <#table description#>
 @param array <#array description#>
 @return <#return value description#>
 */
+ (NSMutableString *) zn_sqlInsertWithTableName:(NSString *) table
                                   array:(NSArray *) array{
    NSMutableString * sql = [NSMutableString new];
    table == nil ? NSStringFromClass([self class]) : table;
    [sql appendFormat:@"insert into '%@'", table];
    
//    for (NSObject * object in array) {
//        NSArray * paramters = [self zn_propertyKeys];
//    }
    
    
    return sql;
}

/**
 若 table = nil,则用其类名作为表名
 获取sql的删除语句
 
 @param table <#table description#>
 @param array <#array description#>
 @return <#return value description#>
 */
+ (NSMutableString *) zn_sqlDeleteWithTableName:(NSString *)table
                                   array:(NSArray *) array{
    NSMutableString * sql = [NSMutableString new];
    return sql;
}

/**
 若 table = nil,则用其类名作为表名
 获取sql删除语句
 
 @param table <#table description#>
 @param whereDic 条件
 @return <#return value description#>
 */
+ (NSMutableString *)zn_sqlDeleteWithTableName:(NSString*) table
                                  where:(NSDictionary*) whereDic{
    NSMutableString * sql = [NSMutableString new];
    return sql;
}

/**
 若 table = nil,则用其类名作为表名
 获取sql查询语句
 
 @param table 表名
 @param whereDic 条件
 @return <#return value description#>
 */
+ (NSMutableString *)zn_sqlSelectWithTableName:(NSString*) table
                                  where:(NSDictionary*) whereDic{
    NSMutableString * sql = [NSMutableString new];
    return sql;
}

/**
 若 table = nil,则用其类名作为表名
 获取更新的sql语句
 
 @param table <#table description#>
 @param updateDic 需要更新的数据
 @param whereDic 更新的条件
 @return <#return value description#>
 */
+ (NSMutableString *)zn_sqlUpdateWithTableName:(NSString *) table
                                 update:(NSDictionary *) updateDic
                                  where:(NSDictionary *) whereDic{
    NSMutableString * sql = [NSMutableString new];
    return sql;
}

/**
 若 table = nil,则用其类名作为表名
 获取sql的插入语句
 
 @parame table 表名
 @return <#return value description#>
 */
- (NSMutableString *)zn_sqlInsertWithTableName:(NSString*) table{
    NSMutableString * sql = [NSMutableString new];
    table == nil ? NSStringFromClass([self class]) : table;
    [sql appendFormat:@"insert into '%@'", table];
    NSDictionary * dic = [[self class] zn_getObjectData:self];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
    }];
    return sql;
}

@end

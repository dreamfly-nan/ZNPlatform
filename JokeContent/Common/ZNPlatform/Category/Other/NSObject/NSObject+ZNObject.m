//
//  NSObject+object.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/17.
//  Copyright © 2019 郑楠楠. All rights reserved.
//

#import "NSObject+ZNObject.h"

#import <objc/runtime.h>

@implementation NSObject (ZNObject)
    
+ (instancetype)zn_convert:(NSDictionary*)dataSource
{
    id object = [self new];
    for (NSString *key in [dataSource allKeys]) {
        if ([[self zn_propertyKeys] containsObject:key]) {
            id propertyValue = [dataSource valueForKey:key];
            if (![propertyValue isKindOfClass:[NSNull class]]
                && propertyValue != nil) {
                [object setValue:propertyValue
                        forKey:key];
            }
        }
    }
    return object;
}
    
//获取属性列表
+ (NSArray*)zn_propertyKeys
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(self, &outCount);
    NSMutableArray *propertys = [NSMutableArray arrayWithCapacity:outCount];
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [propertys addObject:propertyName];
    }
    free(properties);
    return propertys;
}
    
+ (NSDictionary*)zn_getObjectData:(id)obj
    
    {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        unsigned int propsCount;
        
        objc_property_t *props = class_copyPropertyList([obj class], &propsCount);//获得属性列表
        
        for(int i = 0;i < propsCount; i++)
        
        {
            
            objc_property_t prop = props[i];
            
            NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];//获得属性的名称
            
            id value = [obj valueForKey:propName];//kvc读值
            
            if(value == nil)
            
            {
                
                value = [NSNull null];
                
            }
            
            else
            
            {
                
                value = [self zn_getObjectInternal:value];//自定义处理数组，字典，其他类
                
            }
            
            [dic setObject:value forKey:propName];
            
        }
        
        return dic;
}

+ (id)zn_getObjectInternal:(id)obj
    
    {
        
        if([obj isKindOfClass:[NSString class]]
           
           || [obj isKindOfClass:[NSNumber class]]
           
           || [obj isKindOfClass:[NSNull class]])
        
        {
            
            return obj;
            
        }
        
        
        
        if([obj isKindOfClass:[NSArray class]])
        
        {
            
            NSArray *objarr = obj;
            
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
            
            for(int i = 0;i < objarr.count; i++)
            
            {
                
                [arr setObject:[self zn_getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
                
            }
            
            return arr;
            
        }
        
        
        
        if([obj isKindOfClass:[NSDictionary class]])
        
        {
            
            NSDictionary *objdic = obj;
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
            
            for(NSString *key in objdic.allKeys)
            
            {
                
                [dic setObject:[self zn_getObjectInternal:[objdic objectForKey:key]] forKey:key];
                
            }
            
            return dic;
            
        }
        
        return [self zn_getObjectData:obj];
    }

/**
 获取类名
 
 @return <#return value description#>
 */
+ (NSString *)zn_ClassName{
    return NSStringFromClass([self class]);
}

//- (NSMapTable<NSString*,NSString*> *) zn_obtanMap{
//    NSMapTable * map = [NSMapTable<NSString*,NSString*> new];
//    NSDictionary * dic = [[self class] zn_getObjectData:self];
//    NSArray * keys = [[self class] zn_propertyKeys];
//    for (NSString * key in keys) {
//        id valuse = dic[key];
//        if (valuse) {
//            //key属性名
//            [map setObject:key forKey:@"name"];
//            [map setObject:valuse forKey:@"value"];
//        }
//    }
//    return map;
//}

@end

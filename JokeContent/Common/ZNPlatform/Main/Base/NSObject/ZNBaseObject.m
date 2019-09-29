//
//  ZNBaseObject.m
//  JokeContent
//
//  Created by 南木南木 on 2019/7/1.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNBaseObject.h"

@interface ZNBaseObject()

@property (nonatomic , strong) NSArray * keys;

@end

@implementation ZNBaseObject

//解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        
        Class c = self.class;
        // 截取类和父类的成员变量
        while (c && c != [NSObject class]) {
            NSMutableArray * array = [NSMutableArray new];
            unsigned int count = 0;
            Ivar *ivars = class_copyIvarList(c, &count);
            for (int i = 0; i < count; i++) {
                
                NSString *key = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
                
                id value = [aDecoder decodeObjectForKey:key];
                [array addObject:key];
                [self setValue:value forKey:key];
            }
            self.keys = [array copy];
            // 获得c的父类
            c = [c superclass];
            free(ivars);
        }
    }
    return self;
}

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    Class c = self.class;
    // 截取类和父类的成员变量
    while (c && c != [NSObject class]) {
        unsigned int count = 0;
        
        Ivar *ivars = class_copyIvarList(c, &count);
        
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            id value = [self valueForKey:key];
            
            [aCoder encodeObject:value forKey:key];
        }
        c = [c superclass];
        // 释放内存
        free(ivars);
    }
}

@end

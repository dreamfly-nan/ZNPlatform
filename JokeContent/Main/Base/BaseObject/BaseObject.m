//
//  BaseObject.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/17.
//  Copyright © 2019 社会人. All rights reserved.
//

#import "BaseObject.h"

@interface BaseObject()
    
@property (nonatomic , strong) NSArray * keyAlls;

@end

@implementation BaseObject
    
- (instancetype)init{
    if (self = [super init]) {
        NSDictionary * dic = [NSObject zn_getObjectData:self];
        self.keyAlls = dic.allKeys;
    }
    return self;
}
    
#pragma mark - public
    
- (void)save{
    NSDictionary * dic = [NSObject zn_getObjectData:self];
    [self saveAllWithDictionary:dic];
}
    
/**
 <#Description#>
 @param block 查询后的回调
 */
- (void)findObjectWithBlock:(void (^)(NSArray * array, NSError * error)) block{
    BmobQuery * bquery = [BmobQuery queryWithClassName:NSStringFromClass([self class])];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSMutableArray * objects = [NSMutableArray new];
        for (BmobObject * objc in array) {
            NSMutableDictionary * dic = [NSMutableDictionary new];
            for (NSString * key in self.keyAlls) {
                id idObject = [objc objectForKey:key];
                //如果有数据则存储数据，无数据，则赋值为空字符串
                if (idObject) {
                    [dic setObject:idObject forKey:key];
                }else{
                    [dic setObject:@"" forKey:key];
                }
            }
            id model = [[self class] zn_convert:dic];
            [objects addObject:model];
        }
        
        if (block) {
            block(objects,error);
        }
    }];
}

@end

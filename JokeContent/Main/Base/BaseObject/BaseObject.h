//
//  BaseObject.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/4/17.
//  Copyright © 2019 社会人. All rights reserved.
//

@interface BaseObject : BmobObject
    
- (void)save;
    
/**
 <#Description#>

 @param block 查询后的回调
 */
- (void)findObjectWithBlock:(void (^)(NSArray * array, NSError * error)) block;

@end

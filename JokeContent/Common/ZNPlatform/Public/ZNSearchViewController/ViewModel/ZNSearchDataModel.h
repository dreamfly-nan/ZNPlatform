//
//  ZNSearchDataModel.h
//  JokeContent
//
//  Created by 南木南木 on 2019/7/18.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZNSearchDataModel : NSObject

/**
 历史记录
 */
@property(nonatomic,strong) NSMutableArray * history;

/*! 保存历史搜索 */
- (void)saveHistory :(NSString *)text;
/*! 读取历史搜索 */
- (NSArray *)readHistory;
/*! 删除历史搜索 text为空字符则删除所有历史记录 */
- (void)deleteHistory:(NSString *)text;
/*! 历史搜索显示的行数 */
- (NSInteger)rowForCollection :(NSArray *)array;

@end

NS_ASSUME_NONNULL_END

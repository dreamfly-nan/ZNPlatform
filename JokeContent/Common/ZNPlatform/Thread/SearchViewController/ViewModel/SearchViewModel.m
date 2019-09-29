//
//  SearchViewModel.m
//  准到-ipad
//
//  Created by zhundao on 2017/9/11.
//  Copyright © 2017年 zhundao. All rights reserved.
//

#import "SearchViewModel.h"

@implementation SearchViewModel

/*! 保存历史搜索 */
- (void)saveHistory :(NSString *)text{
    NSString *historyPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"history.plist"];
    NSMutableArray *array  = [NSMutableArray arrayWithContentsOfFile:historyPath];
    if (!array) {
        array = [NSMutableArray array];
    }
    if ([array containsObject:text]) {
        return;
    }else{
        [array insertObject:text atIndex:0];
    }
    [array writeToFile:historyPath atomically:YES];
}

/*! 获取历史搜索 */
- (NSArray *)readHistory{
    NSString *historyPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"history.plist"];
    NSArray *array  = [NSArray arrayWithContentsOfFile:historyPath];
    return array;
}
/*! 删除历史搜索 */
- (void)deleteHistory:(NSString *)text{
    NSString *historyPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"history.plist"];
    NSMutableArray *array  = [NSMutableArray arrayWithContentsOfFile:historyPath];
    if (text.length>0) {
        [array removeObject:text];
    }else{
        [array removeAllObjects];
    }
    [array writeToFile:historyPath atomically:YES];
}

/*! 历史搜索高度 */
- (NSInteger)rowForCollection :(NSArray *)array{
    CGFloat width = 0;
    NSInteger row = 1;
    /*! 55为cell额外宽度 +5的边距 */
    for (NSString *str in array) {
        CGSize size = [str boundingRectWithSize:CGSizeMake(zn_AutoWidth(1000), zn_AutoHeight(30)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :zn_font(14)} context:nil].size;
        width = width +size.width+55;
        NSLog(@"width = %f",width);
        /*! 减5 时因为最后一个item不需要 + 5的边距 */
        if ((width - zn_AutoWidth(5))/(screenWidth) > 1) {
            row = row+1;
            width =size.width+zn_AutoWidth(55) ;
        }
    }
    return row>4?4:row;
}

@end

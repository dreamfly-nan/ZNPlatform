//
//  ZNTextTableCellManager.h
//  JokeContent
//
//  Created by 郑楠楠 on 2019/6/30.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZNTextCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZNTextTableCellManagerDelegate <NSObject>

/**
 业务错误提示语，如果返回为nil,则认为无错误
 @return <#return value description#>
 */
- (NSString*) tipsMessageWithModel:(ZNTextCellModel *) model;

@end

@interface ZNTextTableCellManager : NSObject

/**
 tableView的数据项
 */
@property(nonatomic,strong) NSArray<ZNTextCellModel*> * models;

/**
 提示语（ 用于拼接：title + tipsStr ，既为两者的拼接字符串）
 */
@property (copy , nonatomic) NSString * tipsStr;

/**
 cell的类型
 */
@property(nonatomic,assign) ZNTextTableViewCellType cellType;

/**
 cell底部线条的类型
 */
@property(nonatomic,assign) ZNTextTableViewCellLineType lineType;

/**
 内容靠右的显示样式
 */
@property(nonatomic,assign) ZNTextTableViewCellContentRightSpace contentType;

/**
 是否展示右边的箭头
 */
@property(nonatomic,assign) BOOL isShowArrow;

/**
 代理
 */
@property(nonatomic,weak) id<ZNTextTableCellManagerDelegate> znDelegate;

/**
 进行cell的数据装载
 @param tableview <#cell description#>
 @param model <#model description#>
 @return cell
 */
- (id)setCellWithTable:(UITableView*) tableview
          model:(ZNTextCellModel*) model;

/**
 arrDic 形式为
 {
    {@"title":@"标题",@"content":@"内容",@"placeStr":@"占位符",@"ableNilOrEmptContent":@"YES"},
    {@"title":@"标题",@"content":@"内容",@"placeStr":@"占位符",@"ableNilOrEmptContent":@"NO"}
 }

 @param arrDic <#dic description#>
 @return <#return value description#>
 */
- (NSArray<ZNTextCellModel*> *)dataWithArrDic:(NSArray<NSDictionary*> *) arrDic;

/**
 检测数据源是否完整填写,且符合业务规则，并返回提示语
 数据为空时，提示语为：title + tipsStr ，既为两者的拼接字符串
 业务错误时，为协议返回的错误提示语
 @return <#return value description#>
 */
- (NSString *)checkRuleModels;

/**
 打开查看模式,只可查看，不可编辑
 */
- (void)openLook;

/**
 关闭查看模式,恢复到原来
 */
- (void)closeLook;

@end

NS_ASSUME_NONNULL_END

//
//  ZNTextTableCellManager.m
//  JokeContent
//
//  Created by 郑楠楠 on 2019/6/30.
//  Copyright © 2019 南木南木. All rights reserved.
//

#import "ZNTextTableCellManager.h"
#import "ZNTextFieldTableViewCell.h"
#import "ZNTextTableViewCell.h"

@interface ZNTextTableCellManager()

@end

@implementation ZNTextTableCellManager

- (instancetype)init{
    if (self = [super init]) {
        self.cellType = ZNTextTableViewCellTypeLabel;
        self.lineType = ZNTextTableViewCellLineTypeWithTitle;
        self.isShowArrow = YES;
    }
    return self;
}

/**
 进行cell的数据装载
 @param tableview <#cell description#>
 @param model <#model description#>
 */
- (id)setCellWithTable:(UITableView*) tableview
                   model:(ZNTextCellModel*) model{
    switch (model.cellType) {
        case ZNTextTableViewCellTypeLabel:
        {
            ZNTextTableViewCell * cell = [tableview dequeueReusableCellWithIdentifier:[ZNTextTableViewCell idString]];
            cell.model = model;
            return cell;
        }
            break;
        case ZNTextTableViewCellTypeChoose:
        {
            
        }
            break;
        case ZNTextTableViewCellTypeTextField:
        {
            ZNTextFieldTableViewCell * cell = [tableview dequeueReusableCellWithIdentifier:[ZNTextFieldTableViewCell idString]];
            cell.model = model;
            return cell;
        }
            break;
    }
    return [UITableViewCell new];
}

- (NSArray<ZNTextCellModel*> *)dataWithArrDic:(NSArray<NSDictionary*> *) arrDic{
    if (arrDic == nil || arrDic.count <= 0) {
        return nil;
    }
    NSMutableArray * models = [NSMutableArray array];
    for (NSDictionary * dic in arrDic) {
        ZNTextCellModel * model = [ZNTextCellModel initWithCellType:self.cellType lineType:self.lineType];
        model.isShowArrow = self.isShowArrow;
        model.cellType = self.cellType;
        model.lineType = self.lineType;
        NSArray * allKeys = [dic allKeys];
        if ([allKeys containsObject:@"title"]) {
            model.title = dic[@"title"];
        }
        
        if([allKeys containsObject:@"content"]){
            model.content = dic[@"content"];
        }
        
        if([allKeys containsObject:@"isShowArrow"]){
            NSString * isShowArrow = dic[@"isShowArrow"];
            model.isShowArrow = [isShowArrow zn_StringToBool];
        }
        
        if([allKeys containsObject:@"selectType"]){
            NSString * selectType = dic[@"selectType"];
            model.selectType = [selectType zn_StringToBool];
        }
        
        if ([allKeys containsObject:@"lineType"]) {
            NSString * cellType = dic[@"lineType"];
            if ([cellType isEqualToString:@"ZNTextTableViewCellLineTypeLeft"]) {
                model.lineType = ZNTextTableViewCellLineTypeLeft;
            }else if([cellType isEqualToString:@"ZNTextTableViewCellLineTypeWithTitle"]){
                model.lineType = ZNTextTableViewCellLineTypeWithTitle;
            }else if([cellType isEqualToString:@"ZNTextTableViewCellLineTypeNone"]){
                model.lineType = ZNTextTableViewCellLineTypeNone;
            }
        }
        
        if ([allKeys containsObject:@"cellType"]) {
            NSString * cellType = dic[@"cellType"];
            if ([cellType isEqualToString:@"ZNTextTableViewCellTypeLabel"]) {
                model.cellType = ZNTextTableViewCellTypeLabel;
                
            }else if([cellType isEqualToString:@"ZNTextTableViewCellTypeTextField"]){
                model.cellType = ZNTextTableViewCellTypeTextField;
                
                if([allKeys containsObject:@"placeStr"]){
                    model.placeStr = dic[@"placeStr"];
                }
                
                if([allKeys containsObject:@"ableNilOrEmptContent"]){
                    NSString * ableNilOrEmptContent = dic[@"ableNilOrEmptContent"];
                    model.ableNilOrEmptContent = [ableNilOrEmptContent zn_StringToBool];
                }
                
            }else if([cellType isEqualToString:@"ZNTextTableViewCellTypeChoose"]){
                model.cellType = ZNTextTableViewCellTypeChoose;
                
            }
        }
        
        [models addObject:model];
    }
    self.models = [models copy];
    return self.models;
}

/**
 检测数据源，并返回提示语
 @return <#return value description#>
 */
- (NSString *)checkRuleModels{
    if (self.models.count <= 0 || self.models == nil) {
        NSLog(@"数据为空！");
        return @"数据为空！";
    }
    for (ZNTextCellModel * model in self.models) {
        if (!model.ableNilOrEmptContent) {
            if (model.content == nil || [model.content isEqualToString:@""]) {
                if (model.title) {
                    return [NSString stringWithFormat:@"%@%@",model.title,self.tipsStr];
                }
                return [NSString stringWithFormat:@"%@",self.tipsStr];
            }else{
                if (self.znDelegate && [self.znDelegate respondsToSelector:@selector(tipsMessageWithModel:)]) {
                   return [self.znDelegate tipsMessageWithModel:model];
                }
            }
        }
    }
    return nil;
}

/**
 打开查看模式,只可查看，不可编辑
 */
- (void)openLook{
    for (ZNTextCellModel * model in self.models) {
        model.look = YES;
    }
}

/**
 关闭查看模式,恢复到原来
 */
- (void)closeLook{
    for (ZNTextCellModel * model in self.models) {
        model.look = NO;
    }
}

@end

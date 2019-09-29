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
#import "ZNTextViewTableViewCell.h"

@interface ZNTextTableCellManager()

@end

@implementation ZNTextTableCellManager

- (instancetype)init{
    if (self = [super init]) {
        self.cellType = ZNTextTableViewCellTypeLabel;
        self.lineType = ZNTextTableViewCellLineTypeWithTitle;
        self.isShowArrow = YES;
        self.contentType = ZNTextTableViewCellContentRightSpaceWithArrow;
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
            ZNTextFieldTableViewCell * cell = [tableview dequeueReusableCellWithIdentifier:[ZNTextFieldTableViewCell idString]];
            cell.model = model;
            return cell;
        }
            break;
        case ZNTextTableViewCellTypeTextField:
        {
            ZNTextFieldTableViewCell * cell = [tableview dequeueReusableCellWithIdentifier:[ZNTextFieldTableViewCell idString]];
            cell.model = model;
            return cell;
        }
            break;
        case ZNTextTableViewCellTypeTextView:
        {
            ZNTextViewTableViewCell * cell = [tableview dequeueReusableCellWithIdentifier:[ZNTextViewTableViewCell idString]];
            cell.model = model;
            return cell;
        }
            break;
    }
    return [UITableViewCell new];
}

- (CGFloat)cellHeightForModel:(ZNTextCellModel *) model
                        index:(NSIndexPath*) path
                    tableView:(UITableView*) tableView{
    switch (model.cellType) {
        case ZNTextTableViewCellTypeLabel:
        {
            return [tableView cellHeightForIndexPath:path model:model keyPath:@"model" cellClass:[ZNTextTableViewCell class] contentViewWidth:screenWidth];
        }
            break;
        case ZNTextTableViewCellTypeChoose:
        {
            return [tableView cellHeightForIndexPath:path model:model keyPath:@"model" cellClass:[ZNTextFieldTableViewCell class] contentViewWidth:screenWidth];
        }
            break;
        case ZNTextTableViewCellTypeTextField:
        {
            return [tableView cellHeightForIndexPath:path model:model keyPath:@"model" cellClass:[ZNTextFieldTableViewCell class] contentViewWidth:screenWidth];
        }
            break;
        case ZNTextTableViewCellTypeTextView:
        {
            return [tableView cellHeightForIndexPath:path model:model keyPath:@"model" cellClass:[ZNTextViewTableViewCell class] contentViewWidth:screenWidth];;
        }
            break;
    }
    return zn_AutoWidth(55);
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
        model.contentType = self.contentType;
        model.selectType = self.isSelectEnable;
        model.look = self.look;
        NSArray * allKeys = [dic allKeys];
        if ([allKeys containsObject:@"title"]) {
            model.title = dic[@"title"];
        }
        
        if ([allKeys containsObject:@"look"]) {
            NSString * look = dic[@"look"];
            model.look = [look zn_StringToBool];
        }
        
        if ([allKeys containsObject:@"code"]) {
            model.code = dic[@"code"];
        }
        
        if([allKeys containsObject:@"content"]){
            NSObject * content = dic[@"content"];
            if ([content isKindOfClass:[NSArray class]] || [content isKindOfClass:[NSMutableArray class]]) {
                NSArray * contentArr = (NSArray *)content;
                NSMutableString * contentStr = [NSMutableString new];
                for (int i = 0 ; i < contentArr.count ; i ++) {
                    if (i == contentArr.count - 1 ) {
                        [contentStr appendString:[NSString stringWithFormat:@"%@",contentArr[i]]];
                    }else{
                        [contentStr appendString:[NSString stringWithFormat:@"%@\n",contentArr[i]]];
                    }
                }
                model.content = contentStr;
            }else{
                model.content = dic[@"content"];
            }
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
            }else if([cellType isEqualToString:@"ZNTextTableViewCellTypeTextView"]){
                model.cellType = ZNTextTableViewCellTypeTextView;
                
                if([allKeys containsObject:@"placeStr"]){
                    model.placeStr = dic[@"placeStr"];
                }
                
                if([allKeys containsObject:@"ableNilOrEmptContent"]){
                    NSString * ableNilOrEmptContent = dic[@"ableNilOrEmptContent"];
                    model.ableNilOrEmptContent = [ableNilOrEmptContent zn_StringToBool];
                }
            }
        }
        
        if ([allKeys containsObject:@"contentType"]) {
            NSString * type = dic[@"contentType"];
            if ([type isEqualToString:@"ZNTextTableViewCellContentRightSpaceWithArrow"]) {
                model.contentType = ZNTextTableViewCellContentRightSpaceWithArrow;
            }else if([type isEqualToString:@"ZNTextTableViewCellContentRightSpaceWithSuperView"]){
                model.contentType = ZNTextTableViewCellContentRightSpaceWithSuperView;
            }
        }
        
        [models addObject:model];
    }
    self.models = [models copy];
    return models;
}

/**
 检测数据源，并返回提示语
 @return <#return value description#>
 */
- (NSString *)checkRuleModels{
    return [self checkRuleFromModels:self.models];
}

/**
 检测数据源是否完整填写,且符合业务规则，并返回提示语
 数据为空时，提示语为：title + tipsStr ，既为两者的拼接字符串
 业务错误时，为协议返回的错误提示语
 @return <#return value description#>
 */
- (NSString *)checkRuleFromModels:(NSArray<ZNTextCellModel *>*) cellModels{
    if (cellModels.count <= 0 || cellModels == nil) {
        NSLog(@"数据为空！");
        return @"数据为空！";
    }
    //过滤为空的规则
    for (ZNTextCellModel * model in cellModels) {
        NSLog(@"model = %@",model.title);
        if (!model.ableNilOrEmptContent) {
            if (model.content == nil || [model.content isEqualToString:@""]) {
                //没有为空的权限
                if (!model.ableNilOrEmptContent) {
                    if (model.title) {
                        return [NSString stringWithFormat:@"%@%@",model.title,self.tipsStr];
                    }
                    return [NSString stringWithFormat:@"%@",self.tipsStr];
                }
            }
        }
    }
    
    //过滤用户自定义的规则
    for (ZNTextCellModel * model in cellModels) {
        if (self.znDelegate && [self.znDelegate respondsToSelector:@selector(tipsMessageWithModel:)]) {
            return [self.znDelegate tipsMessageWithModel:model];
        }
    }
    return nil;
}

/**
 打开查看模式,只可查看，不可编辑
 */
- (void)openLook{
    for (ZNTextCellModel * model in self.models) {
        if (model.cellType != ZNTextTableViewCellTypeChoose) {
            model.look = YES;
        }
        
    }
}

/**
 关闭查看模式,恢复到原来
 */
- (void)closeLook{
    for (ZNTextCellModel * model in self.models) {
        if (model.cellType != ZNTextTableViewCellTypeChoose) {
            model.look = NO;
        }
    }
}

@end
